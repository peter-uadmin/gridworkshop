#!/bin/bash

GRID_IP="192.168.4.230"
USER="root"
PASS="Netapp1!"

echo "Getting bearer token..."
token=$(curl -s -k -X POST "https://${GRID_IP}/api/v3/authorize" \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"${USER}\",\"password\":\"${PASS}\"}" | jq -r '.data')

echo
echo -e "POOL NAME\tPOOL ID"
echo -e "---------\t-------"

curl -s -k \
  -H "Authorization: Bearer $token" \
   https://192.168.4.230/api/v4/grid/ilm-rules | 
   jq '.data[] | {name, id, active}'
