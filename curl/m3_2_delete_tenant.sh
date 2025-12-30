#!/usr/bin/env bash
clear
set -euo pipefail

# 1) get grid info
ADDR=192.168.4.230
GRID_USER="root"              # grid admin
GRID_PASS="br@@mspun111"
echo

# 2) Get grid admin token
token=$(curl -k -s -X POST "https://${ADDR}/api/v3/authorize" \
  -H "Content-Type: application/json" \
  -d "{
        \"username\": \"${GRID_USER}\",
        \"password\": \"${GRID_PASS}\",
        \"cookie\": false,
        \"csrfToken\": false
      }" | jq -r '.data')

# 3) Get tenants
echo "listing tenants: "
echo "---------------  "
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/accounts" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  |jq -r '.data[] | "\(.name) \(.id)"'

# 4) Paste ID
echo -n "Tenant ID to delete: "
read TENANT_ID

# 5) Delete tenant
curl -k -s -X DELETE "https://${ADDR}/api/v3/grid/accounts/${TENANT_ID}" \
  -H "Authorization: Bearer ${token}" \
  -H "Content-Type: application/json"
echo

