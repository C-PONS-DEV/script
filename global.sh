#!/bin/bash
# global.sh

echo "Script d'installation automatique - Fonctionnel sur Debian 11"
sleep 10

echo "Il et recommandez de ne pas lancez ce script en SSH "
sleep 10

echo "Lancez avec l'utilisateur root"
sleep 10

apt-get update

echo -n "Voulez vous configurer une ip fixe ? (y/n)"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    cd scripts/
    sh ip.sh
else
    echo "Installation de ssh annulée"
fi
sleep 10

echo -n "Voulez vous installation un serveur ssh ? (y/n)"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    cd scripts/
    sh ssh.sh
else
    echo "Installation de ssh annulée"
fi
sleep 10

echo -n "Voulez vous installation un serveur lamp (Apache2 - PHP - MariaDB - PHPMYADMIN) ? (y/n)"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    cd scripts/
    sh lamp.sh
else
    echo "Installation de LAMP annulée"
fi
sleep 10

echo -n "Voulez vous installation un serveur GLPI ? (y/n)"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    cd scripts/
    sh glpi.sh
else
    echo "Installation de GLPI annulée"
fi
sleep 10

echo -n "Voulez vous installation un serveur Bind9 ? (y/n)"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    cd scripts/
    sh bind9.sh
else
    echo "Installation de Bind9 annulée"
fi
sleep 10

echo -n "Voulez vous faires une sauvegarde SQL ? (y/n)"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    cd scripts/
    sh saveSQL.sh
else
    echo "Sauvegarde de SQL annulée"
fi
sleep 10

echo -n "Voulez vous installez un domaine Samba ? (y/n)"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    cd scripts/
    sh samba.sh
else
    echo "Installation de Samba annulée"
fi
sleep 10

echo "Redémarrage du serveur"
sleep 10
reboot