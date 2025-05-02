
variable "HASHICORP_VAULT_TOKEN" {
  description = "The token to authenticate with Vault"
  type        = string
}

resource "kubernetes_secret" "vault_token" {
  metadata {
    name      = "vault-token"
    namespace = "external-secrets"
  }
  data = {
    token = var.HASHICORP_VAULT_TOKEN
  }
  type = "Opaque"
}

resource "kubernetes_manifest" "vault_cluster_secret_store" {
  manifest = {
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ClusterSecretStore"
    metadata = {
      name = "vault-backend"
    }
    spec = {
      provider = {
        vault = {
          server  = "https://vault.andrefeuille.com"
          path    = "kv"
          version = "v2"
          auth = {
            tokenSecretRef = {
              name      = kubernetes_secret.vault_token.metadata[0].name
              namespace = "external-secrets"
              key       = "token"
            }
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_secret.vault_token
  ]
}