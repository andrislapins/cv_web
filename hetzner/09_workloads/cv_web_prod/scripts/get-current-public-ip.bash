#!/bin/bash

set -xe

INTERNETIP="$(dig +short myip.opendns.com @resolver1.opendns.com -4)"

echo $(jq -n --arg internetip "$INTERNETIP/32" '{"internet_ip":$internetip}')