

resource "kubernetes_namespace" "grafana" {
  metadata {
    name = "grafana"
    labels = {
      "name"                         = "grafana"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "grafana" {
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "8.11.3"

  name      = "grafana"
  namespace = "grafana"

  values = [
    templatefile("${path.module}/files/grafana.tpl.yaml", {
      subdomain     = "grafana"
      domain        = "andrefeuille.com"
      storage_class = "hcloud-volumes"
    })
  ]

  depends_on = [
    kubernetes_config_map.grafana_dashboard_kubernetes_views_global,
    kubernetes_config_map.grafana_dashboard_kubernetes_views_nodes,
    kubernetes_config_map.grafana_dashboard_kubernetes_views_namespaces,
    kubernetes_config_map.grafana_dashboard_kubernetes_views_pods
  ]
}