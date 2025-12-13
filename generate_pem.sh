#generate cert

openssl genrsa -out sg-client-key.pem 2048

openssl req -new -x509 -key sg-client-key.pem -out sg-client-cert.pem \
-days 365 -subj "/CN=ansible-control"

