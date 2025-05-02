
output "lb_server_id" {
  value = hcloud_server.lb_server.id
}

output "lb_server_ip_private" {
  value = tolist(hcloud_server.lb_server.network)[0].ip
}

output "lb_server_ip_public" {
  value = hcloud_server.lb_server.ipv4_address
}