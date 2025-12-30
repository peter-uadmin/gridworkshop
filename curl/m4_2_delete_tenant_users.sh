#!/usr/bin/env bash
# Config – set these before running
# First get grid grid_token
#!/usr/bin/bash
#first get the grid_token.
grid_token=$(curl -s -k -X POST "https://192.168.4.230:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "br@@mspun111"}'|jq -r '.data')
#
clear
#filter name and id
echo using jq to filter out name and id
echo
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/accounts" -H "accept: application/json"  -H "Authorization: Bearer $grid_token" -k  |jq -r '.data[] | "\(.name) \(.id)"'
echo ========

read -rp "Tenant_id: " TENANT_ID
TENANT_ROOT_USER="root"
TENANT_ROOT_PASS="br@@mspun111"
ENDPOINT="https://192.168.4.230:443"

# 1) Get tenant auth grid_token
AUTH_RESPONSE=$(curl -sk \
  -H "Content-Type: application/json" \
  -X POST \
  -d "{\"accountId\": \"${TENANT_ID}\", \"username\": \"${TENANT_ROOT_USER}\", \"password\": \"${TENANT_ROOT_PASS}\"}" \
  "${ENDPOINT}/api/v3/authorize")

tenant_token=$(echo "${AUTH_RESPONSE}" | jq -r '.data')

if [ -z "${tenant_token}" ] || [ "${tenant_token}" = "null" ]; then
  echo "Failed to obtain auth grid_token"
  echo "${AUTH_RESPONSE}"
  exit 1
fi

echo "Got grid_token: ${tenant_token}"

# 2) List tenant users
curl -sk \
  -H "Accept: application/json" \
  -H "Authorization: Bearer ${tenant_token}" \
  "${ENDPOINT}/api/v3/org/users" | jq -r '.data[] | "\(.fullName), \(.id)"'
echo "========"

read -rp "User_id to delete: " USER_ID

# 4) Delete the selected user
echo "Deleting user id ${USER_ID} from tenant ${TENANT_ID} ..."
DELETE_RESPONSE=$(
  curl -sk -X DELETE \
	  echo "Deleting user id ${USER_ID} from tenant ${TENANT_ID} ..."
  DELETE_RESPONSE=$(
    curl -sk -X DELETE \
	        -H "Accept: application/json" \
		    -H "Authorization: Bearer ${tenant_token}" \
		        "${ENDPOINT}/api/v3/org/users/${USER_ID}"
		)

		echo "Response:"
		echo "${DELETE_RESPONSE}"
)

