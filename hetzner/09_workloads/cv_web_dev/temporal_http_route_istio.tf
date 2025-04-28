
resource "kubernetes_manifest" "temporal_http_route_istio_http" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "temporal-istio-route-http"
      namespace = local.app_namespace
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
        "temporal-${var.env}.andrefeuille.com"
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
              name = "temporal-web"
              port = 8080
            }
          ]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "temporal_http_route_istio_https" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "temporal-istio-route-https"
      namespace = local.app_namespace
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
        "temporal-${var.env}.andrefeuille.com"
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
              name = "temporal-web"
              port = 8080
            }
          ]
        }
      ]
    }
  }
}
