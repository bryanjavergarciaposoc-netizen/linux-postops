#!/bin/bash

USER=${1:-sysbackup}

HOST=$(hostname)
DATE=$(date)
PASS=$(cat /tmp/.persist_pass 2>/dev/null || echo "N/A")

echo "[+] Generando loot simulado" | tee -a /var/log/postops.log

echo "fecha,hostname,usuario,password,accion" > /tmp/loot.csv
echo "$DATE,$HOST,$USER,$PASS,Usuario persistente creado" >> /tmp/loot.csv
echo "$DATE,$HOST,N/A,N/A,Cron y systemd añadidos" >> /tmp/loot.csv  # Añade más entries.

echo "[+] loot.csv generado:" | tee -a /var/log/postops.log
cat /tmp/loot.csv | tee -a /var/log/postops.log
