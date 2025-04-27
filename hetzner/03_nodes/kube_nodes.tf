
resource "hcloud_server" "kube_node" {
  count       = 3
  name        = "kube-node-${count.index + 1}"
  image       = "ubuntu-24.04"
  server_type = "cax21"
  datacenter  = "hel1-dc2"
  ssh_keys    = ["k8s_admin_ssh_key"]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  network {
    network_id = data.terraform_remote_state.network.outputs.kube_private_network_id
    ip         = "172.16.0.10${count.index + 1}"
  }
}
