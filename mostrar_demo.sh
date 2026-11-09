#!/bin/bash
# mostrar_demo.sh - Demostracion completa del Desafio 6 (con pausas)
cd "$HOME/proyecto" || exit 1

paso()  { clear; echo "=================================================="; echo "  $1"; echo "=================================================="; echo; }
cmd()   { echo "\$ $1"; eval "$1"; echo; }
pausa() { echo; read -r -p ">>> ENTER para continuar... " _; }

# Preparacion: estado limpio
rm -rf respaldos restaurado datos

paso "DESAFIO 6: ESTRATEGIA DE BACKUP 3-2-1"
echo "  Local + USB externo + Red NAS"
echo "  Backup incremental | SHA256 | Catalogo | Restauracion | RTO/RPO"
echo; cmd "ls scripts"
pausa

paso "PASO 1: Datos criticos"
cmd "mkdir -p datos"
cmd "echo 'Cliente: Juan Perez - Saldo: 1500' > datos/clientes.txt"
cmd "echo 'Factura 001 - Total: 350.00' > datos/facturas.txt"
cmd "ls datos"
pausa

paso "PASO 2: Backup COMPLETO (3-2-1)"
cmd "./scripts/backup.sh"
pausa

paso "PASO 3: Backup INCREMENTAL (solo lo que cambio)"
cmd "echo 'Factura 002 - Total: 120.00' > datos/facturas2.txt"
cmd "./scripts/backup.sh"
pausa

paso "PASO 4: Verificacion de integridad SHA256"
cmd "./scripts/verificacion.sh"
pausa

paso "PASO 5: PERDIDA DE INFORMACION"
cmd "rm -rf datos"
cmd "ls datos"
echo "  >>> DATOS PERDIDOS <<<"
pausa

paso "PASO 6: RECUPERACION DE INFORMACION (RTO / RPO)"
cmd "./scripts/restore.sh"
cmd "ls restaurado/datos"
pausa

paso "PASO 7: Monitoreo de integridad - backup DANADO"
cmd "echo x >> \$(ls respaldos/local/*_full.tar.gz)"
cmd "./scripts/verificacion.sh"
pausa

paso "PASO 8: Recuperar la copia sana desde el USB (regla 3-2-1)"
cmd "cp respaldos/usb_laboratorio/*_full.tar.gz respaldos/local/"
cmd "./scripts/verificacion.sh"
pausa

paso "PASO 9: Catalogo de backups"
cmd "./scripts/catalogar.sh \$HOME/proyecto/respaldos/local"
pausa

paso "PASO 10: Trazabilidad en Git"
cmd "git log --oneline -5"
echo "=================================================="
echo "   DEMOSTRACION COMPLETADA"
echo "=================================================="
