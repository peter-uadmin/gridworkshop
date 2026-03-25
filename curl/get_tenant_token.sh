curl -k -s \
  -X POST "https://192.168.0.80/api/v3/authorize" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "root",
    "password": "Netapp1!",
    "accountId": "18815655567777745228"
     }' |jq -r '.data'

