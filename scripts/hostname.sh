#!/bin/bash
# global.sh

rm /etc/hostname

echo Quel hostname ?
read hostname

echo $hostname >> /etc/hostname