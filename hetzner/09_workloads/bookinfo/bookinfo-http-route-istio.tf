
resource "kubernetes_manifest" "bookinfo_istio_route_http" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "bookinfo-istio-route-http"
      namespace = "bookinfo"
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
        "bookinfo.andrefeuille.com"
      ]
      rules = [
        {
          matches = [
            {
              path = {
                type  = "Exact"
                value = "/productpage"
              }
            },
            {
              path = {
                type  = "PathPrefix"
                value = "/static"
              }
            },
            {
              path = {
                type  = "Exact"
                value = "/login"
              }
            },
            {
              path = {
                type  = "Exact"
                value = "/logout"
              }
            },
            {
              path = {
                type  = "PathPrefix"
                value = "/api/v1/products"
              }
            }
          ]
          backendRefs = [
            {
              name = "productpage"
              port = 9080
            }
          ]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "bookinfo_istio_route_https" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "bookinfo-istio-route-https"
      namespace = "bookinfo"
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
        "bookinfo.andrefeuille.com"
      ]
      rules = [
        {
          matches = [
            {
              path = {
                type  = "Exact"
                value = "/productpage"
              }
            },
            {
              path = {
                type  = "PathPrefix"
                value = "/static"
              }
            },
            {
              path = {
                type  = "Exact"
                value = "/login"
              }
            },
            {
              path = {
                type  = "Exact"
                value = "/logout"
              }
            },
            {
              path = {
                type  = "PathPrefix"
                value = "/api/v1/products"
              }
            }
          ]
          backendRefs = [
            {
              name = "productpage"
              port = 9080
            }
          ]
        }
      ]
    }
  }
}