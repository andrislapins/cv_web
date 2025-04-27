
###
### Get the git repo root path
###

data "external" "git_repo_root" {
  program = ["bash", "-c", "echo '{\"git_root\": \"'$(git rev-parse --show-toplevel)'\"}'"]
}

###
### Generate hosts.yaml and cluster-config.yaml
###

data "template_file" "hosts_yaml" {
  template = file("${path.module}/templates/hosts.tpl.yaml")
  vars = {
    nodes = jsonencode(data.terraform_remote_state.nodes.outputs.kube_nodes_public_ips)
  }
}

resource "local_file" "hosts_yaml" {
  content  = data.template_file.hosts_yaml.rendered
  filename = "${data.external.git_repo_root.result.git_root}/kubespray/clusters/kubernetes-node-network/hosts.yaml"
}

data "template_file" "cluster_config_yaml" {
  template = file("${path.module}/templates/cluster-config.tpl.yaml")
  vars = {
    hcloud_api_token        = var.HCLOUD_API_TOKEN
    api_server_lb_subdomain = var.api_server_lb_subdomain
    domain                  = var.domain
  }
}

resource "local_file" "cluster_config_yaml" {
  content  = data.template_file.cluster_config_yaml.rendered
  filename = "${data.external.git_repo_root.result.git_root}/kubespray/clusters/kubernetes-node-network/cluster-config.yaml"
}

###
### Run Kubespray playbook
###

resource "null_resource" "run_kubespray" {
  depends_on = [
    local_file.hosts_yaml,
    local_file.cluster_config_yaml
  ]

  triggers = {
    hosts_yaml_hash          = filesha256(local_file.hosts_yaml.filename)
    cluster_config_yaml_hash = filesha256(local_file.cluster_config_yaml.filename)
  }

  provisioner "local-exec" {
    working_dir = "${data.external.git_repo_root.result.git_root}/kubespray/kubespray"
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
      export ANSIBLE_FORCE_COLOR=1 && \
      export ANSIBLE_HOST_KEY_CHECKING=False && \
      . ../.venv/bin/activate && \
      ansible-playbook \
        --inventory ../clusters/kubernetes-node-network/hosts.yaml \
        --extra-vars "@../clusters/kubernetes-node-network/cluster-config.yaml" \
        --become --become-user=root \
        cluster.yml
    EOT
  }
}

#
resource "null_resource" "fetch_kubeconfig" {
  depends_on = [null_resource.run_kubespray]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]

    command = <<EOT
      echo "📥 Fetching kubeconfig from first control plane node..." && \
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
        root@${jsondecode(data.template_file.hosts_yaml.vars.nodes)["kube-node-1"]}:/etc/kubernetes/admin.conf \
        "${data.external.git_repo_root.result.git_root}/kubespray/.kube/config" && \
      echo "🔧 Patching server to use LB DNS..." && \
      yq eval '(.clusters[] | select(.name == "cluster.local") | .cluster.server) = "https://hcloud-lb-api-server.andrefeuille.com:6443"' -i \
        "${data.external.git_repo_root.result.git_root}/kubespray/.kube/config" && \
      echo "✅ Kubeconfig saved to ${data.external.git_repo_root.result.git_root}/kubespray/.kube/config"
    EOT
  }
}

resource "null_resource" "verify_k8s_cluster" {
  depends_on = [null_resource.fetch_kubeconfig]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
      export KUBECONFIG="${data.external.git_repo_root.result.git_root}/kubespray/.kube/config" && \
      echo "🔍 Verifying cluster connectivity..." && \
      kubectl get nodes -o wide && \
      echo "✅ Kubernetes cluster is up and responding!"
      cp ${data.external.git_repo_root.result.git_root}/kubespray/.kube/config ~/.kube/config
    EOT
  }
}

output "kubeconfig_path" {
  value = "${data.external.git_repo_root.result.git_root}/kubespray/.kube/config"
}