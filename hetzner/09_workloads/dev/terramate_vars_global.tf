// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

variable "HCLOUD_API_TOKEN" {
  description = "Hetzner Cloud API token"
  sensitive   = true
  type        = string
}
variable "CLOUDFLARE_API_TOKEN" {
  description = "Cloudflare API token"
  sensitive   = true
  type        = string
}
variable "CLOUDFLARE_ZONE_ID" {
  description = "Cloudflare zone ID"
  sensitive   = true
  type        = string
}
variable "CLOUDFLARE_ADMIN_EMAIL" {
  description = "Cloudflare admin email"
  sensitive   = true
  type        = string
}
variable "env" {
  default     = "dev"
  description = "Infrastructure environment"
  type        = string
}
variable "domain" {
  default     = "andrefeuille.com"
  description = "Domain name"
  type        = string
}
variable "api_server_lb_subdomain" {
  default     = "hcloud-lb-api-server"
  description = "API server load balancer subdomain"
  type        = string
}
