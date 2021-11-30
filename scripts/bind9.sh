#!/bin/bash
# bind9.sh

echo "Création DNS 1 zone pour 1 serveur web"
echo "Une IP fixe et requise"
sleep 10

## Supprimer les fichier à réécrire

rm /etc/resolv.conf
rm /etc/hostname
rm /etc/network/interfaces

## Demande info nom de la machine

echo "Quel nom de machine ? exemple : serveurDNS"
read hostname

echo $hostname >> /etc/hostname

## Demande info nom de domaine du dns

echo "Quel domaine ? exemple : domaine.fr"
read domain

## Création du fichier configuration Resolv.conf

echo domain $domain >> /etc/resolv.conf
echo search $domain >> /etc/resolv.conf
echo nameserver $ip >> /etc/resolv.conf
echo nameserver $gateway >> /etc/resolv.conf

## Installation bind 9

apt install bind9

## Supprimer named.conf.local


rm /etc/bind/named.conf.local

## Demande info ip du serveur WEB

echo "Quelle ip du serveur web ?"
read iplamp

## Création du fichier configuration des zones

echo "zone "\"$domain\"" { " >> /etc/bind/named.conf.local
echo	"type master; " >> /etc/bind/named.conf.local
echo	"file "\"$domain\""; }; " >> /etc/bind/named.conf.local


## Création du fichier configuration des zones

echo "@  IN  SOA  $hostname.$domain. root.$domain. ( ">> /var/cache/bind/$domain
echo "                1   ; Serial ">> /var/cache/bind/$domain
echo "           604800   ; Refresh ">> /var/cache/bind/$domain
echo "            86400   ; Retry ">> /var/cache/bind/$domain
echo "         2419200   ; Expire ">> /var/cache/bind/$domain
echo  "          604800 ) ; Negative Cache TTL ">> /var/cache/bind/$domain

echo @  IN  NS  $hostname.$domain. >> /var/cache/bind/$domain

echo $hostname  IN  NS  $ip >> /var/cache/bind/$domain
echo www  IN  NS  $iplamp >> /var/cache/bind/$domain

## Restart des services

systemctl restart networking.service
systemctl restart bind9

