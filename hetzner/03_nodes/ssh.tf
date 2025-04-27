
resource "hcloud_ssh_key" "k8s_admin_ssh_key" {
  name       = "k8s_admin_ssh_key"
  public_key = file("~/.ssh/id_rsa.pub")
}