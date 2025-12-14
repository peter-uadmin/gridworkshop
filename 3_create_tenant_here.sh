ADDR=192.168.4.230
GRID_USER="root"                 # grid admin
GRID_PASS="br@@mspun111"
echo -n "tenant_name: "
read name
echo -n "tenant_pass: "
read pass
echo -n "bucketname: "
read bucket

# 1) Get grid admin token
GRID_TOKEN=$(curl -k -s -X POST "https://${ADDR}/api/v3/authorize" \
  -H "Content-Type: application/json" \
  -d "{
        \"username\": \"${GRID_USER}\",
        \"password\": \"${GRID_PASS}\",
        \"cookie\": false,
        \"csrfToken\": false
      }" | jq -r '.data')

curl -k -X POST \
  "https://192.168.4.230/api/v4/grid/accounts" \
  -H "Authorization: Bearer ${GRID_TOKEN}" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d @- <<EOF
{
  "name": "${name}",
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
  "password": "${pass}",
  "s3Bucket": {
    "enableVersioning": true,
    "name": "$bucket",
    "region": "us-east-1",
    "s3ObjectLock": {
      "enabled": false,
      "defaultRetentionSetting": {
        "mode": "compliance",
        "days": 365
      }
    }
  },
  "s3AccessKeys": {
    "expires": "2028-09-04T00:00:00.000Z"
  }
}
EOF
