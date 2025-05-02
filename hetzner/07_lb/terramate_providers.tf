// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

provider "hcloud" {
  token = var.HCLOUD_API_TOKEN
}
provider "kubernetes" {
  config_path = "~/.kube/config"
}
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
provider "cloudflare" {
  api_token = var.CLOUDFLARE_API_TOKEN
}
provider "null" {
}
provider "local" {
}
provider "http" {
}
provider "kubectl" {
  config_path = "~/.kube/config"
}
