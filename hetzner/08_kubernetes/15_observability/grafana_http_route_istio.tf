
resource "kubernetes_manifest" "grafana_istio_route_http" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "grafana-istio-route-http"
      namespace = "grafana"
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
        "grafana.andrefeuille.com"
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
              name = "grafana"
              port = 80
            }
          ]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "grafana_istio_route_https" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "grafana-istio-route-https"
      namespace = "grafana"
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
        "grafana.andrefeuille.com"
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
              name = "grafana"
              port = 80
            }
          ]
        }
      ]
    }
  }
}
