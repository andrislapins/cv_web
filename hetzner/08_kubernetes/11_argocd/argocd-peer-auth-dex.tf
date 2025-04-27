
resource "kubernetes_manifest" "dex_server_disable_mtls" {
  manifest = {
    "apiVersion" = "security.istio.io/v1beta1"
    "kind"       = "PeerAuthentication"
    "metadata" = {
      "name"      = "dex-server-disable-mtls"
      "namespace" = "argo-cd"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name" = "argocd-dex-server"
        }
      }
      "mtls" = {
        "mode" = "DISABLE"
      }
    }
  }
}