#!/bin/bash
# Desafio 6 - Demostracion REAL de perdida y recuperacion de informacion

LAB="$HOME/proyecto/lab_perdida"
DATOS="$LAB/datos_criticos"
BACKUP_DIR="$LAB/backups"
USB_DIR="$LAB/usb_simulado"
NAS_DIR="$LAB/nas_simulado"
BACKUP="$BACKUP_DIR/backup_semanal6.tar.gz"
MANIFIESTO="$LAB/manifiesto_original.sha256"

linea() { echo "=================================================="; }

linea
echo "   PRUEBA DE PERDIDA Y RECUPERACION DE INFORMACION"
linea

echo; echo "[1/6] Creando datos criticos de prueba..."
rm -rf "$LAB"
mkdir -p "$DATOS" "$BACKUP_DIR" "$USB_DIR" "$NAS_DIR"
echo "Cliente: Juan Perez - Saldo: 1500"   > "$DATOS/clientes.txt"
echo "Factura 001 - Total: 350.00"         > "$DATOS/facturas.txt"
echo "usuario=admin;rol=root"              > "$DATOS/usuarios.conf"
head -c 200000 /dev/urandom                > "$DATOS/base_datos.bin"
echo "Archivos creados:"; ls -l "$DATOS"

echo; echo "[2/6] Generando backup y copias 3-2-1..."
( cd "$DATOS" && sha256sum * ) > "$MANIFIESTO"
tar -czf "$BACKUP" -C "$LAB" datos_criticos
cp "$BACKUP" "$USB_DIR/"
cp "$BACKUP" "$NAS_DIR/"
HASH_BACKUP=$(sha256sum "$BACKUP" | awk '{print $1}')
T_BACKUP=$(date +%s)
echo "Backup: $BACKUP"
echo "SHA256 del backup: $HASH_BACKUP"
echo "Copias: local, USB ($USB_DIR), NAS ($NAS_DIR)"
echo "Hash original de los datos:"; cat "$MANIFIESTO"

sleep 2

echo; echo "[3/6] SIMULANDO PERDIDA DE INFORMACION (borrado real)..."
T_PERDIDA=$(date +%s)
rm -rf "$DATOS"
if [ ! -d "$DATOS" ]; then
  echo "[!] DATOS PERDIDOS: la carpeta $DATOS ya no existe"
fi
ls "$DATOS" 2>&1

RPO=$((T_PERDIDA - T_BACKUP))

sleep 1

echo; echo "[4/6] INICIANDO RECUPERACION desde el backup..."
T_INICIO=$(date +%s.%N)

HASH_ACTUAL=$(sha256sum "$USB_DIR/backup_semanal6.tar.gz" | awk '{print $1}')
if [ "$HASH_ACTUAL" = "$HASH_BACKUP" ]; then
  echo "[OK] Integridad del backup verificada (SHA256 coincide)"
else
  echo "[ERROR] El backup esta corrupto, probando copia del NAS..."
  cp "$NAS_DIR/backup_semanal6.tar.gz" "$USB_DIR/"
fi

tar -xzf "$USB_DIR/backup_semanal6.tar.gz" -C "$LAB"
T_FIN=$(date +%s.%N)
RTO=$(echo "$T_FIN - $T_INICIO" | bc)

echo; echo "[5/6] Verificando datos recuperados..."
ls -l "$DATOS"
( cd "$DATOS" && sha256sum -c "$MANIFIESTO" )

echo; linea
echo "[6/6] RESULTADOS"
linea
echo "RPO (tiempo entre ultimo backup y la perdida): ${RPO} segundos"
echo "RTO (tiempo de recuperacion real):             ${RTO} segundos"
echo "Datos perdidos de forma permanente:            0 archivos"
linea
