openssl s_client -connect 192.168.4.230:443 -showcerts </dev/null 2>/dev/null   | sed -n '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > m2_sgrid_admin.pem
