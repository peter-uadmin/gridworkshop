
curl -X 'POST' \
  'https://192.168.4.230/api/v4/grid/accounts' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'X-Csrf-Token: 483072a1467dfc1f6bf958e471a14aa1' \
  -d '{
  "name": "tenantoo",
  "description": "Email address: test@example.com",
  "capabilities": [
    "management",
    "s3"
  ],
  "synchronizeRules": {
    "createUser": true,
    "createGroup": true,
    "createKey": false
  },
  "policy": {
    "useAccountIdentitySource": true,
    "allowPlatformServices": false,
    "allowSelectObjectContent": false,
    "allowedGridFederationConnections": [
      "eb38438e-c05b-11ec-9297-549000ba143d"
    ],
    "quotaObjectBytes": 100000000000
  },
  "password": "my password",
  "grantRootAccessToGroup": "federated-group/developers",
  "s3Bucket": {
    "enableVersioning": true,
    "name": "bucket-1",
    "region": "us-east-1",
    "s3ObjectLock": {
      "enabled": false,
      "defaultRetentionSetting": {
        "mode": "compliance",
        "days": 365,
        "years": 1
      }
    }
  },
  "s3AccessKeys": {
    "expires": "2028-09-04T00:00:00.000Z"
  }
}'
