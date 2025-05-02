
resource "helm_release" "postgresql" {
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  version    = "16.6.3"

  name      = "postgresql"
  namespace = local.app_namespace

  values = [templatefile("${path.module}/files/postgresql.tpl.yaml", {
    postgres_password          = random_password.postgres_password.result
    app_user_password          = random_password.app_user_password.result
    app_user_flyway_password   = random_password.app_user_flyway_password.result
    app_user_temporal_password = random_password.app_user_temporal_password.result
    storage_class              = "hcloud-volumes"
    storage_size               = "15Gi"
    metrics                    = "true"
  })]
}