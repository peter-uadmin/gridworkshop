#!/usr/bin/bash
clear
#first get a bearer token for the root user of the tenant.
#first list tenants
echo "list tenant ids"
./get_tenant_ids.sh

#set variables
#
echo setting variables
echo -n "tenant id: "
read tenant_id

ADDR=192.168.4.230                  # Admin node / LB
TENANT_ID=$tenant_id           	    # tenant account ID
USER="root"                         # tenant admin/root user
PASS="br@@mspun111"		    # tenant password

#get bearer token
token=$(curl -s -k -X POST "https://${ADDR}/api/v3/authorize" -H "Content-Type: application/json"  -d "{ \"accountId\": \"${TENANT_ID}\", \"username\": \"${USER}\", \"password\": \"${PASS}\" }" | jq -r '.data') 

#list users and select target-user
id=$(curl -s -k -X GET "https://192.168.4.230/api/v4/org/users" -H "Authorization: Bearer $token" -H "Content-Type: application/json" | jq -r '.data[].id')

#create and get the user's access keys
curl -s -k -X POST   "https://192.168.4.230/api/v4/org/users/$id/s3-access-keys"   -H "Authorization: Bearer $token"   -H "Content-Type: application/json"   -d '{}'

#add the keys to ~/.aws/credentials under a new profile
[griduser]
aws_access_key_id = AJ2I284C0YD22A06DTHA 
aws_secret_access_key = koCXlEqFTttJEkd6lEbcqnncvZGjCdQ4s8BrTqMa

#list the buckets
aws s3 ls  --endpoint-url https://192.168.4.230:10443 --no-verify-ssl s3:// --profile griduser
