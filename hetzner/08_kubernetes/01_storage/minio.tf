
resource "kubernetes_namespace" "minio" {
  metadata {
    name = "minio"
    labels = {
      "name"                         = "minio"
      "app.kubernetes.io/managed-by" = "terraform"
      "istio-injection"              = "enabled"
    }
  }
}

variable "MINIO_ACCESS_KEY" {
  type        = string
  description = "description"
  default     = "dcgsrtwg4ne5bnx6gc66"
}

variable "MINIO_SECRET_KEY" {
  type        = string
  description = "description"
  default     = "dsadasdc4fg5cccc55xvc"
}

resource "helm_release" "minio" {
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "minio"
  version    = "12.8.0"

  name      = "minio"
  namespace = "minio"

  values = [
    templatefile("${path.module}/files/minio.tpl.yaml", {
      storage_class    = "hcloud-volumes"
      minio_access_key = var.MINIO_ACCESS_KEY
      minio_secret_key = var.MINIO_SECRET_KEY
    })
  ]
}