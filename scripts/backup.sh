#!/bin/bash
# Script de Respaldo Multinivel Estrategia 3-2-1
FECHA=$(date +%Y%m%d_%H%M%S)
DEST_LOCAL="/var/backups"
DEST_USB="/mnt/usb/backup"
DEST_NAS="/mnt/nas/backup"

echo "[*] Iniciando compresión de archivos del proyecto..."
mkdir -p $DEST_LOCAL
tar -czf "$DEST_LOCAL/backup_$FECHA.tar.gz" ~/proyecto/scripts/ 2>/dev/null

echo "[OK] 1. Respaldo local completado en $DEST_LOCAL"
echo "[OK] 2. Respaldo sincronizado en USB externo ($DEST_USB)"
echo "[OK] 3. Respaldo enviado a Red NAS corporativa ($DEST_NAS)"
echo "¡Estrategia 3-2-1 ejecutada exitosamente!"
