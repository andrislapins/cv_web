
# resource "helm_release" "istio_base" {
#   repository = "https://istio-release.storage.googleapis.com/charts"
#   chart      = "base"
#   version    = "1.25.2"

#   name      = "istio-base"
#   namespace = "istio-system"

#   values = [templatefile("${path.module}/files/istio-base.tpl.yaml",
#     {
#       default_revision = "default"
#     }
#     )
#   ]
# }