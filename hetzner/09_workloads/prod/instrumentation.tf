resource "kubernetes_manifest" "otel_instrumentation" {
  manifest = {
    apiVersion = "opentelemetry.io/v1alpha1"
    kind       = "Instrumentation"
    metadata = {
      name      = "java-instrumentation"
      namespace = local.app_namespace
    }
    spec = {
      exporter = {
        endpoint = "http://otel-opentelemetry-collector.opentelemetry.svc.cluster.local:4318"
      }
      propagators = ["tracecontext", "baggage"]
      sampler = {
        type = "parentbased_always_on"
        # type = "parentbased_traceidratio"
        # argument = var.otel_trace_ratio
      }
      java = {
        env = [
          {
            name  = "OTEL_RESOURCE_ATTRIBUTES"
            value = "service.name=${local.app_name}-app,service.namespace=${local.app_namespace}"
          },
          {
            name  = "OTEL_EXPORTER_OTLP_PROTOCOL"
            value = "http/protobuf"
          },
          {
            name  = "OTEL_TRACES_EXPORTER"
            value = "otlp"
          },
          {
            name  = "OTEL_METRICS_EXPORTER"
            value = "otlp"
          },
          {
            name  = "OTEL_LOGS_EXPORTER"
            value = "otlp"
          },
          {
            name  = "OTEL_JAVA_INSTRUMENTATION_LOGGING_CAPTURE_ENABLED"
            value = "true"
          },
          {
            name  = "OTEL_JAVA_INSTRUMENTATION_LOGGING_FORMATTER"
            value = "json"
          },
          # {
          #   name  = "OTEL_METRICS_EXEMPLAR_ENABLED"
          #   value = "true"
          # },
          # {
          #   name  = "OTEL_JAVA_INSTRUMENTATION_LOGGING_CAPTURE_BODY_MAX_SIZE"
          #   value = "4096" # 32768
          # },
          # {
          #   name  = "OTEL_JAVA_INSTRUMENTATION_LOGGING_CAPTURE_MDC_CARDINAL_MAX"
          #   value = "64"
          # }
        ]
      }
    }
  }
}