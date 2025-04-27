
###
### Private IPs of the nodes
###

output "kube_node_1_ip_private" {
  value = [for net in hcloud_server.kube_node[0].network : net.ip][0]
}

output "kube_node_2_ip_private" {
  value = [for net in hcloud_server.kube_node[1].network : net.ip][0]
}

output "kube_node_3_ip_private" {
  value = [for net in hcloud_server.kube_node[2].network : net.ip][0]
}

###
### Public IPs of the nodes
###

output "kube_node_1_ip_public" {
  value = hcloud_server.kube_node[0].ipv4_address
}

output "kube_node_2_ip_public" {
  value = hcloud_server.kube_node[1].ipv4_address
}

output "kube_node_3_ip_public" {
  value = hcloud_server.kube_node[2].ipv4_address
}

###
### IDs of the nodes
### 
output "kube_node_1_id" {
  value = hcloud_server.kube_node[0].id
}

output "kube_node_2_id" {
  value = hcloud_server.kube_node[1].id
}

output "kube_node_3_id" {
  value = hcloud_server.kube_node[2].id
}

###
### For kubespray hosts.yaml
###

output "kube_nodes_public_ips" {
  value = {
    for i, s in hcloud_server.kube_node :
    "kube-node-${i + 1}" => s.ipv4_address
  }
}