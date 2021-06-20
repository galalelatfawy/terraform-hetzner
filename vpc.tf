locals {
    subnet_type = "cloud"
    vpn_private_ip = cidrhost(var.networks.private_a, "16")
}
resource "hcloud_network" "vpc" {
  name     = var.infra_name
  ip_range = var.networks.vpc_cidr
}

resource "hcloud_network_subnet" "private_a" {
  network_id   = hcloud_network.vpc.id
  type         = local.subnet_type
  network_zone = var.zone
  ip_range     = var.networks.private_a
}

resource "hcloud_network_subnet" "private_b" {
  network_id   = hcloud_network.vpc.id
  type         = local.subnet_type
  network_zone = var.zone
  ip_range     = var.networks.private_b
}

resource "hcloud_network_subnet" "private_c" {
  network_id   = hcloud_network.vpc.id
  type         = local.subnet_type
  network_zone = var.zone
  ip_range     = var.networks.private_c
}

resource "hcloud_network_route" "vpnnet" {
  network_id  = hcloud_network.vpc.id
  destination = var.networks.vpn_destintion
  gateway     = local.vpn_private_ip
}
/*
resource "hcloud_server_network" "server" {
  count      = length(hcloud_server.server)
  server_id  = hcloud_server.server[count.index].id
  network_id = hcloud_network.vpc.id
}

resource "hcloud_server_network" "node-cx11" {
  count      = length(hcloud_server.node-cx11)
  server_id  = hcloud_server.node-cx11[count.index].id
  network_id = hcloud_network.vpc.id
}


*/