
resource "hcloud_load_balancer_target" "kube_api_server_target" {
  count            = 3
  type             = "server"
  load_balancer_id = data.terraform_remote_state.network.outputs.kube_api_server_lb_id
  server_id        = hcloud_server.kube_node[count.index].id
  use_private_ip   = true
}