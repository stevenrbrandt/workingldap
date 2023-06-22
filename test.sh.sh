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

cat > foo.ldif << EOF
# define ldif file with record arrtributes
# file saved with foo.lfip
dn: uid=foo,${LDAP_BASE_DN}
uid: foo
cn: foo
sn: 3
objectClass: top
objectClass: posixAccount
objectClass: inetOrgPerson
loginShell: /bin/bash
homeDirectory: /home/foo
uidNumber: 1234
gidNumber: 100
userPassword: sithlord1
mail: foo@${LDAP_DOMAIN}
gecos: Foo User
EOF
ldapadd -x -H ldap://${LDAP_HOST} -D "cn=admin,${LDAP_BASE_DN}" -f foo.ldif -y /etc/pw-admin.txt

ldapsearch -x -H ldap://${LDAP_HOST} -b ${LDAP_BASE_DN} -D "cn=admin,${LDAP_BASE_DN}" -y /etc/pw-admin.txt
id yoda
if [ \$? = 0 ]; then echo "User yoda successfully added!"; fi
id foo
if [ \$? != 0 ]; then echo "User 'foo' correctly failed to be added! (same uidNumber as 'yoda')"; fi
EOT
