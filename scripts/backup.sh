#!/bin/bash
# backup.sh - Backup incremental con estrategia 3-2-1
# Copia 1: local | Copia 2: USB externo | Copia 3: red NAS
ORIGEN="${ORIGEN:-$HOME/proyecto/datos}"
BASE="$HOME/proyecto/respaldos"
LOCAL="$BASE/local"
FECHA=$(date +%Y%m%d_%H%M%S)

# Si el USB o la NAS no estan montados se usa una carpeta de laboratorio
if mountpoint -q /mnt/usb 2>/dev/null; then USB="/mnt/usb/backup"; USB_REAL=1
else USB="$BASE/usb_laboratorio"; USB_REAL=0; fi
if mountpoint -q /mnt/nas 2>/dev/null; then NAS="/mnt/nas/backup"; NAS_REAL=1
else NAS="$BASE/nas_laboratorio"; NAS_REAL=0; fi

mkdir -p "$LOCAL" "$USB" "$NAS" "$ORIGEN"
SNAR="$LOCAL/snapshot.snar"

if [ ! -f "$SNAR" ]; then TIPO="full"; else TIPO="incr"; fi
ARCHIVO="$LOCAL/backup_${FECHA}_${TIPO}.tar.gz"

echo "[*] Origen: $ORIGEN"
echo "[*] Tipo de backup: $TIPO"
tar --listed-incremental="$SNAR" -czf "$ARCHIVO" -C "$(dirname "$ORIGEN")" "$(basename "$ORIGEN")" || { echo "[ERROR] Fallo el backup"; exit 1; }
( cd "$LOCAL" && sha256sum "$(basename "$ARCHIVO")" > "$ARCHIVO.sha256" )
echo "[OK] 1. Copia local: $ARCHIVO"

cp "$ARCHIVO" "$ARCHIVO.sha256" "$USB/" && echo "[OK] 2. Copia USB: $USB $([ $USB_REAL = 0 ] && echo '(carpeta de laboratorio, /mnt/usb no esta montado)')"
cp "$ARCHIVO" "$ARCHIVO.sha256" "$NAS/" && echo "[OK] 3. Copia NAS: $NAS $([ $NAS_REAL = 0 ] && echo '(carpeta de laboratorio, /mnt/nas no esta montado)')"

echo "$(date '+%F %T') | $TIPO | $(basename "$ARCHIVO") | $(du -h "$ARCHIVO" | cut -f1)" >> "$BASE/catalogo.log"
echo "[OK] Backup 3-2-1 terminado"
