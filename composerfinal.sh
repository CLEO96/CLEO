'EOF'
#!/bin/bash

# =========================================================
#        _____                                          
#       / ____|                                         
#      | |     ___  _ __ ___  _ __   ___  ___  ___ _ __ 
#      | |    / _ \| '_ ` _ \| '_ \ / _ \/ __|/ _ \ '__|
#      | |___| (_) | | | | | | |_) | (_) \__ \  __/ |   
#       \_____\___/|_| |_| |_| .__/ \___/|___/\___|_|   
#                             | |                        
#                             |_|                        
#
# =========================================================
#         Instalador Cute de Composer + PHP
#                 Hecho por Diegote
#
#        Para AlmaLinux (BlackArch > Debian)
# =========================================================
#
#  Este script:
#
#   • Actualiza el sistema
#   • Instala PHP y dependencias
#   • Instala Composer globalmente
#   • Verifica que todo funcione
#
# =========================================================

set -e

clear

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