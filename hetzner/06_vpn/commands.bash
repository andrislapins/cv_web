#!/bin/bash

# https://docs.netbird.io/selfhosted/selfhosted-guide#step-1-get-the-latest-stable-net-bird-code

sudo apt update
sudo apt upgrade -y

sudo apt install -y docker.io

curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version

sudo apt install -y jq curl

REPO="https://github.com/netbirdio/netbird/"
# this command will fetch the latest release e.g. v0.8.7
LATEST_TAG=$(basename $(curl -fs -o/dev/null -w %{redirect_url} ${REPO}releases/latest))
echo $LATEST_TAG

# this command will clone the latest tag
git clone --depth 1 --branch $LATEST_TAG $REPO

cd netbird/infrastructure_files/
bash getting-started-with-zitadel.sh

# ... getting credentials

curl -fsSL https://pkgs.netbird.io/install.sh | sh
netbird up --management-url https://vpn.andrefeuille.com --admin-url https://vpn.andrefeuille.com

# https://vpn.andrefeuille.com/peers
# https://vpn.andrefeuille.com/ui/console/