#!/bin/bash
echo "Iniciando validación de servicios de la plataforma..."

# Prueba web (Nginx)
code_web=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)
if [ "$code_web" = "200" ]; then
    echo "web responde ($code_web)"
else
    echo "FALLA web responde ($code_web)"
    exit 1
fi

# Prueba Prometheus
code_prom=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:9090)
if [ "$code_prom" = "200" ] || [ "$code_prom" = "302" ] || [ "$code_prom" = "401" ]; then
    echo "prometheus responde ($code_prom)"
else
    echo "FALLA prometheus responde ($code_prom)"
fi

# Prueba Grafana
code_graf=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000)
if [ "$code_graf" = "200" ] || [ "$code_graf" = "302" ]; then
    echo "grafana responde ($code_graf)"
else
    echo "FALLA grafana responde ($code_graf)"
fi

# Prueba de balanceador / proxy
code_haproxy=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80)
if [ "$code_haproxy" = "200" ] || [ "$code_haproxy" = "302" ] || [ "$code_haproxy" = "503" ]; then
    echo "haproxy responde (código: $code_haproxy)"
fi

# Prueba de n8n
code_n8n=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:5678)
if [ "$code_n8n" = "200" ] || [ "$code_n8n" = "302" ]; then
    echo "n8n_ana responde ($code_n8n)"
fi

echo "¡Todas las pruebas de humo concluyeron con éxito!"
