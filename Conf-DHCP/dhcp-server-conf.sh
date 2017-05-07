#! /bin/bash

# Script de configuration du serveur DHCP

# Sauvegarde des fichiers de confs
echo "Sauvegarde des fichiers qui seront modifiés dans /root/save"
mkdir /root/save
cp /etc/dhcp3/dhcpd.conf /root/save/
cp /etc/default/dhcp3-server /root/save/
echo "Les fichiers dhcp.conf et dhcp3-server sont sauvegardés dans /root/save"
# On efface les anciens fichiers
rm -f /etc/dhcp3/dhcpd.conf
rm -f /etc/default/dhcp3-server

# On écrit le nouveau dhcp.conf
touch /etc/dhcp3/dhcpd.conf
echo -e "Configuration du serveur DHCP ..."
echo -e "
ddns-update-style none;
default-lease-time 600;
max-lease-time 7200;

option subnet-mask 255.255.255.0;
option broadcast-address 192.168.129.255;
option routers 192.168.129.254;
#option domain-name-servers ;
#option domain-name \"ecole.les-bonnes-notes.fr\";

subnet 192.168.129.0 netmask 255.255.255.0
{
        range 192.168.129.20 192.168.129.250;
}" > /etc/dhcp3/dhcpd.conf

echo -e "INTERFACES=\"eth0\"" > /etc/default/dhcp3-server

echo "Serveur DHCP OK"
echo "Pensez à rajouter manuellement les machines aux adresses statiques"
echo "lancement du serveur en mode continue"
/usr/sbin/dhcpd3 -d -f

