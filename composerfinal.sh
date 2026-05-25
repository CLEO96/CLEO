'EOF'
#!/bin/bash

clear

echo "=============================================================="
echo "     _____                                          "
echo "    / ____|                                         "
echo "   | |     ___  _ __ ___  _ __   ___  ___  ___ _ __ "
echo "   | |    / _ \\| '_ \` _ \\| '_ \\ / _ \\/ __|/ _ \\ '__|"
echo "   | |___| (_) | | | | | | |_) | (_) \\__ \\  __/ |   "
echo "    \\_____\\___/|_| |_| |_| .__/ \\___/|___/\\___|_|   "
echo "                         | |                         "
echo "                         |_|                         "
echo ""
echo "=============================================================="
echo "                Composer + PHP Installer"
echo "                      by Diegote"
echo "=============================================================="
echo ""
echo "        ╔══════════════════════════════════════╗"
echo "        ║          AlmaLinux Edition          ║"
echo "        ║       PHP • Composer Setup          ║"
echo "        ╚══════════════════════════════════════╝"
echo ""
echo "               BlackArch > everything"
echo ""
echo "=============================================================="
echo ""

set -e

echo "========================================================="
echo "         Instalador Composer + PHP"
echo "========================================================="
echo ""

# ---------------------------------------------------------
#  Actualización del sistema
# ---------------------------------------------------------

echo "[+] Actualizando sistema..."
echo ""

sudo dnf update -y

# ---------------------------------------------------------
#  Repositorios extra
# ---------------------------------------------------------

echo ""
echo "[+] Instalando EPEL..."
echo ""

sudo dnf install -y epel-release

# ---------------------------------------------------------
#  Utilidades base
# ---------------------------------------------------------

echo ""
echo "[+] Instalando utilidades..."
echo ""

sudo dnf install -y \
wget \
curl \
unzip \
git \
tar \
nano

# ---------------------------------------------------------
#  PHP y extensiones
# ---------------------------------------------------------

echo ""
echo "[+] Instalando PHP..."
echo ""

sudo dnf install -y \
php \
php-cli \
php-common \
php-mbstring \
php-xml \
php-curl \
php-zip \
php-opcache \
php-pdo \
php-bcmath \
php-intl \
php-gd

# ---------------------------------------------------------
#  Descarga de Composer
# ---------------------------------------------------------

echo ""
echo "[+] Descargando Composer..."
echo ""

curl -sS https://getcomposer.org/installer -o composer-setup.php

# ---------------------------------------------------------
#  Instalación de Composer
# ---------------------------------------------------------

echo ""
echo "[+] Instalando Composer..."
echo ""

sudo php composer-setup.php \
--install-dir=/usr/local/bin \
--filename=composer

rm -f composer-setup.php

# ---------------------------------------------------------
#  Verificación final
# ---------------------------------------------------------

echo ""
echo "[+] Verificando instalación..."
echo ""

php -v
composer --version

# ---------------------------------------------------------
#  Final
# ---------------------------------------------------------

echo ""
echo "========================================================="
echo "              Instalación completada"
echo "========================================================="
echo ""
echo " PHP:"
echo "   php -v"
echo ""
echo " Composer:"
echo "   composer --version"
echo ""
echo "========================================================="
echo "               Todo Listooo UwU"
echo "========================================================="

EOF