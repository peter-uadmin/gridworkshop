#!/usr/bin/bash
#first get token and export it
#then run curl and use the token
function read_and_clear {
echo -n "press enter: "	
        read
	clear
}
clear
#get bearer token
echo "full list at grid manager apic documentation"
echo "using api/v3/authorize to get token" 
sleep 1
export token=`curl -s -k -X POST "https://192.168.4.230:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "br@@mspun111"}'|jq -r '.data'`
echo 

echo "using bearer $token"

echo -n "list /api/v3/accounts  (press enter) "
read
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/accounts" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  |jq '.data[] | {name: .name, id: .id}' 
read_and_clear

echo -n "list grid /api/v3/grid/users (press enter) :"
read
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/users" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  |jq '.data[]|{name: .fullName, id: .id}' 
read_and_clear

echo -n "list grid /api/v3/tenant/users (press enter) :"
read
curl -s -X GET "https://192.168.4.230:443/api/v3/tenant/users" -H "accept: application/json"  -H "Authorization: Bearer b100d270-38ff-452b-ad02-b7a72d665e31" -k  |jq '.data[]|{name: .fullName, id: .id}' 
read_and_clear

echo -n "list /api/v3/grid/node-health (press enter) :"
read
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/node-health" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  | jq '.data[] | {name: .name, id: .id}' 
read_and_clear

echo -n "list config/product-version  (press enter) :"
read
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/config/product-version" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  | jq # '.data[] | {name: .name, id: .id}' 
read_and_clear

echo -n "list versions (press enter) :"
read
curl -s -X GET "https://192.168.4.230:443/api/v3/versions" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  | jq # '.data[] | {name: .name, id: .id}' 

