
# curl -v -H "Host: argocd.andrefeuille.com" http://<one-of-kube-node-public-ip>:31064

resource "kubernetes_manifest" "argo_cd_istio_route_http" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "argo-cd-istio-route-http"
      namespace = "argo-cd"
    }
    spec = {
      parentRefs = [
        {
          name        = "istio-gateway"
          namespace   = "istio-system"
          sectionName = "http"
        }
      ]
      hostnames = [
        "argo-cd.andrefeuille.com"
      ]
      rules = [
        {
          matches = [
            {
              path = {
                type  = "PathPrefix"
                value = "/"
              }
            }
          ]
          backendRefs = [
            {
              name = "argo-cd-argocd-server"
              port = 80
            }
          ]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "argo_cd_istio_route_https" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "argo-cd-istio-route-https"
      namespace = "argo-cd"
    }
    spec = {
      parentRefs = [
        {
          name        = "istio-gateway"
          namespace   = "istio-system"
          sectionName = "https"
        }
      ]
      hostnames = [
        "argo-cd.andrefeuille.com"
      ]
      rules = [
        {
          matches = [
            {
              path = {
                type  = "PathPrefix"
                value = "/"
              }
            }
          ]
          backendRefs = [
            {
              name = "argo-cd-argocd-server"
              port = 80
            }
          ]
        }
      ]
    }
  }
}
