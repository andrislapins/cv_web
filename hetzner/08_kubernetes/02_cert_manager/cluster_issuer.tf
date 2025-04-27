

resource "kubernetes_manifest" "clusterissuer_cloudflare_issuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = var.cert_manager_issuer
    }
    "spec" = {
      "acme" = {
        "email" = var.CLOUDFLARE_ADMIN_EMAIL
        "privateKeySecretRef" = {
          "name" = "cloudflare-issuer-account-key"
        }
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "solvers" = [
          {
            "dns01" = {
              "cloudflare" = {
                "apiTokenSecretRef" = {
                  "key"  = "api-token"
                  "name" = kubernetes_secret.cloudflare_api_token.metadata.0.name
                }
              }
            }
          },
        ]
      }
    }
  }

  depends_on = [helm_release.cert_manager]
}