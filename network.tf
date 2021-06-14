resource "hcloud_network" "k3s" {
  name     = "k3s"
  ip_range = "10.10.0.0/16"
}

resource "hcloud_network_subnet" "k3s" {
  network_id   = hcloud_network.k3s.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.10.0.0/24"
}

resource "hcloud_server_network" "server" {
  count      = length(hcloud_server.server)
  server_id  = hcloud_server.server[count.index].id
  network_id = hcloud_network.k3s.id
}

resource "hcloud_server_network" "node-cx11" {
  count      = length(hcloud_server.node-cx11)
  server_id  = hcloud_server.node-cx11[count.index].id
  network_id = hcloud_network.k3s.id
}