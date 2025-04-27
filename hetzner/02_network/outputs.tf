
output "kube_private_network_id" {
  value = hcloud_network.kube_private_network.id
}

output "kube_api_server_lb_id" {
  value = hcloud_load_balancer.kube_api_server_lb.id
}

output "kube_api_server_lb_public_ip" {
  description = "Public IPv4 address of the Kubernetes K8s API server load balancer"
  value       = hcloud_load_balancer.kube_api_server_lb.ipv4
}