
resource "kubernetes_namespace" "ns" {
  metadata {
    name = "bookinfo"
    labels = {
      "name"                         = "bookinfo"
      "app.kubernetes.io/managed-by" = "terraform"
      "monitoring"                   = "prometheus"
      "istio-injection"              = "enabled"
    }
  }
}