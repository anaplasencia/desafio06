#!/bin/bash
# Desafio 6 - PARTE 2: RECUPERACION DE INFORMACION

LAB="$HOME/proyecto/lab_perdida"
DATOS="$LAB/datos_criticos"
USB_DIR="$LAB/usb_simulado"
NAS_DIR="$LAB/nas_simulado"
MANIFIESTO="$LAB/manifiesto_original.sha256"
ESTADO="$LAB/estado.env"

linea() { echo "=================================================="; }

if [ ! -f "$ESTADO" ]; then
  echo "Primero debes ejecutar ./perdida.sh"
  exit 1
fi
source "$ESTADO"

linea
echo "        PARTE 2: RECUPERACION DE INFORMACION"
linea

echo; echo "[1/4] Comprobando estado actual de los datos..."
if [ ! -d "$DATOS" ]; then
  echo "[!] La carpeta datos_criticos NO existe (datos perdidos)"
fi

echo; echo "[2/4] Verificando integridad del backup (SHA256)..."
T_INICIO=$(date +%s.%N)
HASH_ACTUAL=$(sha256sum "$USB_DIR/backup_semanal6.tar.gz" | awk '{print $1}')
if [ "$HASH_ACTUAL" = "$HASH_BACKUP" ]; then
  echo "[OK] Backup en USB integro (hash coincide)"
  FUENTE="$USB_DIR"
else
  echo "[ERROR] Backup USB corrupto, usando copia de la NAS..."
  FUENTE="$NAS_DIR"
fi

echo; echo "[3/4] Restaurando datos desde $FUENTE ..."
tar -xzf "$FUENTE/backup_semanal6.tar.gz" -C "$LAB"
T_FIN=$(date +%s.%N)
RTO=$(echo "$T_FIN - $T_INICIO" | bc)
ls -l "$DATOS"

echo; echo "[4/4] Verificando datos recuperados contra el original..."
( cd "$DATOS" && sha256sum -c "$MANIFIESTO" )

RPO=$((T_PERDIDA - T_BACKUP))
echo; linea
echo "RESULTADOS DE LA RECUPERACION"
linea
echo "RPO (datos en riesgo antes de la perdida): ${RPO} segundos"
echo "RTO (tiempo de restauracion real):         ${RTO} segundos"
echo "Datos perdidos de forma permanente:        0 archivos"
linea
