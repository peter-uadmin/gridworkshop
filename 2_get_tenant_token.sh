#!/usr/bin/bash

echo "this lists all tenant ids,"
echo "buffer an id and paste it."
echo -n "press enter"
read
./3_get_tenant_ids.sh
echo -n "id: "
read t_id
export t_id
#get tenant_ids
#get token
echo "$t_id"
curl -k -s \
  -X POST "https://192.168.4.230/api/v3/authorize" \
  -H "Content-Type: application/json" \
  -d @- <<EOF
    {
    "username": "root",
    "password": "br@@mspun111",
    "accountId": "$t_id"
     }
EOF
