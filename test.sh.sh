cat > test.sh << EOT
cat > yoda.ldif << EOF
# define ldif file with record arrtributes
# file saved with yoda.lfip
dn: uid=yoda,${LDAP_BASE_DN}
uid: yoda
cn: yoda
sn: 3
objectClass: top
objectClass: posixAccount
objectClass: inetOrgPerson
loginShell: /bin/bash
homeDirectory: /home/yoda
uidNumber: 1234
gidNumber: 100
userPassword: ${LDAP_ADMIN_PASSWORD}
mail: yoda@${LDAP_DOMAIN}
gecos: yoda User
EOF
ldapadd -x -H ldap://${LDAP_HOST} -D "cn=admin,${LDAP_BASE_DN}" -f yoda.ldif -y /etc/pw-admin.txt

cat > spock.ldif << EOF
# define ldif file with record arrtributes
# file saved with spock.lfip
dn: uid=spock,${LDAP_BASE_DN}
uid: spock
cn: spock
sn: 3
objectClass: top
objectClass: posixAccount
objectClass: inetOrgPerson
loginShell: /bin/bash
homeDirectory: /home/spock
uidNumber: 1234
gidNumber: 100
userPassword: sithlord1
mail: spock@${LDAP_DOMAIN}
gecos: spock User
EOF
ldapadd -x -H ldap://${LDAP_HOST} -D "cn=admin,${LDAP_BASE_DN}" -f spock.ldif -y /etc/pw-admin.txt

ldapsearch -x -H ldap://${LDAP_HOST} -b ${LDAP_BASE_DN} -D "cn=admin,${LDAP_BASE_DN}" -y /etc/pw-admin.txt
id yoda
if [ \$? = 0 ]; then echo "User yoda successfully added!"; fi
id spock
if [ \$? != 0 ]; then echo "User 'spock' correctly failed to be added! (same uidNumber as 'yoda')"; fi
EOT
