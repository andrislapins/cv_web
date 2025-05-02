
resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
    labels = {
      "name"                         = "vault"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "vault" {
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  version    = "0.30.0"

  name      = "vault"
  namespace = "vault"

  values = [
    templatefile("${path.module}/files/vault.tpl.yaml", {
      storage_class = "hcloud-volumes"
    })
  ]
}

# TODO: Connect to vault subdomain, create secrets, unseal them, manually create this secret engine
# resource "vault_mount" "kv_v2" {
#   path        = "secret"
#   type        = "kv"
#   description = "Key-Value secret engine for app secrets"

#   options = {
#     version = "2"
#   }

#   depends_on = [
#     helm_release.vault
#   ]
# }

resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_policy" "admin" {
  name   = "admin"
  policy = <<EOT
path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}

variable "VAULT_ADMIN_PASSWORD" {
  type        = string
  description = "Admin password for Vault"
}

resource "vault_generic_endpoint" "admin_user" {
  path                 = "auth/${vault_auth_backend.userpass.path}/users/admin"
  ignore_absent_fields = true
  data_json            = <<EOT
{
  "password": "${var.VAULT_ADMIN_PASSWORD}",
  "token_policies": ["admin"]
}
EOT
}