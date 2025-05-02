
variable "HASHICORP_VAULT_TOKEN" {
  description = "The token to authenticate with Vault"
  type        = string
}

provider "vault" {
  address                = "https://vault.andrefeuille.com"
  token                  = var.HASHICORP_VAULT_TOKEN
  skip_child_token       = true
  skip_get_vault_version = true
}