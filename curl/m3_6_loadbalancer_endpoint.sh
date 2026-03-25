#/usr/bin/env bash

clear

#get token
echo  "get bearer token : "
export token=`curl -s -k -X POST "https://192.168.0.80:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "Netapp1!"}'|jq -r '.data'`

#show token
echo $token

echo -n  "press enter: "


curl -s -k -H "Authorization: Bearer 7f8937a5-c7eb-4940-bc78-ccd705419052"  "https://192.168.0.80/api/v3/private/gateway-configs"# | jq -r '.data[] | "\(.id)\t\(.displayName)\t\(.port)"'
