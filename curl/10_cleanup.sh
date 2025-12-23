To clean up all tenants
1. List all tenants 
2. use awk to just get the names
3. for i in `cat allnames`; do play 3_delete_tenant_v1.yml --extra-vars "tenant_name=$i"; done
