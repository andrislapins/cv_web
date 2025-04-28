
locals {
  app_name         = "cv-web"
  app_namespace    = "${local.app_name}-${var.env}-ns"
  repo_org         = "andrislapins"
  repo_name        = "cv_web"
  argocd_app_name  = "${local.app_name}-${var.env}-root-app"
  argocd_namespace = "argo-cd"
}
