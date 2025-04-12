
terramate {
  config {
    git {
      default_branch = "main"
    }
  }
}

globals {
  env                     = "infra"
  domain                  = "andrefeuille.com"
  api_server_lb_subdomain = "hcloud-lb-api-server"
}

generate_hcl "terramate_vars_global.tf" {
  content {
    variable "HCLOUD_API_TOKEN" {
      type        = string
      description = "Hetzner Cloud API token"
      sensitive   = true
    }
    variable "CLOUDFLARE_API_TOKEN" {
      type        = string
      description = "Cloudflare API token"
      sensitive   = true
    }
    variable "CLOUDFLARE_ZONE_ID" {
      type        = string
      description = "Cloudflare zone ID"
      sensitive   = true
    }
    variable "env" {
      type        = string
      description = "Infrastructure environment"
      default     = "${global.env}"
    }
    variable "domain" {
      type        = string
      description = "Domain name"
      default     = "${global.domain}"
    }
    variable "api_server_lb_subdomain" {
      type        = string
      description = "API server load balancer subdomain"
      default     = "${global.api_server_lb_subdomain}"
    }
  }
}

generate_hcl "backend.tf" {
  content {
    terraform {
      backend "local" {
        path = "terraform.tfstate"
      }
    }
  }
}

generate_hcl "terramate_providers.tf" {
  content {
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
    provider "null" {}
    provider "local" {}
  }
}

generate_hcl "terramate_provider_versions.tf" {
  content {
    terraform {
      required_version = "~> 1.11"

      required_providers {
        hcloud = {
          source  = "hetznercloud/hcloud"
          version = "~> 1.45"
        }
        kubernetes = {
          source  = "hashicorp/kubernetes"
          version = "~> 2.20"
        }
        helm = {
          source  = "hashicorp/helm"
          version = "~> 2.10"
        }
        cloudflare = {
          source  = "cloudflare/cloudflare"
          version = "~> 5.2"
        }
        null = {
          source  = "hashicorp/null"
          version = "~> 3.2"
        }
        local = {
          source  = "hashicorp/local"
          version = "~> 2.5"
        }
      }
    }
  }
}