
###
### LB Service - Port 80
###

resource "hcloud_load_balancer_service" "istio_gateway_lb_http" {
  load_balancer_id = hcloud_load_balancer.istio_gateway_lb.id
  protocol         = "tcp"

  listen_port = 80
  # destination_port = "32489"
  destination_port = local.istio_gateway_http_nodeport

  health_check {
    interval = 15
    timeout  = 10
    retries  = 3

    protocol = "tcp"
    # port     = "32489"
    port = local.istio_gateway_http_nodeport
  }
}

###
### LB Service - Port 443
###

resource "hcloud_load_balancer_service" "istio_gateway_lb_https" {
  load_balancer_id = hcloud_load_balancer.istio_gateway_lb.id
  protocol         = "tcp"

  listen_port = 443
  # destination_port = "32066"
  destination_port = local.istio_gateway_https_nodeport

  health_check {
    interval = 15
    timeout  = 10
    retries  = 3

    protocol = "tcp"
    # port     = "32066"
    port = local.istio_gateway_https_nodeport
  }
}