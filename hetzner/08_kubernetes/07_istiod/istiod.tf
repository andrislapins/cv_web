
# resource "kubernetes_namespace" "istio_system" {
#   metadata {
#     name = "istio-system"
#     labels = {
#       "name"                         = "istio-system"
#       "app.kubernetes.io/managed-by" = "terraform"
#       "monitoring"                   = "prometheus"
#     }
#   }
# }

resource "helm_release" "istiod" {
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"
  version    = "1.25.2"

  name      = "istiod"
  namespace = "istio-system"

  values = [templatefile("${path.module}/files/istiod.tpl.yaml", {
    pilot_gw_api = "true"
    })
  ]
}
