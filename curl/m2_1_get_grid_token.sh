#!/usr/bin/bash
clear
echo "all fields"
echo
curl -s -k -X POST "https://192.168.0.80:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "Netapp1!"}'|jq -r 
echo 
echo ========================================================
echo -n "to only show the token, press enter: "
read
curl -s -k -X POST "https://192.168.0.80:443/api/v3/authorize" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-d '{"username": "root", "password": "Netapp1!"}'|jq -r '.data'

