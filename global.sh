#!/bin/bash
# global.sh

echo "Script d'installation automatique - Fonctionnel sur Debian 11"
sleep 10

echo "Lancez avec l'utilisateur root"
sleep 10

apt-get update


echo -n "Voulez vous installation un serveur ssh (y/n)?"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    cd scripts/
    sh ssh.sh
else
    echo "Installation de ssh annulée"
fi
sleep 10

echo -n "Voulez vous installation un serveur lamp (Apache2 - PHP - MariaDB - PHPMYADMIN)?"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    cd scripts/
    sh lamp.sh
else
    echo "Installation de LAMP annulée"
fi
sleep 10

echo -n "Voulez vous installation un serveur GLPI ?"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    cd scripts/
    sh glpi.sh
else
    echo "Installation de GLPI annulée"
fi
sleep 10

