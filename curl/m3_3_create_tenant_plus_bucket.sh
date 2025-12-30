#take care with the "here" part. Closing EOF must be on separate line with no trailing spaces
ADDR=192.168.4.230
GRID_USER="root"                 # grid admin
GRID_PASS="br@@mspun111"
echo -n "tenantname: "
read tenant
echo -n "password: "
read password
echo -n "bucket: "
read bucket
# 1) Get grid admin token
GRID_TOKEN=$(curl -k -s -X POST "https://${ADDR}/api/v3/authorize" \
  -H "Content-Type: application/json" \
  -d @- <<EOF |
{
        "username": "${GRID_USER}", "password": "${GRID_PASS}", "cookie": false, "csrfToken": false
      } 
EOF
jq -r '.data')

curl -k -X POST \
  "https://${ADDR}/api/v4/grid/accounts" \
  -H "Authorization: Bearer ${GRID_TOKEN}" \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -d @- <<EOF
{
  "name": "${tenant}",
  "description": "Email address: test@example.com",
  "capabilities": [
    "management",
    "s3"
  ],
  "policy": {
    "useAccountIdentitySource": true,
    "allowPlatformServices": false,
    "allowSelectObjectContent": false,
    "quotaObjectBytes": 100000000000
  },
  "password": "${password}",
  "s3Bucket": {
    "enableVersioning": false,
    "name": "${bucket}",
    "region": "us-east-1",
    "s3ObjectLock": {
      "enabled": false
    }
  }
}
EOF

