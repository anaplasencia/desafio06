#!/bin/bash
# verificacion.sh - Verifica la integridad (SHA256) de los backups en las 3 copias
BASE="$HOME/proyecto/respaldos"
MALOS=0; TOTAL=0
for DIR in "$BASE/local" "$BASE/usb_laboratorio" "$BASE/nas_laboratorio" /mnt/usb/backup /mnt/nas/backup; do
  [ -d "$DIR" ] || continue
  for SUM in "$DIR"/*.sha256; do
    [ -e "$SUM" ] || continue
    TOTAL=$((TOTAL+1))
    if ( cd "$DIR" && sha256sum -c "$(basename "$SUM")" >/dev/null 2>&1 ); then
      echo "[OK]    $DIR/$(basename "$SUM" .sha256)"
    else
      echo "[ALERTA] INTEGRIDAD ALTERADA: $DIR/$(basename "$SUM" .sha256)"
      MALOS=$((MALOS+1))
    fi
  done
done
echo "Verificados: $TOTAL | Con problemas: $MALOS"
[ "$TOTAL" -eq 0 ] && { echo "No hay backups para verificar"; exit 2; }
[ "$MALOS" -eq 0 ] && echo "[VERIFICACION EXITOSA]" || { echo "[VERIFICACION FALLIDA]"; exit 1; }
