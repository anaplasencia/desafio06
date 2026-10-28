#!/bin/bash
URL=http://localhost:8080
code=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
if [ "$code" = "200" ]; then
    echo "OK  web responde ($code)"
else
    echo "FALLA web responde ($code)"; exit 1
fi
