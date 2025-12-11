#!/usr/bin/bash
#first get token and export it
#then run curl and use the token

export token=`curl -s -k -X POST "https://192.168.4.230:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "br@@mspun111"}'|jq -r '.data'`
echo 

echo "using bearer $token"
echo "getting tenants..."
echo ""
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/accounts" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  |jq '.data[] | {name: .name, id: .id}' 

echo ========
echo "endpoints..."
echo ""
curl -s -X GET "https://192.168.4.230/api/v4/org/endpoints" -H "accept: application/json"  -H "X-Csrf-Token: 911ebe95-993f-466f-b46c-73fc9b95c880" -k  |jq '.data[] | {name: .name, id: .id}' 



echo "Users"
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/users" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  |jq '.data[]|{name: .fullName, id: .id}' 

echo ========

echo "nodes"
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/node-health" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  | jq '.data[] | {name: .name, id: .id}' 

echo "alerts"
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/alerts" \
  -H "accept: application/json" \
  -H "Authorization: Bearer $token" \
  -k | jq '.data[] | {id: .id, name: .name, severity: .severity}'
echo ========

echo "buckets"

export token=`curl -s -k -X POST "https://192.168.4.230:443/api/v3/authorize" \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"username": "root", "password": "br@@mspun111", "accountId": "06720005734697258898"}' \
  | jq -r '.data'`

