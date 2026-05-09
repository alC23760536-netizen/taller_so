#!/bin/bash
# Monitor de uso de RAM con alertas

RAM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
RAM_USADA=$(free -m | awk '/Mem:/ {print $3}')
RAM_LIBRE=$(free -m | awk '/Mem:/ {print $4}')
PORCENTAJE=$((RAM_USADA * 100 / RAM_TOTAL))

echo "═══ Monitor de Memoria RAM ═══"
echo "Total : ${RAM_TOTAL} MB"
echo "Usada : ${RAM_USADA} MB (${PORCENTAJE}%)"
echo "Libre : ${RAM_LIBRE} MB"
echo ""

if [ $PORCENTAJE -gt 80 ]; then
    echo "⚠️  ALERTA: Uso crítico de memoria (${PORCENTAJE}%)"
elif [ $PORCENTAJE -gt 60 ]; then
    echo "⚡ ADVERTENCIA: Memoria elevada (${PORCENTAJE}%)"
else
    echo "✅ Memoria en niveles normales (${PORCENTAJE}%)"
fi
