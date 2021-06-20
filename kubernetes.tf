locals {
  vault_url = "https://vault.tooling.europe-west3-gcloud.internal.360dialog.io/"
  environment = "staging"
  networks = {
  private_a = "10.27.0.0/22"
  private_b = "10.27.4.0/22"
  private_c = "10.27.8.0/22"
  vpn_destintion  = "10.27.32.0/24"
  vpc_cidr =  "10.27.0.0/16"
}
}


# resource "hcloud_server" "server" {
#   count       = var.number_master_node
#   name        = "server-${count.index}"
#   image       = "ubuntu-20.04"
#   server_type = var.k8s_master_node_type
#   location    = var.hcloud_location
#   ssh_keys    = [hcloud_ssh_key.devops2.id]
#   labels = {
#     "servertype/server" = "true",
#     "servertype/node"  = "false"
#   }
#   firewall_ids = [hcloud_firewall.base2.id, hcloud_firewall.k8s-server2.id]
# }

resource "hcloud_server" "server-1" {
  name        = "server-1"
  image       = "ubuntu-20.04"
  server_type = var.k8s_master_node_type
  location    = var.hcloud_location
  ssh_keys    = [hcloud_ssh_key.devops2.id]
  labels = {
    "servertype/server" = "true",
    "servertype/node"  = "false"
  }
  firewall_ids = [hcloud_firewall.base2.id, hcloud_firewall.k8s-server2.id]
}

resource "hcloud_server" "server-2" {
  name        = "server-2"
  image       = "ubuntu-20.04"
  server_type = var.k8s_master_node_type
  location    = var.hcloud_location
  ssh_keys    = [hcloud_ssh_key.devops2.id]
  labels = {
    "servertype/server" = "true",
    "servertype/node"  = "false"
  }
  firewall_ids = [hcloud_firewall.base2.id, hcloud_firewall.k8s-server2.id]
}

resource "hcloud_server" "server-3" {
  name        = "server-3"
  image       = "ubuntu-20.04"
  server_type = var.k8s_master_node_type
  location    = var.hcloud_location
  ssh_keys    = [hcloud_ssh_key.devops2.id]
  labels = {
    "servertype/server" = "true",
    "servertype/node"  = "false"
  }
  firewall_ids = [hcloud_firewall.base2.id, hcloud_firewall.k8s-server2.id]
}

# resource "hcloud_server" "agent" {
#   count       = var.number_agent_node
#   name        = "agent-${count.index}"
#   image       = "ubuntu-20.04"
#   server_type = var.k8s_agent_node_type
#   location    = var.hcloud_location
#   ssh_keys    = [hcloud_ssh_key.devops2.id]
#   labels = {
#     "servertype/server" = "false",
#     "servertype/node"  = "true"
#   }
#   firewall_ids = [hcloud_firewall.base2.id]
# }
resource "hcloud_server" "agent-01" {
  name        = "agent-01"
  image       = "ubuntu-20.04"
  server_type = var.k8s_agent_node_type
  location    = var.hcloud_location
  ssh_keys    = [hcloud_ssh_key.devops2.id]
  labels = {
    "servertype/server" = "false",
    "servertype/node"  = "true"
  }
  firewall_ids = [hcloud_firewall.base2.id]
}

resource "hcloud_server" "agent-02" {
  name        = "agent-02"
  image       = "ubuntu-20.04"
  server_type = var.k8s_agent_node_type
  location    = var.hcloud_location
  ssh_keys    = [hcloud_ssh_key.devops2.id]
  labels = {
    "servertype/server" = "false",
    "servertype/node"  = "true"
  }
  firewall_ids = [hcloud_firewall.base2.id]
}
resource "hcloud_server" "agent-03" {
  name        = "agent-03"
  image       = "ubuntu-20.04"
  server_type = var.k8s_agent_node_type
  location    = var.hcloud_location
  ssh_keys    = [hcloud_ssh_key.devops2.id]
  labels = {
    "servertype/server" = "false",
    "servertype/node"  = "true"
  }
  firewall_ids = [hcloud_firewall.base2.id]
}
# resource "hcloud_server_network" "k8s_server_netwok" {
#   count = length(hcloud_server.server[*].name)
#   server_id  = hcloud_server.server[count.index].id 
#   network_id = hcloud_network.vpc.id
#   ip         = element(local.hetzner_private_subs , count.index) 
# }
resource "hcloud_server_network" "k8s_server_netwok1" {
  server_id  = hcloud_server.server-1.id 
  network_id = hcloud_network.vpc.id
  ip         = local.networks.private_a
}

resource "hcloud_server_network" "k8s_server_netwok2" {
  server_id  = hcloud_server.server-2.id 
  network_id = hcloud_network.vpc.id
  ip         = local.networks.private_b
}

resource "hcloud_server_network" "k8s_server_netwok3" {
  server_id  = hcloud_server.server-3.id 
  network_id = hcloud_network.vpc.id
  ip         = local.networks.private_c
}

# resource "hcloud_server_network" "k8s_agent_netwok" {
#   count = length(hcloud_server.agent[*].name)
#   server_id  = hcloud_server.agent[count.index].id
#   network_id = hcloud_network.vpc.id
#   ip         = element(local.hetzner_private_subs , count.index)
# }

resource "hcloud_server_network" "k8s_agent_netwok1" {
  server_id  = hcloud_server.agent-01.id
  network_id = hcloud_network.vpc.id
  ip         = local.networks.private_a
}

resource "hcloud_server_network" "k8s_agent_netwok2" {
  server_id  = hcloud_server.agent-02.id
  network_id = hcloud_network.vpc.id
  ip         = local.networks.private_b
}

resource "hcloud_server_network" "k8s_agent_netwok3" {
  server_id  = hcloud_server.agent-03.id
  network_id = hcloud_network.vpc.id
  ip         = local.networks.private_c
}