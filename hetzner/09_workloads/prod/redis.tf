
resource "helm_release" "redis" {
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "19.5.2"

  name      = "redis"
  namespace = local.app_namespace

  values = [templatefile("${path.module}/files/redis.tpl.yaml", {
    redis_password = "redis" # pragma: allowlist secret
    storage_class  = "hcloud-volumes"
    storage_size   = "8Gi"
    metrics        = "false"
  })]
}