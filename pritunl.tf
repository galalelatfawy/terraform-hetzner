

resource "hcloud_ssh_key" "devops2" {
  name       = "devops2"
  public_key = file("~/.ssh/hetzner.pub")
}


resource "hcloud_server" "pritunl-srv" {
  name        = "pritunul-vpn-srv"
  image       = "ubuntu-20.04"
  server_type = var.pritunl_node_type # default "cx11"
  location    = var.hcloud_location
  ssh_keys    = [hcloud_ssh_key.devops2.id]
  labels = {
    "servertype/server" = "false",
    "servertype/node"  = "false",
    "servertype/pritunul"  = "true"
  }
  user_data = data.template_file.pritunl_startup_script.rendered

  firewall_ids = [hcloud_firewall.base2.id]
}

resource "hcloud_server_network" "pritunlnetwok-pvt" {
  server_id  = hcloud_server.pritunl-srv.id
  network_id = hcloud_network.vpc.id
  ip         = local.vpn_private_ip
}