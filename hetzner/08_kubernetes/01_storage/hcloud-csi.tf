
resource "helm_release" "hcloud_csi" {
  repository = "https://charts.hetzner.cloud"
  chart      = "hcloud-csi"
  version    = "2.13.0"

  name      = "hcloud-csi"
  namespace = "kube-system"

  # wait          = true
  # force_update  = false
  # recreate_pods = true

  depends_on = [
    kubernetes_secret.hcloud_token,
  ]
}

resource "kubernetes_secret" "hcloud_token" {
  metadata {
    name      = "hcloud"
    namespace = "kube-system"
  }
  data = {
    token = var.HCLOUD_API_TOKEN
  }
  type = "Opaque"
}