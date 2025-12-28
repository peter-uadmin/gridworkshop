curl -k -s -X 'POST' \
  'https://192.168.4.230/api/v4/authorize' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'X-Csrf-Token: 0a937a4c53b925be2f595204a5a1c33c' \
  -d '{
  "username": "root",
  "password": "br@@mspun111",
  "cookie": true,
  "csrfToken": false
}'
