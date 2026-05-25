#!/bin/bash
clear
echo "=============================================================="
echo "   _                               _                         "
echo "  | |    __ _ _ __ __ ___   _____| |                        "
echo "  | |   / _\` | '__/ _\` \\ \\ / / _ \\ |                        "
echo "  | |__| (_| | | | (_| |\\ V /  __/ |                        "
echo "  |_____\\__,_|_|  \\__,_| \\_/ \\___|_|                        "
echo "                                                            "
echo "=============================================================="
echo "               Laravel Project Remover"
echo "                     by Diegote"
echo "=============================================================="
echo ""
echo "        ╔══════════════════════════════════════╗"
echo "        ║         AlmaLinux Edition           ║"
echo "        ║       Laravel Cleanup Tool          ║"
echo "        ╚══════════════════════════════════════╝"
echo ""
echo "              BlackArch > everything"
echo ""
echo "=============================================================="
echo ""

set -e

echo "=============================================================="
echo "              Laravel Project Remover"
echo "=============================================================="
echo ""

# ---------------------------------------------------------
#  Nombre del proyecto
# ---------------------------------------------------------

read -p "[?] Nombre de la carpeta del proyecto: " PROJECT

PROJECT_PATH="/var/www/html/$PROJECT"

# ---------------------------------------------------------
#  Verificación
# ---------------------------------------------------------

if [ ! -d "$PROJECT_PATH" ]; then
    echo ""
    echo "[!] El proyecto no existe:"
    echo "    $PROJECT_PATH"
    echo ""
    exit 1
fi

# ---------------------------------------------------------
#  Confirmación
# ---------------------------------------------------------

echo ""
echo "[!] Proyecto encontrado:"
echo "    $PROJECT_PATH"
echo ""

read -p "[?] Seguro que querés borrarlo? (s/n): " CONFIRM

if [[ "$CONFIRM" != "s" ]]; then
    echo ""
    echo "[*] Operación cancelada."
    echo ""
    exit 0
fi

# ---------------------------------------------------------
#  Permisos
# ---------------------------------------------------------

echo ""
echo "[+] Ajustando permisos..."
echo ""

sudo chmod -R 777 "$PROJECT_PATH" || true

# ---------------------------------------------------------
#  Eliminación
# ---------------------------------------------------------

echo ""
echo "[+] Borrando proyecto..."
echo ""

sudo rm -rf "$PROJECT_PATH"

# ---------------------------------------------------------
#  Limpieza básica
# ---------------------------------------------------------

echo ""
echo "[+] Limpiando cache..."
echo ""

sudo dnf clean all

# ---------------------------------------------------------
#  Final
# ---------------------------------------------------------

echo ""
echo "=============================================================="
echo "              Proyecto eliminado correctamente"
echo "=============================================================="
echo ""
echo " Ruta eliminada:"
echo "   $PROJECT_PATH"
echo ""
echo "=============================================================="
echo "                  Todo Listooo UwU"
echo "=============================================================="
echo ""