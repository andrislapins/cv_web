
resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = var.cert_manager_namespace_name
    labels = {
      "name"                         = var.cert_manager_namespace_name
      "app.kubernetes.io/managed-by" = "terraform"
      "monitoring"                   = "prometheus"
    }
  }
}

resource "kubernetes_secret" "cloudflare_api_token" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = var.cert_manager_namespace_name
  }
  data = {
    api-token = var.CLOUDFLARE_API_TOKEN
  }
}

resource "helm_release" "cert_manager" {
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.17.1"

  name      = "cert-manager"
  namespace = var.cert_manager_namespace_name

  values = [templatefile("${path.module}/files/cert-manager.tpl.yaml", {
    install_crds = true
    fs_group     = 1001
  })]
}