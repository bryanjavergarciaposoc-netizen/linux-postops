#!/bin/bash

sudo userdel -r sysbackup
sudo rm -f /tmp/loot.csv
sudo rm -f /tmp/.persist_pass

echo "[+] Sistema restaurado"
