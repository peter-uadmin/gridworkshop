curl -s -k -X 'POST' \
  'https://192.168.0.80/api/v4/authorize' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'X-Csrf-Token: ef7bdae5ecd09246824d388f85843259' \
  -d '{
  "username": "root",
  "password": "Netapp1!",
  "cookie": true,
  "csrfToken": false
}'
