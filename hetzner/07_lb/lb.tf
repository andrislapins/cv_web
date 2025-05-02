
resource "hcloud_server" "lb_server" {
  name        = "lb-server"
  image       = "ubuntu-24.04"
  server_type = "cax11"
  datacenter  = "hel1-dc2"
  ssh_keys    = ["k8s_admin_ssh_key"]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  network {
    network_id = data.terraform_remote_state.network.outputs.kube_private_network_id
    ip         = "172.16.0.111"
  }
}