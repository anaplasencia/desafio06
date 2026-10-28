#!/bin/bash
cd ~/proyecto || exit 1
titulo() { clear; echo "=============================="; echo "  $1"; echo "=============================="; echo; }
pausa() { echo; read -r -p "[Enter para continuar] "; }

titulo "1. ESTRUCTURA DE CARPETAS"
find . -not -path './.git*' | sort
pausa

titulo "2. REQUERIMIENTOS"
cat requerimientos.md
pausa

titulo "3. PLAN POR ETAPAS"
cat plan.md
pausa

titulo "4. MATRIZ DE RIESGOS"
cat riesgos.txt
pausa

titulo "5. DIAGRAMA DE ARQUITECTURA"
ls -l docs
echo
cat docs/arquitectura.md
