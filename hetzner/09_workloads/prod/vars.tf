
variable "nginx_ip_whitelist" {
  type        = list(string)
  description = "List of IP addresses to whitelist for NGINX ingress"
  default = [
    "80.89.77.186/32",
  ]
}

variable "cert_manager_issuer" {
  type        = string
  description = "The name of the cert-manager issuer"
  default     = "cloudflare-issuer"
}