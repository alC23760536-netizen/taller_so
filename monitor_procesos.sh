#!/bin/bash
# Monitor de procesos — simula el Monitor Serial de Arduino
# Ctrl+C para detener

CICLOS=5    # cuántas veces muestras el estado
ESPERA=3    # segundos entre cada muestra

echo "Iniciando monitor... (Ctrl+C para detener)"
echo "────────────────────────────────────────────"

for i in $(seq 1 $CICLOS); do
    TIMESTAMP=$(date +"%H:%M:%S")
    NUM_PROC=$(ps aux | wc -l)
    CARGA=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | tr -d ',')
    RAM_PCT=$(free | awk '/Mem:/ {printf "%.0f", $3/$2*100}')

    echo "[$TIMESTAMP] Ciclo $i/$CICLOS | Procesos: $NUM_PROC | CPU carga: $CARGA | RAM: ${RAM_PCT}%"

    if [ $i -lt $CICLOS ]; then
        sleep $ESPERA
    fi
done

echo "────────────────────────────────────────────"
echo "Monitor finalizado."
