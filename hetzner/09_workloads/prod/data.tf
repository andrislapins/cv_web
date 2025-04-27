
data "external" "what_is_current_ip" {
  program = ["/bin/bash", "${path.module}/scripts/get-current-public-ip.bash"]
}

###
###
###

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../../03_network/terraform.tfstate"
  }
}

data "terraform_remote_state" "nodes" {
  backend = "local"

  config = {
    path = "../../06_nodes/terraform.tfstate"
  }
}

###
###
###

