
resource "kubernetes_manifest" "istio_gateway" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "Gateway"
    metadata = {
      name      = "istio-gateway"
      namespace = "istio-system"
      annotations = {
        "networking.istio.io/service-type"                 = "NodePort"
        "traffic.sidecar.istio.io/excludeOutboundIPRanges" = "0.0.0.0/0"
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

resource "kubernetes_manifest" "istio_gateway_hpa" {
  manifest = {
    apiVersion = "autoscaling/v2"
    kind       = "HorizontalPodAutoscaler"
    metadata = {
      name      = "istio-gateway-istio-hpa"
      namespace = "istio-system"
    }
    spec = {
      scaleTargetRef = {
        apiVersion = "apps/v1"
        kind       = "Deployment"
        name       = "istio-gateway-istio"
      }
      minReplicas = 1
      maxReplicas = 4
      metrics = [
        {
          type = "Resource"
          resource = {
            name = "cpu"
            target = {
              type               = "Utilization"
              averageUtilization = 80
            }
          }
        }
      ]
    }
  }
}

# resource "kubernetes_manifest" "ingress_policy" {
#   manifest = {
#     apiVersion = "security.istio.io/v1"
#     kind       = "AuthorizationPolicy"
#     metadata = {
#       name      = "ingress-policy"
#       namespace = "istio-system"
#     }
#     spec = {
#       targetRef = {
#         kind  = "Gateway"
#         group = "gateway.networking.k8s.io"
#         name  = "istio-gateway"
#       }
#       action = "ALLOW"
#       rules = [
#         {
#           from = [
#             {
#               source = {
#                 remoteIpBlocks = ["135.181.39.124/32"]
#               }
#             }
#           ]
#         }
#       ]
#     }
#   }
# }