
resource "hcloud_load_balancer" "kube_api_server_lb" {
  name               = "kube-api-server-lb"
  load_balancer_type = "lb11"
  location           = "hel1"
}

resource "hcloud_load_balancer_network" "kube_api_server_lb_network" {
  load_balancer_id = hcloud_load_balancer.kube_api_server_lb.id
  network_id       = hcloud_network.kube_private_network.id
  ip               = "172.16.0.200"
}

resource "hcloud_load_balancer_service" "kube_api_server_lb_service" {
  load_balancer_id = hcloud_load_balancer.kube_api_server_lb.id
  protocol         = "tcp"
  listen_port      = 6443
  destination_port = 6443
}