#!/usr/bin/env bash
# Config – set these before running
# First get grid token
#!/usr/bin/bash
#first get the token.
token=$(curl -s -k -X POST "https://192.168.0.80:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "Netapp1!"}'|jq -r '.data')
#
clear
#filter name and id
echo using jq to filter out name and id
echo
curl -s -X GET "https://192.168.0.80:443/api/v3/grid/accounts" -H "accept: application/json"  -H "Authorization: Bearer $token" -k  |jq -r '.data[] | "\(.name) \(.id)"'
echo ========

read -rp "Tenant_id: " TENANT_ID
TENANT_ROOT_USER="root"
TENANT_ROOT_PASS="Netapp1!"
ENDPOINT="https://192.168.0.80:443"

# 1) Get tenant auth token
AUTH_RESPONSE=$(curl -sk \
  -H "Content-Type: application/json" \
  -X POST \
  -d "{\"accountId\": \"${TENANT_ID}\", \"username\": \"${TENANT_ROOT_USER}\", \"password\": \"${TENANT_ROOT_PASS}\"}" \
  "${ENDPOINT}/api/v3/authorize")

TOKEN=$(echo "${AUTH_RESPONSE}" | jq -r '.data')

if [ -z "${TOKEN}" ] || [ "${TOKEN}" = "null" ]; then
  echo "Failed to obtain auth token"
  echo "${AUTH_RESPONSE}"
  exit 1
fi

echo "Got token: ${TOKEN}"

# 2) List tenant users
curl -sk \
  -H "Accept: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  "${ENDPOINT}/api/v3/org/users" | jq -r '.data[] | "\(.fullName)"'

