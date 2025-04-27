
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argo-cd"
    labels = {
      "name"                         = "argo-cd"
      "app.kubernetes.io/managed-by" = "terraform"
      "monitoring"                   = "prometheus"
      "istio-injection"              = "enabled"
    }
  }
}

resource "kubernetes_service_account" "argocd" {
  metadata {
    name      = var.argocd_sa_name
    namespace = "argo-cd"
  }
}

resource "helm_release" "argocd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.7.7"

  name      = "argo-cd"
  namespace = "argo-cd"

  values = [templatefile("${path.module}/files/argocd.tpl.yaml", {
    subdomain                     = "argo-cd"
    domain                        = "andrefeuille.com"
    enable_web_terminal           = "true"
    metrics                       = "false"
    github_org                    = "andrislapins"
    gh_oauth_argocd_client_id     = var.GH_OAUTH_ARGOCD_CLIENT_ID
    gh_oauth_argocd_client_secret = var.GH_OAUTH_ARGOCD_CLIENT_SECRET
    service_account_name          = kubernetes_service_account.argocd.metadata.0.name
    admin_email                   = var.CLOUDFLARE_ADMIN_EMAIL
    })
  ]
}