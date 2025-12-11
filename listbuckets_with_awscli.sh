#!/usr/bin/bash
clear
echo "getting token:"
token=$(curl -s -k -X POST "https://192.168.4.230:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "br@@mspun111"}'|jq -r '.data')
echo ====
echo $token
echo ====
echo "getting tenants:"
echo ====
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/accounts" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  |jq -r '.data[] | "\(.name) \(.id)"'
echo ====
echo "copy/paste tenant id..."
echo -n "tenant id: "
read tenant
aws s3api --endpoint-url https://192.168.4.230:10443 --no-verify-ssl list-buckets  --profile grid


