curl -k -s \
  -X POST "https://192.168.4.230/api/v3/authorize" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "root",
    "password": "br@@mspun111",
    "accountId": "18815655567777745228"
     }' |jq -r '.data'

