#!/usr/bin/bash
echo "getting bearer token"
export token=`curl -s -k -X POST "https://192.168.0.80:443/api/v3/authorize" \
-H "accept: application/json" -H "Content-Type: application/json" -d '{"username": "root", "password": "Netapp1!"}'|jq -r '.data'` echo 

echo "using bearer $token"
curl -k -s -X 'GET' 'https://192.168.0.80/api/v4/grid/ilm-rules' -H 'accept: application/json'  -H "Authorization: Bearer $token" -H 'X-Csrf-Token: de162573f57192c02670757fa32583f3'


