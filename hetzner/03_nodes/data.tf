
data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../02_network/terraform.tfstate"
  }
}
