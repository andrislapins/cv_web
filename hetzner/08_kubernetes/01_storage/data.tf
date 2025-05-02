
data "terraform_remote_state" "istiod" {
  backend = "local"
  config = {
    path = "../07_istiod/terraform.tfstate"
  }
}
