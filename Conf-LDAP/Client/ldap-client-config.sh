#! /bin/bash

# Script de configuration du client LDAP

# Sauvegarde des fichiers de confs
echo "Sauvegarde des fichiers qui seront modifiés dans /root/save"
mkdir /root/save
mkdir /root/save/etc
mkdir /root/save/etc/ldap
mkdir /root/save/etc/pam.d

cp /etc/ldap/ldap.conf /root/save/etc/ldap/
cp /etc/libnss-ldap.conf /root/save/etc/
cp /etc/libnss-ldap.secret /root/save/etc/
cp /etc/nsswitch.conf /root/save/etc/
cp /etc/pam_ldap.conf /root/save/etc/

cp /etc/pam.d/common-account /root/save/etc/pam.d/
cp /etc/pam.d/common-auth /root/save/etc/pam.d/
cp /etc/pam.d/common-password /root/save/etc/pam.d/
cp /etc/pam.d/common-session /root/save/etc/pam.d/
echo "Les fichiers sont sauvegardés dans /root/save"

# On efface les anciens fichiers
rm -f /etc/ldap/ldap.conf
rm -f /etc/libnss-ldap.conf
rm -f /etc/libnss-ldap.secret
rm -f /etc/pam_ldap.conf
rm -f /etc/nsswitch.conf
rm -f /etc/pam.d/common-account
rm -f /etc/pam.d/common-auth
rm -f /etc/pam.d/common-password
rm -f /etc/pam.d/common-session

#On crée les nouveaux fichiers
#LDAP.CONF
touch /etc/ldap/ldap.conf
echo -e "BASE    dc=les-bonnes-notes,dc=fr
HOST    192.168.10.X
URI     ldap://192.168.10.1
" > /etc/ldap/ldap.conf
echo "fichier ldap.conf configuré."

#LIBNSS-LDAP.CONF
touch /etc/libnss-ldap.conf
echo -e "host 192.168.10.X
base dc=les-bonnes-notes,dc=fr
uri ldap://192.168.10.X
ldap_version 3
" > /etc/libnss-ldap.conf
echo "fichier libnss-ldap.conf configuré."

#LIBNSS-LDAP.SECRET
touch /etc/libnss-ldap.secret
echo -e "secret" > /etc/libnss-ldap.secret
echo "fichier libnss-ldap.secret configuré."

#NSSWITCH.CONF
touch /etc/nsswitch.conf
echo -e "
passwd:         files ldap
group:          files ldap
shadow:         files ldap

hosts:          files dns
networks:       files

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       nis" > /etc/nsswitch.conf
echo "fichier nsswitch.conf configuré."

#PAM_LDAP.CONF
touch /etc/pam_ldap.conf
echo -e "
host 192.168.10.X
base dc=univ-paris13,dc=fr
ldap_version 3" > /etc/pam_ldap.conf
echo "fichier pam_ldap.conf configuré."

#COMMON-ACCOUNT
touch /etc/pam.d/common-account
echo -e "
account sufficient 	pam_ldap.so
account	required	pam_unix.so
" > /etc/pam.d/common-account
echo "fichier common-account configuré."

#COMMON-AUTH
touch /etc/pam.d/common-auth
echo -e "
auth 	sufficient	pam_ldap.so
auth	required	pam_unix.so nullok_secure
" > /etc/pam.d/common-auth
echo "fichier common-auth configuré."

#COMMON-PASS
touch /etc/pam.d/common-password
echo -e "
password   sufficient pam_ldap.so
password   required   pam_unix.so
" > /etc/pam.d/common-password
echo "fichier common-password configuré."

#COMMON-SESSION
touch /etc/pam.d/common-session
echo -e "
session sufficient	pam_ldap.so
session	required	pam_unix.so
" > /etc/pam.d/common-session
echo "fichier common-session configuré."

#Redemmarage de nscd
/etc/init.d/nscd restart

#FIN
echo "Les fichiers ont été configuré correctement."
echo "Modifier l'addresse IP dans les fichier
	
	/etc/ldap/ldap.conf
	/etc/libnss-ldap.conf
	/etc/pam_ldap.conf
S'il s'agit du serveur, remplacez par 127.0.0.1
Eventuellement, redemmarez nscd"

