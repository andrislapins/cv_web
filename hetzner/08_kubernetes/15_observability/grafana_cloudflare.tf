
###
### Cloudflare DNS record to point to Load Balancer
###

resource "cloudflare_dns_record" "grafana_istiod" {
  type    = "A"
  name    = "grafana.andrefeuille.com"
  content = data.terraform_remote_state.istiod.outputs.istio_gateway_lb_public_ip
  ttl     = 1
  proxied = false
  zone_id = var.CLOUDFLARE_ZONE_ID
}