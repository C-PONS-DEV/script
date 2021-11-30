#!/bin/bash
# lamp.sh

echo "Script d'installation automatique de LAMP (Apache2 - PHP - MariaDB - PHPMYADMIN)"
echo "Lancez avec l'utilisateur root"



echo "Installation apache2"

apt-get install -y apache2
systemctl enable apache2

ip a
echo "Vous pouvez vous rendre sur http://ip voir si le site et fonctionnel."

a2enmod rewrite
a2enmod deflate
a2enmod headers
a2enmod ssl
systemctl restart apache2


echo "Installation de php"
apt-get install -y php
apt-get install -y php-pdo php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath

echo "<?php phpinfo(); ?>" >> /var/www/html/info.php

echo "Vous pouvez vous rendre sur http://ip/info.php pour voir les infos php."

echo "Installation de mariadb"
apt-get install -y mariadb-server
mariadb-secure-installation
systemctl restart mariadb



echo -n "Voulez vous installez phpmyadmin (y/n)?"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    echo "Installation de phpmyadmin"
    apt-get install phpmyadmin -y
    echo "Installation de phpmyadmin terminée, rendez vous sur http://ip/phpmyadmin."
else
    echo "Installation de phpmyadmin annulée"
fi