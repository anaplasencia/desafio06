#!/bin/bash
# Desafio 6 - PARTE 1: PERDIDA DE INFORMACION

LAB="$HOME/proyecto/lab_perdida"
DATOS="$LAB/datos_criticos"
BACKUP_DIR="$LAB/backups"
USB_DIR="$LAB/usb_simulado"
NAS_DIR="$LAB/nas_simulado"
BACKUP="$BACKUP_DIR/backup_semanal6.tar.gz"
MANIFIESTO="$LAB/manifiesto_original.sha256"
ESTADO="$LAB/estado.env"

linea() { echo "=================================================="; }

linea
echo "        PARTE 1: PERDIDA DE INFORMACION"
linea

echo; echo "[1/3] Creando datos criticos..."
rm -rf "$LAB"
mkdir -p "$DATOS" "$BACKUP_DIR" "$USB_DIR" "$NAS_DIR"
echo "Cliente: Juan Perez - Saldo: 1500"   > "$DATOS/clientes.txt"
echo "Factura 001 - Total: 350.00"         > "$DATOS/facturas.txt"
echo "usuario=admin;rol=root"              > "$DATOS/usuarios.conf"
head -c 200000 /dev/urandom                > "$DATOS/base_datos.bin"
ls -l "$DATOS"

echo; echo "[2/3] Generando backup 3-2-1..."
( cd "$DATOS" && sha256sum * ) > "$MANIFIESTO"
tar -czf "$BACKUP" -C "$LAB" datos_criticos
cp "$BACKUP" "$USB_DIR/"
cp "$BACKUP" "$NAS_DIR/"
HASH_BACKUP=$(sha256sum "$BACKUP" | awk '{print $1}')
T_BACKUP=$(date +%s)
echo "Backup creado: $BACKUP"
echo "SHA256 del backup: $HASH_BACKUP"
echo "Hash original de los datos:"; cat "$MANIFIESTO"

sleep 2

echo; echo "[3/3] SIMULANDO PERDIDA DE INFORMACION (borrado real)..."
T_PERDIDA=$(date +%s)
rm -rf "$DATOS"

# guardar estado para la parte 2
cat > "$ESTADO" << EOS
HASH_BACKUP=$HASH_BACKUP
T_BACKUP=$T_BACKUP
T_PERDIDA=$T_PERDIDA
EOS

echo "Verificando si los datos existen:"
ls "$DATOS" 2>&1
echo
echo "[!] DATOS PERDIDOS: la carpeta datos_criticos ya no existe"
linea
echo "Ahora ejecuta: ./recuperacion.sh"
linea
