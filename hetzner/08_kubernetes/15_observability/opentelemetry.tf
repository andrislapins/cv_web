
resource "kubernetes_namespace" "opentelemetry" {
  metadata {
    name = "opentelemetry"
    labels = {
      "name"                         = "opentelemetry"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "opentelemetry_collector" {
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-collector"
  version    = "0.117.3"

  name      = "otel"
  namespace = "opentelemetry"

  values = [templatefile("${path.module}/files/otel_collector.tpl.yaml",
    {}
    )
  ]
}

resource "helm_release" "opentelemetry_operator" {
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-operator"
  version    = "0.82.0"

  name      = "otel-opentelemetry-operator"
  namespace = "opentelemetry"

  values = [templatefile("${path.module}/files/otel_operator.tpl.yaml",
    {}
    )
  ]
}