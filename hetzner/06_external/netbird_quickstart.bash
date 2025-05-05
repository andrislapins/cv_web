#!/bin/bash

###
###
###

sudo apt update
sudo apt upgrade -y
# reboot
sudo apt install -y jq ca-certificates curl

###
### https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
###

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

###
### https://docs.netbird.io/selfhosted/selfhosted-quickstart
###

# export NETBIRD_DOMAIN="vpn.andrefeuille.com"; curl -fsSL https://github.com/netbirdio/netbird/releases/latest/download/getting-started-with-zitadel.sh | bash
export NETBIRD_DOMAIN="vpn.andrefeuille.com"; curl -fsSL https://github.com/netbirdio/netbird/releases/download/v0.41.1/getting-started-with-zitadel.sh | bash

curl -fsSL https://pkgs.netbird.io/install.sh | bash
netbird up --management-url https://vpn.andrefeuille.com

# Add vpn-server VM as a peer TOO (!) and set it a an "Exit Node"
curl -fsSL https://pkgs.netbird.io/install.sh | sh
netbird up --management-url https://vpn.andrefeuille.com --admin-url https://vpn.andrefeuille.com
# Then it works (!!!) - my laptop is now connected to the VPN and every request is routed through the VPN