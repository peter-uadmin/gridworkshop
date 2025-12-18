#!/usr/bin/env bash
# Variables – set these before running
TENANT_ID="123456789012"          # tenant account ID
TENANT_ROOT_USER="root"
TENANT_ROOT_PASS="root_password"
NEW_USER_NAME="user/jdoe"         # StorageGRID unique_name format is usually 'user/<name>'[web:27]
NEW_USER_FULL_NAME="John Doe"
NEW_USER_PASSWORD="SomeSecretPass!"

ENDPOINT="https://192.168.4.230:443"

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

# 2) Create tenant user
curl -sk \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  -X POST \
  -d "{
        \"uniqueName\": \"${NEW_USER_NAME}\",
        \"fullName\": \"${NEW_USER_FULL_NAME}\",
        \"password\": \"${NEW_USER_PASSWORD}\",
        \"disable\": false
      }" \
  "${ENDPOINT}/api/v3/org/users" | jq .

