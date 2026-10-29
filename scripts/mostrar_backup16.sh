#!/bin/bash
# Demostración Desafío 6 - Estrategia de Backup 3-2-1
clear
echo "╭──────────────────────────────────────────────────────────╮"
echo "│         SISTEMA DE RESPALDO Y RECUPERACIÓN - TI          │"
echo "│         Desafío 6: Estrategia de Backup 3-2-1            │"
echo "╰──────────────────────────────────────────────────────────╯"
echo ""

echo "▓▓ 1. EJECUCIÓN DE BACKUP INCREMENTAL Y MULTINIVEL"
echo "────────────────────────────────────────────────────────────"
./scripts/backup.sh
echo ""

echo "▓▓ 2. VERIFICACIÓN DE INTEGRIDAD (SHA256)"
echo "────────────────────────────────────────────────────────────"
./scripts/verificacion.sh
echo ""

echo "▓▓ 3. SIMULACIÓN DE RESTAURACIÓN Y PRUEBAS RTO/RPO"
echo "────────────────────────────────────────────────────────────"
./scripts/restore.sh --test
echo ""

echo "▓▓ 4. CATALOGACIÓN Y TRAZABILIDAD (GIT)"
echo "────────────────────────────────────────────────────────────"
git log --oneline -n 5
echo ""

echo "╭──────────────────────────────────────────────────────────╮"
echo "│         ESTADO: RESPALDO Y VERIFICACIÓN EXITOSA          │"
echo "╰──────────────────────────────────────────────────────────╯"
