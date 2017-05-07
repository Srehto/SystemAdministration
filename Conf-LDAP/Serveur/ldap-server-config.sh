#! /bin/bash

# Script de configuration du serveur LDAP

# Sauvegarde des fichiers de confs
echo "Sauvegarde des fichiers qui seront modifiés dans /root/save"
mkdir /root/save
mkdir /root/save/etc
mkdir /root/save/etc/ldap

cp /etc/ldap/ldap.conf /root/save/etc/ldap/
cp /etc/ldap/slapd.conf /root/save/etc/ldap/
echo "Les fichiers sont sauvegardés dans /root/save"

# On efface les anciens fichiers
rm -f /etc/ldap/ldap.conf
rm -f /etc/ldap/slapd.conf


#On crée les nouveaux fichiers
#LDAP.CONF
touch /etc/ldap/ldap.conf
echo -e "
HOST	127.0.0.1
BASE	dc=les-bonnes-notes,dc=fr
URI	ldap://127.0.0.1" > /etc/ldap/ldap.conf
echo "fichier ldap.conf configuré"

#SLAPD.CONF
touch /etc/ldap/slapd.conf
echo -e "
include         /etc/ldap/schema/core.schema
include         /etc/ldap/schema/cosine.schema
include         /etc/ldap/schema/nis.schema
include         /etc/ldap/schema/inetorgperson.schema

pidfile         /var/run/slapd/slapd.pid

argsfile        /var/run/slapd/slapd.args

loglevel        none

modulepath      /usr/lib/ldap
moduleload      back_hdb

sizelimit 500

tool-threads 1

backend         hdb
database        hdb

suffix          \"dc=les-bonnes-notes,dc=fr\"
rootdn          \"cn=direction,dc=les-bonnes-notes,dc=fr\"
directory       \"/var/lib/ldap\"

dbconfig set_cachesize 0 2097152 0
dbconfig set_lk_max_objects 1500
dbconfig set_lk_max_locks 1500
dbconfig set_lk_max_lockers 1500

index   objectClass     eq
index   uid             eq,pres,sub

lastmod         on
checkpoint      512 30

access to attrs=userPassword,shadowLastChange
        by dn=\"cn=direction,dc=les-bonnes-notes,dc=fr\" write
        by anonymous auth
        by self write
        by * none

access to dn.base=\"\" by * read

access to *
        by dn=\"cn=direction,dc=les-bonnes-notes,dc=fr\" write
        by * read" > /etc/ldap/slapd.conf
echo "fichier slapd.conf configuré"

/etc/init.d/slapd restart
#On done a openldap un dossier
chown openldap /var/lib/ldap/*

#Création répertoir LDIF
mkdir /root/ldif
echo "Les fichier de configurations sont crées."
echo "Rajouter des fichier ldif dans /root/ldif"
echo "puis faites
	/etc/init.d/slapd stop
 	slapadd </root/ fichier.ldif 
	chown openldap /var/lib/ldap/*
	/etc/init.d/slapd start
ou 
	ldapadd -h localhost -D 'cn=admin, dc=univ-paris13, dc=fr' -x -W -f fichier.ldif"



