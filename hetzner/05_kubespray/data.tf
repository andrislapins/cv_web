
data "terraform_remote_state" "nodes" {
  backend = "local"
  config = {
    path = "../03_nodes/terraform.tfstate"
  }
}
