
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace_name
    labels = {
      "name"                         = var.argocd_namespace_name
      "app.kubernetes.io/managed-by" = "terraform"
      "monitoring"                   = "prometheus"
      "istio-injection"              = "enabled"
    }
  }
}

resource "kubernetes_service_account" "argocd" {
  metadata {
    name      = var.argocd_sa_name
    namespace = var.argocd_namespace_name
  }
}

resource "helm_release" "argocd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.7.7"

  name      = "argo-cd"
  namespace = var.argocd_namespace_name

  values = [templatefile("${path.module}/files/argocd.tpl.yaml", {
    subdomain                     = "argocd"
    domain                        = "andrefeuille.com"
    enable_web_terminal           = "true"
    metrics                       = "false"
    github_org                    = "andrislapins"
    gh_oauth_argocd_client_id     = var.GH_OAUTH_ARGOCD_CLIENT_ID
    gh_oauth_argocd_client_secret = var.GH_OAUTH_ARGOCD_CLIENT_SECRET
    service_account_name          = kubernetes_service_account.argocd.metadata.0.name
    })
  ]
}