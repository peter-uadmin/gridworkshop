#!/usr/bin/bash
#first get the token.
token=$(curl -s -k -X POST "https://192.168.4.230:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "br@@mspun111"}'|jq -r '.data')
#
clear
echo 
echo "raw data"
echo
echo ========
#run curl to list all tenants unfiltered
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/accounts" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  
sleep 1
echo ========
echo 
#run curl again but now with a filter
echo using jq to filter out name and id
echo 
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/accounts" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  |jq -r '.data[] | "\(.name) \(.id)"' 
echo ========
