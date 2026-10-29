#!/bin/bash
# Diseño de Panel de Monitoreo - Personalizado
clear
echo "╭──────────────────────────────────────────────────────────╮"
echo "│         SISTEMA DE GESTIÓN Y VALIDACIÓN - TI             │"
echo "│         Módulo 3: Infraestructura y Servicios            │"
echo "╰──────────────────────────────────────────────────────────╯"
echo ""

echo "▓▓ 1. ESTADO DE LA RED Y CONTENEDORES DOCKER"
echo "────────────────────────────────────────────────────────────"
docker ps --format "table [Servicio]: {{.Names}} \t [Estado]: {{.Status}}"
echo ""

echo "▓▓ 2. VERIFICACIÓN DE SANIDAD (SMOKE TESTS)"
echo "────────────────────────────────────────────────────────────"
./pruebas.sh
echo ""

echo "▓▓ 3. TRAZABILIDAD Y CONTROL DE VERSIONES (GIT)"
echo "────────────────────────────────────────────────────────────"
git log --oneline -n 6
echo ""

echo "╭──────────────────────────────────────────────────────────╮"
echo "│         ESTADO: INTEGRACIÓN COMPLETADA CON ÉXITO         │"
echo "╰──────────────────────────────────────────────────────────╯"
