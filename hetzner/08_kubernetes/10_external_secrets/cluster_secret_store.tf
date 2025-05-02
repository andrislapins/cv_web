
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
            kubernetes = {
              mountPath = "kubernetes"
              role      = "external-secrets"
              serviceAccountRef = {
                name      = "external-secrets"
                namespace = "external-secrets"
              }
            }
          }
        }
      }
    }
  }
}
