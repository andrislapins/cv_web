
resource "kubernetes_namespace" "external_secrets" {
  metadata {
    name = "external-secrets"
    labels = {
      "name"                         = "external-secrets"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "kubernetes_service_account" "external_secrets" {
  metadata {
    name      = "external-secrets"
    namespace = "external-secrets"
  }
}

resource "helm_release" "external_secrets" {
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "0.16.1"

  name      = "external-secrets"
  namespace = "external-secrets"

  values = [
    templatefile("${path.module}/files/external_secrets.tpl.yaml", {})
  ]
}