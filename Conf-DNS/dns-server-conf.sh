#! /bin/bash

# Script de configuration du serveur DNS

# Sauvegarde des fichiers de confs
echo "Sauvegarde des fichiers qui seront modifiés dans /root/save"
mkdir /root/save/
mkdir /root/save/etc/
mkdir /root/save/etc/bind/

cp /etc/resolv.conf /root/save/etc/
cp /etc/bind/named.conf.local /root/save/bind/
cp /etc/bind/named.conf.options /root/save/bind/
echo "Les fichiers sont sauvegardés dans /root/save"
# On efface les anciens fichiers
rm -f /etc/resolv.conf
rm -f /etc/bind/named.conf.local
rm -f /etc/bind/named.conf.options

#On crée les nouveaux fichiers
#RESOLV.CONF
touch /etc/resolv.conf
echo -e "search ecole.les-bonnes-notes.fr\nnameserver localhost" > /etc/resolv.conf
echo "fichier resolv.conf configuré"

#NAMED.CONF.LOCAL
touch /etc/bind/named.conf.local
echo  -e "// Zone primaire\nzone \"ecole.les-bonnes-notes.fr\" {\n\ttype master;\n\tnotify yes;\n\tfile \"/etc/bind/db.ecole.les-bonnes-notes.fr\";\n};\n// Zone reverse\nzone \"129.168.192.in-addr.arpa\" {\n\ttype master;\n\tnotify yes;\n\tfile \"/etc/bind/db.192.168.0\";\n};" > /etc/bind/named.conf.local
echo "fichier named.conf.local configuré"

#NAMED.CONF.OPTIONS
touch /etc/bind/named.conf.options
echo -e "options {\n\tdirectory \"/var/cache/bind\";\n\tauth-nxdomain no;\n\tlisten-on-v6 { any; };\n};" > /etc/bind/named.conf.options

#DB.192.168.0
touch /etc/bind/db.192.168.0
echo -e "\$TTL\t604800\n@\tIN\tSOA\tpasserelle.ecole.les-bonnes-notes.fr. hostmaster.ecole.les-bonnes-notes.fr. (\n\t\t\t201301312\t; Serial\n\t\t\t604800\t\t; Refresh\n\t\t\t86400\t\t; Retry\n\t\t\t2419200\t; Expire\n\t\t\t604800 )\t; Negative Cache TTL\n;\n\$ORIGIN 129.168.192.in-addr.arpa.\n\n\tNS\tdns.ecole.les-bonnes-notes.fr.\nnum_ip\tPTR\tnom.ecole.les-bonnes-notes.fr." > /etc/bind/db.192.168.0
#DB.ecole.les-bonnes-notes.fr
touch /etc/bind/db.ecole.les-bonnes-notes.fr
echo -e "\$TTL\t604800\n@\tIN\tSOA\tpasserelle.ecole.les-bonnes-notes.fr. hostmaster.ecole.les-bonnes-notes.fr. (\n\t\t\t201301312\t; Serial\n\t\t\t604800\t\t; Refresh\n\t\t\t86400\t\t; Retry\n\t\t\t2419200\t; Expire\n\t\t\t604800 )\t; Negative Cache TTL\n;\n\$ORIGIN ecole.les-bonnes-notes.fr.\n\n\tIN\tNS\t\t\tdns.ecole.les-bonnes-notes.fr.\n;\tNS\tdns2.ecole.les-bonnes-notes.fr.\n;MX\t10\tmail.ecole.les-bonnes-notes.fr.\nnom\t\t\t\tA\t192.168.129.num" > /etc/bind/db.ecole.les-bonnes-notes.fr

echo "DNS configuré avec le nom de machine \"passerelle\". Un serveur esclave peut etre situé à l'adresse : 192.168.10.4"
echo "Le debut est fait. Maintenant, modifiez les fichiers db.192.168.0 et db.ecole.les-bonnes-notes.fr"
echo "Lancez ensuite le serveur DNS avec /etc/init.d/bind9"
echo -e "Pour ajouter un serveur esclave, rajouter la ligne\n allow-transfer {192.168.20.X; };\ndans le fichier named.conf.options"
