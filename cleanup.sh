#!/bin/bash

USER=${1:-sysbackup}
SERVICE_NAME="backup.service"
BACKDOOR_SCRIPT="/usr/local/bin/backup_check.sh"

echo "[+] Iniciando cleanup" | tee -a /var/log/postops.log

# Borra usuario
sudo userdel -r "$USER" 2>/dev/null

# Borra cron
crontab -l | grep -v "sysupdate check" | crontab - 2>/dev/null

# Borra systemd
sudo systemctl stop "$SERVICE_NAME" 2>/dev/null
sudo systemctl disable "$SERVICE_NAME" 2>/dev/null
sudo rm -f /etc/systemd/system/"$SERVICE_NAME"
sudo rm -f "$BACKDOOR_SCRIPT"
sudo systemctl daemon-reload

# Borra archivos
sudo rm -f /tmp/loot.csv /tmp/.persist_pass /var/log/postops.log

echo "[+] Sistema restaurado" | tee -a /var/log/postops.log
