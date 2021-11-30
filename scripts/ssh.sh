#!/bin/bash
# ssh.sh

echo -n "Voulez vous installation un serveur ssh (y/n)?"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    echo "Installation de ssh"
    apt-get install openssh-server -y
    echo "Installation de openssh-server terminée"
else
    echo "Installation de ssh annulée"
fi

echo -n "Voulez vous permettre à l'utilisateur root d'accéder au ssh (y/n)?"
read ouinon
if [ "$ouinon" = "y" ] || [ "$ouinon" = "Y" ]; then
    rm /etc/ssh/sshd_config
    echo "Include /etc/ssh/sshd_config.d/*.conf" >> /etc/ssh/sshd_config
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config
    echo "UsePAM yes" >> /etc/ssh/sshd_config
    echo "X11Forwarding yes" >> /etc/ssh/sshd_config
    echo "PrintMotd no" >> /etc/ssh/sshd_config
    echo "AcceptEnv LANG LC_*" >> /etc/ssh/sshd_config
    echo "Subsystem sftp /usr/lib/openssh/sftp-server" >> /etc/ssh/sshd_config
    echo "" >> /etc/ssh/sshd_config
    
    echo "Configuration terminée"
else
    echo "L'utilisateur root ne pourra pas se connecter en ssh"
fi