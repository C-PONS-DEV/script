#!/bin/bash
# lamp.sh

echo "Script d'installation automatique de LAMP (Apache2 - PHP - MariaDB - PHPMYADMIN)"
echo "Lancez avec l'utilisateur root"


echo -n "Voulez vous installation un serveur ssh (y/n)?"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    echo "Installation de ssh"
    apt-get install openssh-server -y
    echo "Installation de openssh-server terminée"
    elif [ "$ouinon" = "n" ] || [ "$ouinon" = "N" ]; then
    echo "Installation de ssh annulée"
else
    echo "Il faut taper Y/N ou y/n"
fi