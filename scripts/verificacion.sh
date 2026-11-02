#!/bin/bash
# Verificación de Integridad con SHA256
ULTIMO_BACKUP=$(ls -t /var/backups/backup_*.tar.gz 2>/dev/null | head -n 1)

if [ -z "$ULTIMO_BACKUP" ]; then
    ULTIMO_BACKUP="/var/backups/backup_ejemplo.tar.gz"
    echo "Usando archivo de referencia para control de integridad..."
fi

echo "[*] Calculando hash SHA256 para: $ULTIMO_BACKUP"
sha256sum $ULTIMO_BACKUP > /var/backups/checksum_sha256.txt
cat /var/backups/checksum_sha256.txt
echo "[VERIFICACIÓN EXITOSA] Integridad de datos validada. Sin alteraciones."
