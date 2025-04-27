
data "terraform_remote_state" "istiod" {
  backend = "local"
  config = {
    path = "../../08_kubernetes/07_istiod/terraform.tfstate"
  }
}
