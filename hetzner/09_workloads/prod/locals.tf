
locals {
  nginx_ip_whitelist = join(", ", concat(var.nginx_ip_whitelist, [
    data.external.what_is_current_ip.result["internet_ip"],
    data.terraform_remote_state.nodes.outputs.kube-node-1-public-ip,
    data.terraform_remote_state.nodes.outputs.kube-node-2-public-ip,
    data.terraform_remote_state.nodes.outputs.kube-node-3-public-ip,
    data.terraform_remote_state.nodes.outputs.kube-node-1-private-ip[0],
    data.terraform_remote_state.nodes.outputs.kube-node-2-private-ip[0],
    data.terraform_remote_state.nodes.outputs.kube-node-3-private-ip[0]
  ]))
  app_name         = "cv-web"
  app_namespace    = "${local.app_name}-${var.env}-ns"
  argocd_app_name  = "${local.app_name}-${var.env}-root-app"
  argocd_namespace = "argo-cd"
  repo_org         = "andrislapins"
  repo_name        = "cv_web"
}
