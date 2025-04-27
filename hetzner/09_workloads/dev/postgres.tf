
resource "helm_release" "postgresql" {
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  version    = "16.6.3"

  name      = "postgresql"
  namespace = local.app_namespace

  values = [templatefile("${path.module}/files/postgresql.tpl.yaml", {
    postgres_password = "postgres" # pragma: allowlist secret
    storage_class     = "hcloud-volumes"
    storage_size      = "15Gi"
  })]
}