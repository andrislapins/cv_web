
output "vpn_server_id" {
  value = hcloud_server.vpn_server.id
}

output "vpn_server_ip_private" {
  value = tolist(hcloud_server.vpn_server.network)[0].ip
}

output "vpn_server_ip_public" {
  value = hcloud_server.vpn_server.ipv4_address
}