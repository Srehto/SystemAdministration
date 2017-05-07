#! /bin/bash

# Script de configuration du serveur NFS

# Sauvegarde des fichiers de confs
echo "Sauvegarde des fichiers qui seront modifiés dans /root/save"
mkdir /root/save
mkdir /root/save/etc

cp /etc/exports /root/save/etc

# On efface les anciens fichiers
rm -f /etc/exports

#On crée les nouveaux fichiers
#EXPORTS
touch /etc/exports
echo -e "/home 192.168.129.1/255.255.255.0(rw,no_auth_nlm)" > /etc/exports
echo "fichier exports configuré"
/etc/init.d/nfs-kernel-server restart
echo "serveur NFS lancé"
echo "Pour stopper le serveur :
	/etc/init.d/nfs-kernel-server stop"
