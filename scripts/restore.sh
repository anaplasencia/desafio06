#!/bin/bash
# restore.sh - Restaura los backups (completo + incrementales) y mide RTO/RPO
ORIGEN="${ORIGEN:-$HOME/proyecto/datos}"
BASE="$HOME/proyecto/respaldos"
DESTINO="$HOME/proyecto/restaurado"

ULTIMO=$(ls -t "$BASE"/local/backup_*.tar.gz 2>/dev/null | head -n 1)
[ -z "$ULTIMO" ] && { echo "No hay backups para restaurar"; exit 1; }
RPO=$(( $(date +%s) - $(stat -c %Y "$ULTIMO") ))

echo "[*] Verificando integridad antes de restaurar..."
"$HOME/proyecto/scripts/verificacion.sh" >/dev/null || { echo "[ERROR] Backups danados, no se restaura"; exit 1; }

rm -rf "$DESTINO"; mkdir -p "$DESTINO"
INICIO=$(date +%s.%N)
for B in $(ls "$BASE"/local/backup_*.tar.gz | sort); do
  echo "[*] Restaurando $(basename "$B")"
  tar --listed-incremental=/dev/null -xzf "$B" -C "$DESTINO"
done
FIN=$(date +%s.%N)
RTO=$(echo "$FIN - $INICIO" | bc)

echo "[*] Comparando con el original..."
if diff -r "$ORIGEN" "$DESTINO/$(basename "$ORIGEN")" >/dev/null 2>&1; then
  echo "[OK] Datos restaurados identicos al original"
else
  echo "[AVISO] Hay diferencias con el original (cambios posteriores al ultimo backup)"
fi
echo "RTO medido: ${RTO} segundos"
echo "RPO (edad del ultimo backup): ${RPO} segundos"
