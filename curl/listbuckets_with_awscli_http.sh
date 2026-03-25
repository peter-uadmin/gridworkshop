#/usr/bin/env bash

aws s3api --endpoint-url http://192.168.0.80:10447 --no-verify-ssl list-buckets  --profile finance
