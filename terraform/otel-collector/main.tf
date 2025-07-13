resource "helm_release" "otel_collector" {
  name       = "otel-collector"
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-collector"
  namespace  = "default"

  set {
    name  = "mode"
    value = "deployment"
  }

  set {
    name  = "config"
    value = file("${path.module}/config.yaml")
  }
}