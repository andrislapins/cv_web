
resource "kubernetes_manifest" "istio_gateway_class" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "GatewayClass"
    metadata = {
      name = "istio"
    }
    spec = {
      controllerName = "istio.io/gateway-controller"
    }
  }

  timeouts {
    delete = "5m"
  }
}
