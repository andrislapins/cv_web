#!/bin/bash

###
### 05.05.2025
###

sudo apt update
sudo apt upgrade -y
sudo apt install -y jq curl

# export NETBIRD_DOMAIN=vpn.andrefeuille.com; curl -fsSL https://github.com/netbirdio/netbird/releases/latest/download/getting-started-with-zitadel.sh | bash


###
### https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
###

sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

###
### https://docs.netbird.io/selfhosted/selfhosted-guide
###

REPO="https://github.com/netbirdio/netbird/"
LATEST_TAG=$(basename $(curl -fs -o/dev/null -w %{redirect_url} ${REPO}releases/latest))
echo $LATEST_TAG
git clone --depth 1 --branch $LATEST_TAG $REPO

cd netbird/infrastructure_files/
root@vpn-server:~/netbird/infrastructure_files# cat setup.env
## example file, you can copy this file to setup.env and update its values
##

# Image tags
# you can force specific tags for each component; will be set to latest if empty
NETBIRD_DASHBOARD_TAG=""
NETBIRD_SIGNAL_TAG=""
NETBIRD_MANAGEMENT_TAG=""
COTURN_TAG=""
NETBIRD_RELAY_TAG=""

# Dashboard domain. e.g. app.mydomain.com
NETBIRD_DOMAIN="vpn.andrefeuille.com"

# TURN server domain. e.g. turn.mydomain.com
# if not specified it will assume NETBIRD_DOMAIN
NETBIRD_TURN_DOMAIN=""

# TURN server public IP address
# required for a connection involving peers in
# the same network as the server and external peers
# usually matches the IP for the domain set in NETBIRD_TURN_DOMAIN
NETBIRD_TURN_EXTERNAL_IP=""

# -------------------------------------------
# OIDC
#  e.g., https://example.eu.auth0.com/.well-known/openid-configuration
# -------------------------------------------
NETBIRD_AUTH_OIDC_CONFIGURATION_ENDPOINT="https://vpn.andrefeuille.com/application/o/netbird/.well-known/openid-configuration"
# The default setting is to transmit the audience to the IDP during authorization. However,
# if your IDP does not have this capability, you can turn this off by setting it to false.
#NETBIRD_DASH_AUTH_USE_AUDIENCE=false
NETBIRD_AUTH_AUDIENCE="XPjZBkJvUbgzTVkpCNXU1bBrY2dQcNtodrNypcyu" # pragma: allowlist secret
# e.g. netbird-client
NETBIRD_AUTH_CLIENT_ID="XPjZBkJvUbgzTVkpCNXU1bBrY2dQcNtodrNypcyu" # pragma: allowlist secret
# indicates the scopes that will be requested to the IDP
NETBIRD_AUTH_SUPPORTED_SCOPES="openid profile email offline_access api"
# NETBIRD_AUTH_CLIENT_SECRET is required only by Google workspace.
# NETBIRD_AUTH_CLIENT_SECRET=""
# if you want to use a custom claim for the user ID instead of 'sub', set it here
# NETBIRD_AUTH_USER_ID_CLAIM=""
# indicates whether to use Auth0 or not: true or false
NETBIRD_USE_AUTH0="false"
# if your IDP provider doesn't support fragmented URIs, configure custom
# redirect and silent redirect URIs, these will be concatenated into your NETBIRD_DOMAIN domain.
# NETBIRD_AUTH_REDIRECT_URI="/peers"
# NETBIRD_AUTH_SILENT_REDIRECT_URI="/add-peers"
# Updates the preference to use id tokens instead of access token on dashboard
# Okta and Gitlab IDPs can benefit from this
# NETBIRD_TOKEN_SOURCE="idToken"
# -------------------------------------------
# OIDC Device Authorization Flow
# -------------------------------------------
NETBIRD_AUTH_DEVICE_AUTH_PROVIDER="none"
NETBIRD_AUTH_DEVICE_AUTH_CLIENT_ID="XPjZBkJvUbgzTVkpCNXU1bBrY2dQcNtodrNypcyu"
# Some IDPs requires different audience, scopes and to use id token for device authorization flow
# you can customize here:
NETBIRD_AUTH_DEVICE_AUTH_AUDIENCE=$NETBIRD_AUTH_AUDIENCE
NETBIRD_AUTH_DEVICE_AUTH_SCOPE="openid"
NETBIRD_AUTH_DEVICE_AUTH_USE_ID_TOKEN=false
# -------------------------------------------
# OIDC PKCE Authorization Flow
# -------------------------------------------
# Comma separated port numbers. if already in use, PKCE flow will choose an available port from the list as an alternative
# eg. 53000,54000
NETBIRD_AUTH_PKCE_REDIRECT_URL_PORTS="53000"
# -------------------------------------------
# IDP Management
# -------------------------------------------
# eg. zitadel, auth0, azure, keycloak
NETBIRD_MGMT_IDP="authentik"
# Some IDPs requires different client id and client secret for management api
NETBIRD_IDP_MGMT_CLIENT_ID=$NETBIRD_AUTH_CLIENT_ID
NETBIRD_IDP_MGMT_CLIENT_SECRET=""
# Required when setting up with Keycloak "https://<YOUR_KEYCLOAK_HOST_AND_PORT>/admin/realms/netbird"
# NETBIRD_IDP_MGMT_EXTRA_ADMIN_ENDPOINT=
# With some IDPs may be needed enabling automatic refresh of signing keys on expire
# NETBIRD_MGMT_IDP_SIGNKEY_REFRESH=false
# NETBIRD_IDP_MGMT_EXTRA_ variables. See https://docs.netbird.io/selfhosted/identity-providers for more information about your IDP of choice.
NETBIRD_IDP_MGMT_EXTRA_USERNAME="Netbird"
NETBIRD_IDP_MGMT_EXTRA_PASSWORD="3hmmjE5m0oU9" # pragma: allowlist secret
# -------------------------------------------
# Letsencrypt
# -------------------------------------------
# Disable letsencrypt
#  if disabled, cannot use HTTPS anymore and requires setting up a reverse-proxy to do it instead
NETBIRD_DISABLE_LETSENCRYPT=false
# e.g. hello@mydomain.com
NETBIRD_LETSENCRYPT_EMAIL="lapinsandris9@gmail.com"
# -------------------------------------------
# Extra settings
# -------------------------------------------
# Disable anonymous metrics collection, see more information at https://netbird.io/docs/FAQ/metrics-collection
NETBIRD_DISABLE_ANONYMOUS_METRICS=false
# DNS DOMAIN configures the domain name used for peer resolution. By default it is netbird.selfhosted
NETBIRD_MGMT_DNS_DOMAIN=netbird.selfhosted

