#!/usr/bin/bash
#first get token and export it
#then run curl and use the token
clear
#get bearer token
echo "full list at grid manager apic documentation"
echo "to get bearer token: api/v3/authorize" 
echo -n "get bearer token (enter) : "
read
export token=`curl -s -k -X POST "https://192.168.4.230:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "br@@mspun111"}'|jq -r '.data'`
echo 

echo "using bearer $token"

echo -n "list /api/v3/accounts  (enter) "
read
echo ""
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/accounts" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  |jq '.data[] | {name: .name, id: .id}' 

echo -n "list grid /api/v3/grid/users (enter) :"
read
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/users" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  |jq '.data[]|{name: .fullName, id: .id}' 

echo -n "list grid /api/v3/tenant/users (enter) :"
read
curl -s -X GET "https://192.168.4.230:443/api/v3/tenant/users" -H "accept: application/json"  -H "Authorization: Bearer b100d270-38ff-452b-ad02-b7a72d665e31" -k  |jq '.data[]|{name: .fullName, id: .id}' 

echo -n "list /api/v3/grid/node-health (enter) :"
read
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/node-health" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  | jq '.data[] | {name: .name, id: .id}' 

echo -n "list config/product-version  (enter) :"
read
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/config/product-version" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  | jq # '.data[] | {name: .name, id: .id}' 

echo -n "list versions (enter) :"
read
curl -s -X GET "https://192.168.4.230:443/api/v3/versions" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  | jq # '.data[] | {name: .name, id: .id}' 
