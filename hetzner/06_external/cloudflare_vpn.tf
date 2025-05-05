
resource "cloudflare_dns_record" "vpn" {
  type    = "A"
  name    = "vpn.andrefeuille.com"
  content = hcloud_server.vpn_server.ipv4_address
  ttl     = 1
  proxied = false
  zone_id = var.CLOUDFLARE_ZONE_ID
}