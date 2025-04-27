#!/bin/bash

ENDPOINT="https://bookinfo.andrefeuille.com/productpage"
COUNT=${1:-100}

for ((i=1; i<=COUNT; i++)); do
  curl -k -s "$ENDPOINT" > /dev/null
  echo "Request $i sent to $ENDPOINT"
  sleep 0.5
done