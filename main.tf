# data "hcloud_location" "location" {
#   name = "nbg1"
# }

# resource "hcloud_ssh_key" "devops2" {
#   name       = "devops2"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

# resource "hcloud_server" "server" {
#   count       = 1
#   name        = "server-${count.index}"
#   image       = "ubuntu-20.04"
#   server_type = "cx11"
#   location    = data.hcloud_location.location.name
#   ssh_keys    = [hcloud_ssh_key.devops.id]
#   labels = {
#     "servertype/server" = "true",
#     "servertype/node"  = "false"
#   }
#   firewall_ids = [hcloud_firewall.base.id, hcloud_firewall.k8s-server.id]
# }

# resource "hcloud_server" "node-cx11" {
#   count       = 1
#   name        = "node-cx11-${count.index}"
#   image       = "ubuntu-20.04"
#   server_type = "cx11"
#   location    = data.hcloud_location.location.name
#   ssh_keys    = [hcloud_ssh_key.devops.id]
#   labels = {
#     "servertype/server" = "false",
#     "servertype/node"  = "true"
#   }
#   firewall_ids = [hcloud_firewall.base.id]
# }

