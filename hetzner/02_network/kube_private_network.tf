
resource "hcloud_network" "kube_private_network" {
  name     = "kube-private-network"
  ip_range = "172.16.0.0/24"
}

resource "hcloud_network_subnet" "kube_private_subnet" {
  type         = "cloud"
  network_id   = hcloud_network.kube_private_network.id
  network_zone = "eu-central"
  ip_range     = "172.16.0.0/24"
}