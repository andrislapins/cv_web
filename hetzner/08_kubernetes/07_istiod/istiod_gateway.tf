
resource "kubernetes_manifest" "istio_gateway" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "Gateway"
    metadata = {
      name      = "istio-gateway"
      namespace = "istio-system"
      annotations = {
        "networking.istio.io/service-type" = "NodePort"
      }
    }
    spec = {
      gatewayClassName = "istio"
      listeners = [
        {
          name     = "http"
          protocol = "HTTP"
          port     = 80
          hostname = "*.andrefeuille.com"
          allowedRoutes = {
            namespaces = {
              from = "All"
            }
          }
        },
        {
          name     = "https"
          protocol = "HTTPS"
          port     = 443
          hostname = "*.andrefeuille.com"
          allowedRoutes = {
            namespaces = {
              from = "All"
            }
          }
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                name = "wildcard-andrefeuille-tls"
              }
            ]
          }
        }
      ]
    }
  }
}