curl -k -s   -H "Authorization: Bearer 44aea1b6-c2ad-4462-8bba-d76483a9404f "   https://192.168.4.230/api/v4/grid/ilm-rules   | jq '.data[] | select(.displayName=="Make 2 Copies") | .id'

