
data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../02_network/terraform.tfstate"
  }
}

data "terraform_remote_state" "nodes" {
  backend = "local"
  config = {
    path = "../03_nodes/terraform.tfstate"
  }
}