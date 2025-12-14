#!/usr/bin/env bash
set -euo pipefail

ADDR=192.168.4.230
GRID_USER="root"              # grid admin
echo -n "grid root password: "
read GRID_PASS

echo -n "Tenant ID to delete: "
read TENANT_ID

# 1) Get grid admin token
GRID_TOKEN=$(curl -k -s -X POST "https://${ADDR}/api/v3/authorize" \
  -H "Content-Type: application/json" \
  -d "{
        \"username\": \"${GRID_USER}\",
        \"password\": \"${GRID_PASS}\",
        \"cookie\": false,
        \"csrfToken\": false
      }" | jq -r '.data')

# 2) Delete tenant account
curl -k -s -X DELETE "https://${ADDR}/api/v3/grid/accounts/${TENANT_ID}" \
  -H "Authorization: Bearer ${GRID_TOKEN}" \
  -H "Content-Type: application/json"
echo

