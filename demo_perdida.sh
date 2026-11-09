#!/bin/bash
# demo_perdida.sh - Perdida y recuperacion de informacion (un solo comando)
cd "$HOME/proyecto" || exit 1
pausa() { echo; read -r -p ">>> ENTER para continuar... " _; echo; }
cmd()   { echo "\$ $1"; eval "$1"; echo; }

rm -rf respaldos restaurado datos
clear
echo "=================================================="
echo "  PARTE 1: DATOS Y BACKUP"
echo "=================================================="
cmd "mkdir -p datos"
cmd "echo 'Cliente: Juan Perez - Saldo: 1500' > datos/clientes.txt"
cmd "echo 'Factura 001 - Total: 350.00' > datos/facturas.txt"
cmd "ls datos"
cmd "./scripts/backup.sh"
pausa

echo "=================================================="
echo "  PARTE 2: PERDIDA DE INFORMACION"
echo "=================================================="
cmd "rm -rf datos"
cmd "ls datos"
echo "  >>> DATOS PERDIDOS <<<"
pausa

echo "=================================================="
echo "  PARTE 3: RECUPERACION DE INFORMACION"
echo "=================================================="
cmd "./scripts/restore.sh"
cmd "ls restaurado/datos"
cmd "cat restaurado/datos/clientes.txt"
echo "=================================================="
echo "  DATOS RECUPERADOS CORRECTAMENTE"
echo "=================================================="
