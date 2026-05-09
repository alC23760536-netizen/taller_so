#!/bin/bash
# ─────────────────────────────────────────────────
#  Práctica 6 · Taller de Sistemas Operativos
#  Script: Información del sistema
# ─────────────────────────────────────────────────

NOMBRE="Diego Paulo Estrada Jaime"
FECHA=$(date +"%d/%m/%Y %H:%M")
USUARIO=$(whoami)
HOST=$(hostname)
KERNEL=$(uname -r)
CPU=$(nproc)
RAM=$(free -m | awk '/Mem:/ {print $2}')
RAM_LIBRE=$(free -m | awk '/Mem:/ {print $4}')
DISCO=$(df -h / | awk 'NR==2 {print $4}')

echo "╔══════════════════════════════════════╗"
echo "  REPORTE DE SISTEMA - RASPBERRY PI"
echo "╚══════════════════════════════════════╝"
echo ""
echo "Estudiante : $NOMBRE"
echo "Fecha      : $FECHA"
echo "Usuario    : $USUARIO@$HOST"
echo ""
echo "─── Hardware ────────────────────"
echo "Kernel     : $KERNEL"
echo "Núcleos CPU: $CPU"
echo "RAM total  : ${RAM} MB"
echo "RAM libre  : ${RAM_LIBRE} MB"
echo "Disco libre: $DISCO"
echo ""
echo "─── Procesos activos ────────────"
NUM_PROC=$(ps aux | wc -l)
echo "Procesos en ejecución: $NUM_PROC"
echo ""
echo "Reporte generado exitosamente."

