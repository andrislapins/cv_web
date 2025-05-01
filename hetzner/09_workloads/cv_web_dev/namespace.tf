
resource "kubernetes_namespace" "ns" {
  metadata {
    name = local.app_namespace
    labels = {
      "name"                         = local.app_namespace
      "app.kubernetes.io/managed-by" = "terraform"
      "istio-injection"              = "disabled"
    }
  }
}