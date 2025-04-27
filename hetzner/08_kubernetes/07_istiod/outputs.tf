
output "istio_gateway_lb_public_ip" {
  description = "Public IP address of the Istio Gateway Load Balancer"
  value       = hcloud_load_balancer.istio_gateway_lb.ipv4
}