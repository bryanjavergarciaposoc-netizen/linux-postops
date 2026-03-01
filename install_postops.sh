#!/bin/bash

echo "[+] Iniciando Post-Exploitation Ops"

chmod +x *.sh

./create_persist_user.sh
./generate_loot.sh

echo "[+] Post explotación completada"
