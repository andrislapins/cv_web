
resource "kubernetes_manifest" "vault_istio_route_http" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "vault-istio-route-http"
      namespace = "vault"
    }
    spec = {
      parentRefs = [
        {
          name        = "istio-gateway"
          namespace   = "istio-system"
          sectionName = "http"
        }
      ]
      hostnames = [
        "vault.andrefeuille.com"
      ]
      rules = [
        {
          matches = [
            {
              path = {
                type  = "PathPrefix"
                value = "/"
              }
            }
          ]
          backendRefs = [
            {
              name = "vault-ui"
              port = 8200
            }
          ]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "vault_istio_route_https" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "vault-istio-route-https"
      namespace = "vault"
    }
    spec = {
      parentRefs = [
        {
          name        = "istio-gateway"
          namespace   = "istio-system"
          sectionName = "https"
        }
      ]
      hostnames = [
        "vault.andrefeuille.com"
      ]
      rules = [
        {
          matches = [
            {
              path = {
                type  = "PathPrefix"
                value = "/"
              }
            }
          ]
          backendRefs = [
            {
              name = "vault-ui"
              port = 8200
            }
          ]
        }
      ]
    }
  }
}
