ADDR=192.168.4.230
GRID_USER="root"                 # grid admin
GRID_PASS="br@@mspun111"

# 1) Get grid admin token
GRID_TOKEN=$(curl -k -s -X POST "https://${ADDR}/api/v3/authorize" \
  -H "Content-Type: application/json" \
  -d "{
        \"username\": \"${GRID_USER}\",
        \"password\": \"${GRID_PASS}\",
        \"cookie\": false,
        \"csrfToken\": false
      }" | jq -r '.data')

# 2) Create tenant with minimal fields
echo -n "Tenant_name: "
read TENANT_NAME
echo -n "Tenant root password: "
read ROOT_PASS

curl -k -s -X POST "https://${ADDR}/api/v3/grid/accounts" \
  -H "Authorization: Bearer ${GRID_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{
        \"name\": \"${TENANT_NAME}\",
        \"password\": \"${ROOT_PASS}\"
      }"

