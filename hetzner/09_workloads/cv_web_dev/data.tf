
data "external" "what_is_current_ip" {
  program = ["/bin/bash", "${path.module}/scripts/get-current-public-ip.bash"]
}

###
###
###

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

data "terraform_remote_state" "istiod" {
  backend = "local"
  config = {
    path = "../../08_kubernetes/07_istiod/terraform.tfstate"
  }
}

###
###
###

