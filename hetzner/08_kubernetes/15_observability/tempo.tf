
resource "kubernetes_namespace" "tempo" {
  metadata {
    name = "tempo"
    labels = {
      "name"                         = "tempo"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "tempo" {
  repository = "https://grafana.github.io/helm-charts"
  chart      = "tempo"
  version    = "1.19.0"

  name      = "tempo"
  namespace = "tempo"

  values = [
    templatefile("${path.module}/files/tempo.tpl.yaml", {
      storage_class = "hcloud-volumes"
    })
  ]
}
