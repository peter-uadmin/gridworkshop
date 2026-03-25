#!/usr/bin/bash
echo
echo "all fields"
echo
curl -s -k -X POST "https://192.168.0.80:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "Netapp1!!"}'|jq -r
echo
echo ========================================================
echo
echo "only the data field"
echo
curl -s -k -X POST "https://192.168.0.80:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "Netapp1!"}'|jq -r '.data'
