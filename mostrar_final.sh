#!/bin/bash
echo "=================================================="
echo "   DEMOSTRACIÓN PROYECTO INTEGRADOR - SEMANA 15   "
echo "=================================================="
echo ""

echo "[1] Estado actual de los contenedores Docker:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo ""

echo "[2] Ejecutando pruebas automatizadas:"
./pruebas.sh
echo ""

echo "[3] Historial de Git (Commits realizados):"
git log --oneline -n 5
echo ""

echo "=================================================="
echo "       ¡Demostración de la Semana 15 Finalizada!  "
echo "=================================================="
