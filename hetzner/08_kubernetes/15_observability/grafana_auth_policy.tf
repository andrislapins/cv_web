# resource "kubernetes_manifest" "ip_whitelist_policy" {
#   manifest = {
#     apiVersion = "security.istio.io/v1beta1"
#     kind       = "AuthorizationPolicy"
#     metadata = {
#       name      = "ip-whitelist-policy"
#       namespace = "grafana"
#     }
#     spec = {
#       selector = {
#         matchLabels = {
#           "app.kubernetes.io/name": "grafana"
#         }
#       }
#       action = "ALLOW"
#       rules = [
#         {
#           from = [
#             {
#               source = {
#                 ipBlocks = [
#                   "80.89.73.56/32",
#                   "10.233.65.147/32"
#                 ]
#               }
#             }
#           ]
#         }
#       ]
#     }
#   }
# }
