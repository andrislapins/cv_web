

resource "kubernetes_namespace" "grafana" {
  metadata {
    name = "grafana"
    labels = {
      "name"                         = "grafana"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "kubernetes_secret" "grafana_admin" {
  metadata {
    name      = "grafana-admin-credentials"
    namespace = "grafana"
  }
  data = {
    admin-user     = "admin"
    admin-password = var.GRAFANA_ADMIN_PASSWORD
  }
  type = "Opaque"
}

resource "helm_release" "grafana" {
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "8.11.3"

  name      = "grafana"
  namespace = "grafana"

  values = [
    templatefile("${path.module}/files/grafana.tpl.yaml", {
      subdomain              = "grafana"
      domain                 = "andrefeuille.com"
      storage_class          = "hcloud-volumes"
      grafana_admin_password = var.GRAFANA_ADMIN_PASSWORD
    })
  ]

  depends_on = [
    kubernetes_secret.grafana_admin,
    kubernetes_config_map.grafana_dashboard_kubernetes_views_global,
    kubernetes_config_map.grafana_dashboard_kubernetes_views_nodes,
    kubernetes_config_map.grafana_dashboard_kubernetes_views_namespaces,
    kubernetes_config_map.grafana_dashboard_kubernetes_views_pods,
    kubernetes_config_map.grafana_dashboard_istio_control_plane,
    kubernetes_config_map.grafana_dashboard_istio_mesh,
    kubernetes_config_map.grafana_dashboard_istio_workload
  ]
}