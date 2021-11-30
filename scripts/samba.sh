#!/bin/bash
# saveSQL.sh

echo "Le hostname doit être plus court que le domaine, sinon kerberos marche pas"
sleep 10
echo "Une IP fixe et requise"
sleep 10

echo ""
echo "Bienvenue dans l'utilitaire d'installation Samba"
echo ""
echo "Appuyez sur entrer pour lancer l'installation, ctrl+c pour annuler"
read tmpa
echo ""
echo "Mise à jour du système et installation des paquets"
echo ""

apt update
apt install samba
apt install winbind
apt install libnss-winbind
apt install krb5-user
apt install smbclient
apt install ldb-tools
apt install python3-crypto

echo ""
echo "Tous les paquets sont installés"
echo ""
echo "-------------------------------------"
echo ""

# Configuration Kerberos et Samba

echo "Lancement de l'installation et de la configuration de Samba"
echo ""
rm /etc/krb5.conf

touch /etc/krb5.conf

echo "[libdefaults]" >> /etc/krb5.conf
echo "Quel domaine (format : MYDOMAIN.LAN)"
read domlan
echo "Domaine (format : MYDOMAIN)"
read dom
echo "	default_realm = $domlan" >> /etc/krb5.conf
echo "	dns_lookup_kdc = true" >> /etc/krb5.conf
echo "	dns_lookup_realm = false" >> /etc/krb5.conf

echo ""
echo "Fichier krb5.conf configuré"
echo ""

echo "Quel Hostname ? (Minuscule)"
read hostname

rm /etc/hosts

touch /etc/hosts

echo "127.0.0.1       localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.$domlan  $hostname" >> /etc/hosts
echo "# The following lines are desirable for IPv6 capable hosts" >> /etc/hosts
echo "::1     localhost ip6-localhost ip6-loopback" >> /etc/hosts
echo "ff02::1 ip6-allnodes" >> /etc/hosts
echo "ff02::2 ip6-allrouters" >> /etc/hosts

echo ""
echo "Fichier hosts configuré"
echo ""

rm /etc/hostname

touch /etc/hostname

echo "$hostname" >> /etc/hostname

echo ""
echo "Fichier hostname configuré"
echo ""

rm -f /etc/samba/smb.conf


samba-tool domain provision --realm=$domlan --domain $dom --server-role=dc

echo ""
echo "Entrer le mot de passe administrator"
echo ""

samba-tool user setpassword administrator

echo ""
echo "Quel est l'ip du DNS Forwarder"
read dnsfor

echo ""
echo "Fichier smb.conf configuré"
echo ""

rm /etc/resolv.conf

touch /etc/resolv.conf

echo "search $domlan" >> /etc/resolv.conf
echo "nameserver 127.0.0.1" >> /etc/resolv.conf
echo "nameserver $dnsfor" >> /etc/resolv.conf

echo ""
echo "Fichier resolv.conf configuré"
echo ""

systemctl unmask samba-ad-dc

systemctl enable samba-ad-dc

systemctl disable samba winbind nmbd smbd

systemctl mask samba winbind nmbd smbd

echo ""
echo "-------------------------------------"
echo ""
echo "Installation de samba terminée..."
echo "Merci de m'avoir utilisé !"
echo "A bientôt"
echo ""
echo ""
echo "Appuyez sur entrer pour redemarrer le système"

read tmpb

reboot

#adio