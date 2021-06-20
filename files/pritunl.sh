#!/bin/bash

apt-get install gnupg 

tee /etc/apt/sources.list.d/pritunl.list << EOF
deb http://repo.pritunl.com/stable/apt focal main
EOF

# fix for https not working between clusters
iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss 1200

# remove one for mongodb
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv E162F504A20CDF15827F718D4B7C549A058F8B6B
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
apt-get update
apt-get --assume-yes install pritunl pritunl-link

pritunl-link verify-off
pritunl-link add "${pritunl_link_uri}"
sleep 3m
pritunl-link provider hetzner-cloud




# NODE EXPORTER INSTALLATION

NODE_EXPORTER_VERSION="1.1.2"
NODE_EXPORTER_NAME="node_exporter-$${NODE_EXPORTER_VERSION}.linux-amd64"
NODE_EXPORTER_ARCHIVE="$${NODE_EXPORTER_NAME}.tar.gz"
PRIVATE_IP="$(hostname -i)"

cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v$${NODE_EXPORTER_VERSION}/$${NODE_EXPORTER_ARCHIVE}
tar xvfz $${NODE_EXPORTER_ARCHIVE}
cd $${NODE_EXPORTER_NAME}
sudo mv node_exporter /usr/local/bin/node_exporter
cd ..
rm -rd /tmp/$${NODE_EXPORTER_NAME}
rm -f /tmp/$${NODE_EXPORTER_ARCHIVE}
sudo useradd -rs /bin/false node_exporter

sudo tee /etc/systemd/system/node_exporter.service << EOF
echo
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter --web.listen-address=$${PRIVATE_IP}:9100
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
