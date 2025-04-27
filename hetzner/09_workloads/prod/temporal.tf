
# kubectl run netshoot -n cv-web-dev-ns --rm -it --image=nicolaka/netshoot --restart=Never -- bash
# apk --update add postgresql-client
# PGPASSWORD=postgres psql -h postgresql.cv-web-dev-ns.svc.cluster.local -U postgres -d postgres
# apk --update add redis
# redis-cli -h redis-master.cv-web-dev-ns.svc.cluster.local -a redis

resource "helm_release" "temporal" {
  repository = "https://go.temporal.io/helm-charts"
  chart      = "temporal"
  version    = "0.55.0"

  name      = "temporal"
  namespace = local.app_namespace

  values = [templatefile("${path.module}/files/temporal.tpl.yaml",
    {
      subdomain_temporal  = "temporal-${var.env}"
      domain              = "andrefeuille.com"
      nginx_ip_whitelist  = local.nginx_ip_whitelist
      ingress_class       = "nginx"
      cert_manager_issuer = var.cert_manager_issuer
      cloudflare_proxied  = "false"
      app_namespace       = local.app_namespace
    }
  )]
}
