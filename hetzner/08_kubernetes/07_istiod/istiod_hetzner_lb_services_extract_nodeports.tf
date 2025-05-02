
# TODO: Workaround to extract generated NodePort values from istio-gateway created NodePort service

resource "null_resource" "extract_nodeports" {
  provisioner "local-exec" {
    command = <<EOT
      kubectl get svc -n istio-system istio-gateway-istio -o json | \
      jq '{
        namespace: .metadata.namespace,
        name: .metadata.name,
        ports: [.spec.ports[] | {port: .port, nodePort: .nodePort, protocol: .protocol}]
      }' > tmp/nodeports.json
    EOT
  }

  depends_on = [
    kubernetes_manifest.istio_gateway
  ]
}

###
###
###

locals {
  nodeports_data = jsondecode(file("${path.module}/tmp/nodeports.json"))
  istio_gateway_ports = [
    for p in local.nodeports_data.ports : {
      name      = local.nodeports_data.name
      namespace = local.nodeports_data.namespace
      port      = p.port
      node_port = p.nodePort
      protocol  = p.protocol
    }
  ]
  istio_gateway_http_nodeport = (
    [for p in local.istio_gateway_ports : p.node_port if p.name == "istio-gateway-istio" && p.port == 80]
  )[0]

  istio_gateway_https_nodeport = (
    [for p in local.istio_gateway_ports : p.node_port if p.name == "istio-gateway-istio" && p.port == 443]
  )[0]
}

###
###
###

output "istio_gateway_ports_jsondecode" {
  value = local.nodeports_data
}

output "istio_gateway_ports" {
  value = local.istio_gateway_ports
}

output "istio_gateway_http_nodeport" {
  value = local.istio_gateway_http_nodeport
}

output "istio_gateway_https_nodeport" {
  value = local.istio_gateway_https_nodeport
}