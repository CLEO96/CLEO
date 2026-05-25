#!/bin/bash

clear

echo "========================================================="
echo "      _                                _                "
echo "     | |    __ _ _ __ __ ___   _____| |               "
echo "     | |   / _\` | '__/ _\` \\ \\ / / _ \\ |               "
echo "     | |__| (_| | | | (_| |\\ V /  __/ |               "
echo "     |_____\\__,_|_|  \\__,_| \\_/ \\___|_|               "
echo "                                                       "
echo "========================================================="
echo "        Instalador Laravel + MSSQL"
echo "              Hecho por Diegote"
echo ""
echo "        ╔════════════════════════════╗"
echo "        ║       AlmaLinux Setup      ║"
echo "        ║    Laravel + PHP + SQL     ║"
echo "        ╚════════════════════════════╝"
echo ""
echo "          BlackArch > cualquier cosa"
echo "========================================================="
echo ""

set -e

echo "========================================================="
echo "         Instalador Laravel + MSSQL"
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
git \
unzip \
zip \
tar \
nano

# ---------------------------------------------------------
#  Apache
# ---------------------------------------------------------

echo ""
echo "[+] Instalando Apache..."
echo ""

sudo dnf install -y httpd

sudo systemctl enable --now httpd

# ---------------------------------------------------------
#  PHP
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
php-bcmath \
php-intl \
php-gd \
php-pdo \
php-opcache \
php-devel \
php-pear

# ---------------------------------------------------------
#  Composer
# ---------------------------------------------------------

echo ""
echo "[+] Instalando Composer..."
echo ""

curl -sS https://getcomposer.org/installer -o composer-setup.php

sudo php composer-setup.php \
--install-dir=/usr/local/bin \
--filename=composer

rm -f composer-setup.php

# ---------------------------------------------------------
#  Microsoft Repo
# ---------------------------------------------------------

echo ""
echo "[+] Agregando repositorio Microsoft..."
echo ""

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo curl -o /etc/yum.repos.d/mssql-release.repo \
https://packages.microsoft.com/config/rhel/9/prod.repo

# ---------------------------------------------------------
#  Drivers MSSQL
# ---------------------------------------------------------

echo ""
echo "[+] Instalando drivers MSSQL..."
echo ""

sudo ACCEPT_EULA=Y dnf install -y \
msodbcsql18 \
mssql-tools18 \
unixODBC-devel

# ---------------------------------------------------------
#  Extensiones MSSQL PHP SIN PECL
# ---------------------------------------------------------

echo ""
echo "[+] Instalando módulos SQL Server para PHP..."
echo ""

sudo dnf install -y php-sqlsrv || true

# ---------------------------------------------------------
#  Reiniciar Apache
# ---------------------------------------------------------

echo ""
echo "[+] Reiniciando Apache..."
echo ""

sudo systemctl restart httpd

# ---------------------------------------------------------
#  Crear proyecto Laravel
# ---------------------------------------------------------

echo ""
echo "[+] Creando proyecto Laravel..."
echo ""

cd /var/www/html

sudo composer create-project laravel/laravel laravel-app

# ---------------------------------------------------------
#  Permisos
# ---------------------------------------------------------

echo ""
echo "[+] Ajustando permisos..."
echo ""

sudo chown -R $USER:$USER laravel-app

chmod -R 775 laravel-app/storage
chmod -R 775 laravel-app/bootstrap/cache

# ---------------------------------------------------------
#  Verificación
# ---------------------------------------------------------

echo ""
echo "[+] Verificando módulos..."
echo ""

php -m | grep sql || true

# ---------------------------------------------------------
#  Final
# ---------------------------------------------------------

echo ""
echo "========================================================="
echo "              Instalación completada"
echo "========================================================="
echo ""
echo " Proyecto:"
echo "   /var/www/html/laravel-app"
echo ""
echo " Entrar:"
echo "   cd /var/www/html/laravel-app"
echo ""
echo " Iniciar Laravel:"
echo "   php artisan serve --host=0.0.0.0 --port=8000"
echo ""
echo "========================================================="
echo "               Todo Listooo UwU"
echo "========================================================="