#!/bin/bash

echo "Get bearer token:"
token=$(curl -s -k -X POST "https://192.168.4.230/api/v3/authorize" \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"username":"root","password":"Netapp1!"}' | jq -r '.data')

echo "List ILM policies:"
curl -s -k \
  -H "Authorization: Bearer $token" \
  "https://192.168.4.230/api/v4/grid/ilm-policies" | jq .


#For a tighter list use jq to get the name, id and state.

#curl -s -k \
#  -H "Authorization: Bearer $token" \
#  "https://192.168.4.230/api/v4/grid/ilm-policies" |
#jq '.data[] | {name, id, active}'
