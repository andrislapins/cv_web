
resource "kubernetes_manifest" "argocd_application" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name       = local.argocd_app_name
      namespace  = "argo-cd"
      finalizers = ["resources-finalizer.argocd.argoproj.io"]
    }
    spec = {
      project = "default"
      destination = {
        namespace = local.app_namespace
        server    = "https://kubernetes.default.svc"
      }
      source = {
        path           = "argocd/${var.env}/"
        repoURL        = "https://github.com/${local.repo_org}/${local.repo_name}.git"
        targetRevision = "HEAD"
      }
      syncPolicy = {
        automated = {}
      }
    }
  }
}
