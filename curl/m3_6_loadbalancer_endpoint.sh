#/usr/bin/env bash

#get token
echo  "get bearer token : "
export token=`curl -s -k -X POST "https://192.168.4.230:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "br@@mspun111"}'|jq -r '.data'`

#show token
echo $token

echo -n  "press enter: "


curl -k -H "Authorization: Bearer 7f8937a5-c7eb-4940-bc78-ccd705419052"  "https://192.168.4.230/api/v3/private/gateway-configs"# | jq -r '.data[] | "\(.id)\t\(.displayName)"'
