
###
### Grafana Dashboards
###

resource "kubernetes_config_map" "grafana_dashboard_kubernetes_views_global" {
  metadata {
    name      = "grafana-dashboard-kubernetes-views-global"
    namespace = kubernetes_namespace.grafana.metadata[0].name
    labels = {
      grafana_dashboard = "true"
    }
  }
  data = {
    "grafana-dashboard-kubernetes-views-global.json" = file("${path.module}/grafana_dashboards/Kubernetes_Views_Global_15757_rev43.json")
  }
}

resource "kubernetes_config_map" "grafana_dashboard_kubernetes_views_nodes" {
  metadata {
    name      = "grafana-dashboard-kubernetes-views-nodes"
    namespace = kubernetes_namespace.grafana.metadata[0].name
    labels = {
      grafana_dashboard = "true"
    }
  }
  data = {
    "grafana-dashboard-kubernetes-views-nodes.json" = file("${path.module}/grafana_dashboards/Kubernetes_Views_Nodes-1744454667711_2.json")
  }
}

resource "kubernetes_config_map" "grafana_dashboard_kubernetes_views_namespaces" {
  metadata {
    name      = "grafana-dashboard-kubernetes-views-namespaces"
    namespace = kubernetes_namespace.grafana.metadata[0].name
    labels = {
      grafana_dashboard = "true"
    }
  }
  data = {
    "grafana-dashboard-kubernetes-views-namespaces.json" = file("${path.module}/grafana_dashboards/Kubernetes_Views_Namespaces_15758_rev42.json")
  }
}

resource "kubernetes_config_map" "grafana_dashboard_kubernetes_views_pods" {
  metadata {
    name      = "grafana-dashboard-kubernetes-views-pods"
    namespace = kubernetes_namespace.grafana.metadata[0].name
    labels = {
      grafana_dashboard = "true"
    }
  }
  data = {
    "grafana-dashboard-kubernetes-views-pods.json" = file("${path.module}/grafana_dashboards/Kubernetes_Views_Pods_15760_rev36.json")
  }
}

resource "kubernetes_config_map" "grafana_dashboard_istio_control_plane" {
  metadata {
    name      = "grafana-dashboard-istio-control-plane"
    namespace = kubernetes_namespace.grafana.metadata[0].name
    labels = {
      grafana_dashboard = "true"
    }
  }
  data = {
    "grafana-dashboard-istio-control-plane.json" = file("${path.module}/grafana_dashboards/Istio_Control_Plane_Dashboard_7645_rev254.json")
  }
}

resource "kubernetes_config_map" "grafana_dashboard_istio_mesh" {
  metadata {
    name      = "grafana-dashboard-istio-mesh"
    namespace = kubernetes_namespace.grafana.metadata[0].name
    labels = {
      grafana_dashboard = "true"
    }
  }
  data = {
    "grafana-dashboard-istio-mesh.json" = file("${path.module}/grafana_dashboards/Istio_Mesh_Dashboard_7639_rev254.json")
  }
}

resource "kubernetes_config_map" "grafana_dashboard_istio_workload" {
  metadata {
    name      = "grafana-dashboard-istio-workload"
    namespace = kubernetes_namespace.grafana.metadata[0].name
    labels = {
      grafana_dashboard = "true"
    }
  }
  data = {
    "grafana-dashboard-istio-workload.json" = file("${path.module}/grafana_dashboards/Istio_Workload_Dashboard_7630_rev254.json")
  }
}