# -------------------------------------------
# Relay settings
# -------------------------------------------
# Relay server domain. e.g. relay.mydomain.com
# if not specified it will assume NETBIRD_DOMAIN
NETBIRD_RELAY_DOMAIN=""

# Relay server connection port. If none is supplied
# it will default to 33080
NETBIRD_RELAY_PORT=""

###
### Authentik
###

mkdir ~/authentik
cd ~/authentik
wget https://goauthentik.io/docker-compose.yml
echo "PG_PASS=$(openssl rand -base64 36 | tr -d '\n')" >> .env
echo "AUTHENTIK_SECRET_KEY=$(openssl rand -base64 60 | tr -d '\n')" >> .env
echo "AUTHENTIK_ERROR_REPORTING__ENABLED=true" >> .env

# Resulting .env file ==> EOF
PG_PASS=lg2RbUq3hEKhBFjQqxvU+Fyl5WSJt5Kt1ymgazJXucvl/M9s
AUTHENTIK_SECRET_KEY=G5lmWc7mEBP08eKsSYSejinijQ+lhLqY3bXfI4mNOMI85HIL96sqZ17LJ+JzNwAYX9oLyQDHF0gYl4tC
AUTHENTIK_ERROR_REPORTING__ENABLED=true
###
###
###
# SMTP Host Emails are sent to
AUTHENTIK_EMAIL__HOST=andrefeuille.com
AUTHENTIK_EMAIL__PORT=25
# Optionally authenticate (don't add quotation marks to your password)
AUTHENTIK_EMAIL__USERNAME=
AUTHENTIK_EMAIL__PASSWORD=
# Use StartTLS
AUTHENTIK_EMAIL__USE_TLS=false
# Use SSL
AUTHENTIK_EMAIL__USE_SSL=false
AUTHENTIK_EMAIL__TIMEOUT=10
# Email address authentik will send from, should have a correct @domain
AUTHENTIK_EMAIL__FROM=authentik@andrefeuille.com
###
###
###
COMPOSE_PORT_HTTP=80
COMPOSE_PORT_HTTPS=443

# EOF

docker compose pull
docker compose up -d

# On browser: (create admin user)
http://vpn.andrefeuille.com/if/flow/initial-setup/

XPjZBkJvUbgzTVkpCNXU1bBrY2dQcNtodrNypcyu
Netbird
IqZeenw5eUjbAI4RtQhSrNhEg6btjb8aHsmjgZW2qCMgl9liXZmyqoLaQMMy
https://vpn.andrefeuille.com/application/o/netbird/.well-known/openid-configuration
3hmmjE5m0oU9