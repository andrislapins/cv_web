
resource "cloudflare_dns_record" "hcloud_kube_api_server_lb" {
  name    = var.api_server_lb_subdomain
  type    = "A"
  content = hcloud_load_balancer.kube_api_server_lb.ipv4
  ttl     = 1
  proxied = false
  zone_id = var.CLOUDFLARE_ZONE_ID
}