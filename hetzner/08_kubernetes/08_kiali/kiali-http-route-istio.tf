
resource "kubernetes_manifest" "kiali_istio_route_http" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "kiali-istio-route-http"
      namespace = "istio-system"
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
        "kiali.andrefeuille.com"
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
              name = "kiali"
              port = 20001
            }
          ]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "kiali_istio_route_https" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "kiali-istio-route-https"
      namespace = "istio-system"
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
        "kiali.andrefeuille.com"
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
              name = "kiali"
              port = 20001
            }
          ]
        }
      ]
    }
  }
}