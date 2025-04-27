
resource "kubernetes_manifest" "wildcard_andrefeuille_tls_certificate" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"
    metadata = {
      name      = "wildcard-andrefeuille-tls"
      namespace = "istio-system"
    }
    spec = {
      secretName = "wildcard-andrefeuille-tls" # pragma: allowlist secret
      issuerRef = {
        name = "cloudflare-issuer"
        kind = "ClusterIssuer"
      }
      commonName = "*.andrefeuille.com"
      dnsNames   = ["*.andrefeuille.com"]
    }
  }
}
