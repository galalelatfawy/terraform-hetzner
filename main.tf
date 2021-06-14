data "hcloud_location" "location" {
  name = "nbg1"
}

resource "hcloud_ssh_key" "devops" {
  name       = "devops"
  public_key = file("~/.ssh/hetzner.pub")
}

resource "hcloud_server" "server" {
  count       = 1
  name        = "server-${count.index}"
  image       = "ubuntu-20.04"
  server_type = "cx11"
  location    = data.hcloud_location.location.name
  ssh_keys    = [hcloud_ssh_key.devops.id]
  labels = {
    "servertype/server" = "true",
    "servertype/node"  = "false"
  }
  firewall_ids = [hcloud_firewall.base.id, hcloud_firewall.k3s-server.id]
}

resource "hcloud_server" "node-cx11" {
  count       = 1
  name        = "node-cx11-${count.index}"
  image       = "ubuntu-20.04"
  server_type = "cx11"
  location    = data.hcloud_location.location.name
  ssh_keys    = [hcloud_ssh_key.devops.id]
  labels = {
    "servertype/server" = "false",
    "servertype/node"  = "true"
  }
  firewall_ids = [hcloud_firewall.base.id]
}

resource "hcloud_server" "pritunul" {
  count       = 1
  name        = "pritunul-cx11-${count.index}"
  image       = "ubuntu-20.04"
  server_type = "cx11"
  location    = data.hcloud_location.location.name
  ssh_keys    = [hcloud_ssh_key.devops.id]
  labels = {
    "servertype/server" = "false",
    "servertype/node"  = "false",
    "servertype/pritunul"  = "true"
  }
  firewall_ids = [hcloud_firewall.base.id]
}
