
resource "kubernetes_manifest" "istio_component_servicemonitor" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1"
    kind       = "ServiceMonitor"
    metadata = {
      name      = "istio-component-monitor"
      namespace = "istio-system"
      labels = {
        monitoring = "istio-components"
        release    = "kube-prometheus-stack"
      }
    }
    spec = {
      namespaceSelector = {
        any = true
      }
      selector = {
        matchExpressions = [
          {
            key      = "istio"
            operator = "In"
            values   = ["pilot"]
          }
        ]
      }
      jobLabel     = "istio"
      targetLabels = ["app"]
      endpoints = [
        {
          port     = "http-monitoring"
          interval = "15s"
        }
      ]
    }
  }
}
