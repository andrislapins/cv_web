
resource "kubernetes_namespace" "kube_prometheus_stack" {
  metadata {
    name = "kube-prometheus-stack"
    labels = {
      "name"                         = "kube-prometheus-stack"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "kube_prometheus_stack" {
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "70.4.2"

  name      = "kube-prometheus-stack"
  namespace = "kube-prometheus-stack"

  values = [
    templatefile("${path.module}/files/kube-prometheus-stack.tpl.yaml", {
      subdomain_prometheus   = "prometheus"
      subdomain_alertmanager = "alertmanager"
      domain                 = "andrefeuille.com"
      storage_class          = "hcloud-volumes"
    })
  ]
}