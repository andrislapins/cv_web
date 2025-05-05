
###
###
###

# output "lb_server_id" {
#   value = hcloud_server.lb_server.id
# }

# output "lb_server_ip_private" {
#   value = tolist(hcloud_server.lb_server.network)[0].ip
# }

# output "lb_server_ip_public" {
#   value = hcloud_server.lb_server.ipv4_address
# }

###
###
###

output "vpn_server_id" {
  value = hcloud_server.vpn_server.id
}

output "vpn_server_ip_private" {
  value = tolist(hcloud_server.vpn_server.network)[0].ip
}

output "vpn_server_ip_public" {
  value = hcloud_server.vpn_server.ipv4_address
}

###
###
###

# output "external_server_id_1" {
#   value = hcloud_server.external_server[0].id
# }

# output "external_server_ip_private_1" {
#   value = tolist(hcloud_server.external_server[0].network)[0].ip
# }

# output "external_server_ip_public_1" {
#   value = hcloud_server.external_server[0].ipv4_address
# }

# output "external_server_id_2" {
#   value = hcloud_server.external_server[1].id
# }

# output "external_server_ip_private_2" {
#   value = tolist(hcloud_server.external_server[1].network)[0].ip
# }

# output "external_server_ip_public_2" {
#   value = hcloud_server.external_server[1].ipv4_address
# }