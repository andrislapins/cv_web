
###
### Hetzner Load Balancer for Istiod
###

resource "hcloud_load_balancer" "istio_gateway_lb" {
  name               = "istio-gateway-lb"
  load_balancer_type = "lb11"
  location           = "hel1"
}

resource "hcloud_load_balancer_network" "istio_gateway_lb_net" {
  load_balancer_id = hcloud_load_balancer.istio_gateway_lb.id
  network_id       = data.terraform_remote_state.network.outputs.kube_private_network_id
  ip               = "172.16.0.202"
}

###
### Targets (Nodes)
###

resource "hcloud_load_balancer_target" "istio_gateway_lb_target_kube_node_1" {
  type             = "server"
  load_balancer_id = hcloud_load_balancer.istio_gateway_lb.id
  server_id        = data.terraform_remote_state.nodes.outputs.kube_node_1_id
  use_private_ip   = false
}

resource "hcloud_load_balancer_target" "istio_gateway_lb_target_kube_node_2" {
  type             = "server"
  load_balancer_id = hcloud_load_balancer.istio_gateway_lb.id
  server_id        = data.terraform_remote_state.nodes.outputs.kube_node_2_id
  use_private_ip   = false
}

resource "hcloud_load_balancer_target" "istio_gateway_lb_target_kube_node_3" {
  type             = "server"
  load_balancer_id = hcloud_load_balancer.istio_gateway_lb.id
  server_id        = data.terraform_remote_state.nodes.outputs.kube_node_3_id
  use_private_ip   = false
}