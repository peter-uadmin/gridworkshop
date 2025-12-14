ADDR=192.168.4.230
GRID_USER="root"                 # grid admin
GRID_PASS="br@@mspun111"
echo -n "tenant: "
read tenant
echo -n "password: "
read password

# 1) Get grid admin token
GRID_TOKEN=$(curl -k -s -X POST "https://${ADDR}/api/v3/authorize" \
  -H "Content-Type: application/json" \
  -d "{
        \"username\": \"${GRID_USER}\",
        \"password\": \"${GRID_PASS}\",
        \"cookie\": false,
        \"csrfToken\": false
      }" | jq -r '.data')

# 2) Create tenant with 
curl -k -X POST \
  "https://192.168.4.230/api/v4/grid/accounts" \
  -H "Authorization: Bearer ${GRID_TOKEN}" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d @- <<EOF
{
  "name": "${tenant}",
  "description": "Email address: test@example.com",
  "capabilities": [
    "management",
    "s3"
  ],
  "policy": {
    "useAccountIdentitySource": false,
    "allowPlatformServices": false,
    "allowSelectObjectContent": false,
    "quotaObjectBytes": 100000000000
  },
  "password": "${password}"
}
EOF

