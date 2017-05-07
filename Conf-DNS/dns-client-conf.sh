#! /bin/bash

# Script de configuration du client DNS

# Sauvegarde des fichiers de confs
echo "Sauvegarde des fichiers qui seront modifiés dans /root/save"
mkdir /root/save/
mkdir /root/save/etc/

cp /etc/resolv.conf /root/save/etc/
cp /etc/host.conf /root/save/etc/
echo "Les fichiers sont sauvegardés dans /root/save"
# On efface les anciens fichiers
rm -f /etc/resolv.conf
rm -f /etc/host.conf

#On crée les nouveaux fichiers
#RESOLV.CONF
touch /etc/resolv.conf
echo -e "search ecole.les-bonnes-notes\nnameserver 192.168.129.254" > /etc/resolv.conf
echo "fichier resolv.conf configuré"
#HOST.CONF
touch /etc/host.conf
echo -e "order hosts, bind\nmulti on" > /etc/host.conf
echo "fichier host.conf configuré"
