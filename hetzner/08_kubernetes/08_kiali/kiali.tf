
resource "kubernetes_namespace" "kiali_operator" {
  metadata {
    name = "kiali-operator"
    labels = {
      "name"                         = "kiali-operator"
      "app.kubernetes.io/managed-by" = "terraform"
      "monitoring"                   = "prometheus"
    }
  }
}

resource "helm_release" "kiali" {
  repository = "https://kiali.org/helm-charts"
  chart      = "kiali-operator"
  version    = "2.8.0"

  name      = "kiali-operator"
  namespace = "kiali-operator"

  values = [templatefile("${path.module}/files/kiali.tpl.yaml", {
    cr_create     = true
    cr_namespace  = "istio-system"
    auth_strategy = "anonymous"
  })]
}