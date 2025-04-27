
variable "ip_whitelist" {
  type        = list(string)
  description = "List of IP addresses to whitelist for NGINX ingress"
  default = [
    "80.89.77.186/32", # [could be my VPN IP]
  ]
}

variable "cert_manager_issuer" {
  type        = string
  description = "The name of the cert-manager issuer"
  default     = "cloudflare-issuer"
}

variable "GRAFANA_ADMIN_PASSWORD" {
  type        = string
  description = "The password for the Grafana admin user"
}