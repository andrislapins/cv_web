
# resource "kubernetes_manifest" "istio_gateway_ip_whitelist" {
#   manifest = {
#     apiVersion = "security.istio.io/v1beta1"
#     kind       = "AuthorizationPolicy"
#     metadata = {
#       name      = "allow-only-whitelist"
#       namespace = "istio-system"
#     }
#     spec = {
#       selector = {
#         matchLabels = {
#           "gateway.networking.k8s.io/gateway-name" = "istio-gateway"
#         }
#       }
#       action = "ALLOW"
#       rules = [
#         {
#           from = [
#             {
#               source = {
#                 ipBlocks = [
#                   "${data.external.what_is_current_ip.result["internet_ip"]}"
#                 ]
#               }
#             }
#           ]
#         }
#       ]
#     }
#   }
# }
