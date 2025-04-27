
resource "null_resource" "extract_nodeports" {
  provisioner "local-exec" {
    command = <<EOT
      kubectl get svc -A --field-selector spec.type=NodePort -o json | \
      jq '[.items[] | {
        namespace: .metadata.namespace,
        name: .metadata.name,
        ports: [.spec.ports[] | {port: .port, nodePort: .nodePort, protocol: .protocol}]
      }]' > tmp/nodeports.json
    EOT
  }
}

locals {
  nodeports_data = jsondecode(file("${path.module}/tmp/nodeports.json"))
}

locals {
  istio_gateway_ports = flatten([
    for svc in local.nodeports_data : [
      for p in svc.ports : {
        name      = svc.name
        namespace = svc.namespace
        port      = p.port
        node_port = p.nodePort
        protocol  = p.protocol
      }
    ]
  ])
}

locals {
  istio_gateway_http_nodeport = (
    [for p in local.istio_gateway_ports : p.node_port if p.name == "istio-gateway-istio" && p.port == 80]
  )[0]

  istio_gateway_https_nodeport = (
    [for p in local.istio_gateway_ports : p.node_port if p.name == "istio-gateway-istio" && p.port == 443]
  )[0]
}

###
### LB Service - Port 80
###

resource "hcloud_load_balancer_service" "istio_gateway_lb_http" {
  load_balancer_id = hcloud_load_balancer.istio_gateway_lb.id
  protocol         = "tcp"

  listen_port      = 80
  destination_port = local.istio_gateway_http_nodeport

  health_check {
    interval = 15
    timeout  = 10
    retries  = 3

    protocol = "tcp"
    port     = local.istio_gateway_http_nodeport
  }
}

###
### LB Service - Port 443
###

resource "hcloud_load_balancer_service" "istio_gateway_lb_https" {
  load_balancer_id = hcloud_load_balancer.istio_gateway_lb.id
  protocol         = "tcp"

  listen_port      = 443
  destination_port = local.istio_gateway_https_nodeport

  health_check {
    interval = 15
    timeout  = 10
    retries  = 3

    protocol = "tcp"
    port     = local.istio_gateway_https_nodeport
  }
}