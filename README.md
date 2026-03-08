# linux-postops: Post-explotación educativa en máquinas Linux

Este repositorio simula técnicas de post-explotación para laboratorios controlados (e.g., cursos de ciberseguridad ética). Incluye:
- Creación de usuario persistente con SSH.
- Generación y exfiltración de "loot" simulado.
- Mecanismos adicionales de persistencia (cron job camuflado, servicio systemd ofuscado).
- Cleanup para restaurar el sistema.

**Uso en lab**: Clona el repo en la máquina víctima, ejecuta `./install_postops.sh [opciones]`. Solo para entornos simulados.

Opciones para install_postops.sh:
- --user <nombre>: Nombre de usuario (default: sysbackup).
- --ip <IP>: IP del atacante (default: 192.168.1.50).
- --port <puerto>: Puerto para exfil/reverse (default: 4444).
- --ssh-key <clave pública>: Clave SSH del atacante (requerida para SSH).

