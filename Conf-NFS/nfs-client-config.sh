#! /bin/bash

# Script de configuration du client NFS

# Sauvegarde des fichiers de confs
echo "Sauvegarde des fichiers qui seront modifiés dans /root/save"
mkdir /root/save
mkdir /root/save/etc

cp /etc/fstab /root/save/etc

# On efface les anciens fichiers
rm -f /etc/fstab

#On crée les nouveaux fichiers
#FSTAB
touch /etc/fstab
echo -e "
# /etc/fstab: static file system information.
#
# <file system>         <mount point>   <type>  <options>       <dump>  <pass>
proc                    /proc           proc    defaults        0       0
/dev/hda1               /               ext3    defaults,errors=remount-ro 0       1
/dev/ubdb               none            swap    sw              0       0
192.168.129.X:/home      /users          nfs     defaults

" > /etc/fstab
echo "fichier fstab configuré"
echo "Pensez à changer le X dans fstab par l'addresse de votre serveur NFS !"
mount /home
echo "fichiers montés"
echo "Pour démonter les fichiers :
	umount /home"
