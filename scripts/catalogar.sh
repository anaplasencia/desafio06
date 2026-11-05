#!/bin/bash
# Genera el catalogo de backups con datos reales
# Uso: ./scripts/catalogar.sh [carpeta_de_backups]
DIR="${1:-$HOME/proyecto/demo/backups}"
SALIDA="$HOME/proyecto/documentos/catalogo_backups.md"

{
echo "# Catalogo de Backups - Desafio 6"
echo
echo "Generado: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Carpeta: $DIR"
echo
echo "| Archivo | Fecha | Tamano | SHA256 |"
echo "|---|---|---|---|"
for f in "$DIR"/*.tar.gz; do
  [ -e "$f" ] || continue
  echo "| $(basename "$f") | $(date -r "$f" '+%Y-%m-%d %H:%M') | $(du -h "$f" | cut -f1) | $(sha256sum "$f" | awk '{print $1}') |"
done
} > "$SALIDA"

cat "$SALIDA"
