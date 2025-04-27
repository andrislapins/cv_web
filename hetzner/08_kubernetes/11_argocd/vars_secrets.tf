
variable "GH_OAUTH_ARGOCD_CLIENT_ID" {
  type        = string
  description = "GitHub OAuth client ID"
  sensitive   = true
}

variable "GH_OAUTH_ARGOCD_CLIENT_SECRET" {
  type        = string
  description = "GitHub OAuth client secret"
  sensitive   = true
}