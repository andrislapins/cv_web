
data "external" "what_is_current_ip" {
  program = ["bash", "${path.module}/scripts/get-current-public-ip.bash"]
}