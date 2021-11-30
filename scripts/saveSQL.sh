#!/bin/bash
# saveSQL.sh

echo "Quel user SQL ?"
read usersql
echo "Quel password SQL ?"
read pswdsql


echo Début de la procedure >>/tmp/save/sauvegardelog.log
date >> /tmp/save/sauvegardelog.log
mysqldump --user=$usersql --password=$pswdsql --all-databases > /tmp/save/sauvegarde.sql
echo fin exportation sql >>/tmp/save/sauvegardelog.log
date >> /tmp/save/sauvegardelog.log
tar -czvf sauvegarde1sql.tar.gz /tmp/save/sauvegarde.sql
echo fin compression  >>/tmp/save/sauvegardelog.log
date >> /tmp/save/sauvegardelog.log
mv sauvegarde1sql.tar.gz /tmp/save/`date +%Y-%m-%d-%H-%M`.-sauvegarde.tar.gz
echo fin sauvegarde >>/tmp/save/sauvegardelog.log
date >> /tmp/save/sauvegardelog.log

echo -n "Voulez vous envoyez par ftp (y/n)?"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    echo "Quel IP FTP ?"
    read ipftp
    echo "Quel user ftp ?"
    read userftp
    echo "Quel password ftp ?"
    read pswdftp
    
    lftp ftp://$userftp:'$pswdftp'@$ipftp -e "mirror -e -R /tmp/save /  ; quit"
else
    echo "Pas d'envoye en ftp, retrouvez la sauvegarde dans /tmp/save"
fi

