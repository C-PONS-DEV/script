#!/bin/bash
# lamp.sh

echo "Script d'installation automatique de LAMP (Apache2 - PHP - MariaDB - PHPMYADMIN)"
echo "Lancez avec l'utilisateur root"


echo "Voulez vous installation un serveur ssh (y/n)? "
read answer

if $answer = "y" ; then
    echo "Installation de ssh"
    apt-get install openssh-server -y
    echo "Installation de openssh-server terminée"
else
    echo "Installation de ssh annulée"
fi




