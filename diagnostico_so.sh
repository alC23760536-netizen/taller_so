#!/bin/bash
# ════════════════════════════════════════════════════
#  DIAGNÓSTICO DEL SISTEMA OPERATIVO
#  Taller de Sistemas Operativos · P6
#  Instituto Tecnológico de Ensenada
# ════════════════════════════════════════════════════
#
#  INSTRUCCIONES: Edita las variables de la sección
#  "DATOS DEL ESTUDIANTE" con tu información.
# ════════════════════════════════════════════════════

# ── DATOS DEL ESTUDIANTE (EDITAR) ──────────────────
ESTUDIANTE="Diego Paulo Estrada"
NUMERO_CONTROL="C23760536"
GRUPO="SO2-5SS"

# ── RECOLECCIÓN DE DATOS ────────────────────────────
FECHA=$(date +"%d/%m/%Y a las %H:%M:%S")
USUARIO=$(whoami)
HOST=$(hostname)
KERNEL=$(uname -r)
ARCH=$(uname -m)
SO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')
UPTIME=$(uptime -p 2>/dev/null || uptime | awk '{print $3,$4}' | tr -d ',')
CPU_MODEL=$(cat /proc/cpuinfo | grep "model name" | head -1 | cut -d: -f2 | xargs)
CPU_CORES=$(nproc)
RAM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
RAM_USADA=$(free -m | awk '/Mem:/ {print $3}')
RAM_PCT=$((RAM_USADA * 100 / RAM_TOTAL))
DISCO_USO=$(df -h / | awk 'NR==2 {print $5}')
DISCO_LIBRE=$(df -h / | awk 'NR==2 {print $4}')
NUM_PROC=$(ps aux | tail -n +2 | wc -l)
PROC_R=$(ps aux | awk '$8=="R" {count++} END {print count+0}')
PROC_S=$(ps aux | awk '$8~/S/ {count++} END {print count+0}')
IP=$(hostname -I | awk '{print $1}')

# ── FUNCIÓN: BARRA DE PROGRESO ──────────────────────
function barra() {
    local pct=$1
    local llenos=$((pct / 5))
    local vacios=$((20 - llenos))
    printf "["
    for i in $(seq 1 $llenos);  do printf "█"; done
    for i in $(seq 1 $vacios); do printf "░"; done
    printf "] %d%%" $pct
}

# ── FUNCIÓN: ESTADO DE RAM ──────────────────────────
function estado_ram() {
    if   [ $RAM_PCT -gt 80 ]; then echo "CRITICO"
    elif [ $RAM_PCT -gt 60 ]; then echo "ELEVADO"
    else                            echo "NORMAL"
    fi
}

# ── IMPRESIÓN DEL REPORTE ───────────────────────────
echo
echo "╔══════════════════════════════════════════════╗"
echo "║   DIAGNÓSTICO DE SISTEMA OPERATIVO            ║"
echo "║   Taller de SO · P6 · TECNM - ITE            ║"
echo "╚══════════════════════════════════════════════╝"
echo
echo "  Estudiante   : $ESTUDIANTE"
echo "  N° Control   : $NUMERO_CONTROL"
echo "  Grupo        : $GRUPO"
echo "  Generado     : $FECHA"
echo
echo "──────────────────────────────────────────────"
echo "  SISTEMA"
echo "──────────────────────────────────────────────"
echo "  SO           : $SO"
echo "  Kernel       : $KERNEL ($ARCH)"
echo "  Máquina      : $USUARIO@$HOST  [$IP]"
echo "  Encendido    : $UPTIME"
echo
echo "──────────────────────────────────────────────"
echo "  HARDWARE"
echo "──────────────────────────────────────────────"
echo "  CPU          : $CPU_MODEL"
echo "  Núcleos      : $CPU_CORES"
printf "  RAM          : %s MB total | %s MB usados\n" $RAM_TOTAL $RAM_USADA
printf "  Uso RAM      : "; barra $RAM_PCT; printf "  [%s]\n" $(estado_ram)
echo  "  Disco /      : Libre $DISCO_LIBRE  |  Uso: $DISCO_USO"
echo
echo "──────────────────────────────────────────────"
echo "  PROCESOS (equivalente a la Práctica P2)"
echo "──────────────────────────────────────────────"
echo "  Total procesos    : $NUM_PROC"
echo "  Estado Running(R) : $PROC_R   ← usando CPU ahora"
echo "  Estado Sleep(S)   : $PROC_S   ← bloqueados/esperando"
echo
echo "  Top 5 procesos por uso de CPU:"
ps aux --sort=-%cpu | awk 'NR>1 && NR<=6 {printf "  %-8s %-6s %-5s %s\n", $1, $2, $3"%", $11}'
echo
echo "══════════════════════════════════════════════"
echo "  Script ejecutado correctamente. P6 completada."
echo "══════════════════════════════════════════════"
echo
