
resource "kubernetes_namespace" "loki" {
  metadata {
    name = "loki"
    labels = {
      "name"                         = "loki"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "loki" {
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = "6.29.0"

  name      = "loki"
  namespace = "loki"

  values = [
    templatefile("${path.module}/files/loki.tpl.yaml", {
      storage_class = "hcloud-volumes"
    })
  ]
}