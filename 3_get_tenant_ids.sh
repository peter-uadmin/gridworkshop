clear
#get bearer token
echo  "get bearer token : "
export token=`curl -s -k -X POST "https://192.168.4.230:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "br@@mspun111"}'|jq -r '.data'`

echo "using bearer $token"
echo  "list /api/v3/accounts "
echo ""
curl -s -X GET "https://192.168.4.230:443/api/v3/grid/accounts" \
-H "accept: application/json"  -H "Authorization: Bearer $token" -k  \
| jq '.data[] | {name: .name, id: .id}'

