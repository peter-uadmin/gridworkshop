openssl s_client -connect 192.168.0.80:443 -showcerts </dev/null 2>/dev/null   | sed -n '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /root/gridworkshop/grid_admin.pem
