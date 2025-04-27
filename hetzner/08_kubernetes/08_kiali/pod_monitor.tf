
resource "kubernetes_manifest" "istio_proxy_podmonitor" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1"
    kind       = "PodMonitor"
    metadata = {
      name      = "envoy-stats-monitor"
      namespace = "istio-system"
      labels = {
        release    = "kube-prometheus-stack"
        monitoring = "istio-proxies"
      }
    }
    spec = {
      namespaceSelector = {
        any = true
      }
      selector = {
        matchExpressions = [
          {
            key      = "security.istio.io/tlsMode"
            operator = "Exists"
          },
          {
            key      = "istio-prometheus-ignore"
            operator = "DoesNotExist"
          }
        ]
      }
      podMetricsEndpoints = [
        {
          port     = "http-envoy-prom"
          path     = "/stats/prometheus"
          interval = "15s"
          relabelings = [
            {
              action       = "keep"
              sourceLabels = ["__meta_kubernetes_pod_container_name"]
              regex        = "istio-proxy"
            },
            {
              action       = "replace"
              sourceLabels = ["__meta_kubernetes_namespace"]
              targetLabel  = "namespace"
            },
            {
              action       = "replace"
              sourceLabels = ["__meta_kubernetes_pod_name"]
              targetLabel  = "pod"
            }
          ]
        }
      ]
    }
  }
}
