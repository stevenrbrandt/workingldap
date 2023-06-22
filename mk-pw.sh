set -a
source /ldap-vars.env
echo -n ${LDAP_ADMIN_PASSWORD} > /etc/pw-admin.txt
chmod 600 /etc/pw-admin.txt
