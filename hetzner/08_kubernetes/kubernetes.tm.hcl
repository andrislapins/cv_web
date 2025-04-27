
generate_hcl "terramate_data_k8s.tf" {
  content {
    data "terraform_remote_state" "network" {
      backend = "local"
      config = {
        path = "../../02_network/terraform.tfstate"
      }
    }
    data "terraform_remote_state" "nodes" {
      backend = "local"
      config = {
        path = "../../03_nodes/terraform.tfstate"
      }
    }
  }
}