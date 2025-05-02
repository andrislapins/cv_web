
resource "cloudflare_dns_record" "lb_server" {
  type    = "A"
  name    = "lb.andrefeuille.com"
  content = hcloud_server.lb_server.ipv4_address
  ttl     = 1
  proxied = false
  zone_id = var.CLOUDFLARE_ZONE_ID
}