
resource "kubernetes_namespace" "external_dns" {
  metadata {
    name = var.external_dns_namespace_name
    labels = {
      "name"                         = var.external_dns_namespace_name
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "external_dns" {
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = "7.3.0"

  name      = "external-dns"
  namespace = var.external_dns_namespace_name

  values = [templatefile("${path.module}/files/external-dns.tpl.yaml", {
    cloudflare_token = var.CLOUDFLARE_API_TOKEN
    cloudflare_email = var.CLOUDFLARE_ADMIN_EMAIL
    domain           = var.domain
    env              = var.env
  })]
}