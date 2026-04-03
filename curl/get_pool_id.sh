#!/bin/bash

echo "Get bearer token:"
token=$(curl -s -k -X POST "https://192.168.4.230/api/v3/authorize" \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"username":"root","password":"Netapp1!"}' | jq -r '.data')

curl -s -k \
  -H "Authorization: Bearer $token" \
  "https://192.168.4.230/api/v4/grid/ilm-policies" |
jq '.data[] | {name, id, active}'

#or for an even tighter output...
#curl -s -k \
#  -H "Authorization: Bearer $token" \
#  "https://192.168.4.230/api/v4/grid/ilm-policies" |
#jq -r '.data[] | "\(.name)\t\(.id)\t\(.active)"'
