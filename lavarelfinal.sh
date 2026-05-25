#!/bin/bash

# =========================================================
#      _                                _
#     | |    __ _ _ __ __ ___   _____| |
#     | |   / _` | '__/ _` \ \ / / _ \ |
#     | |__| (_| | | | (_| |\ V /  __/ |
#     |_____\__,_|_|  \__,_| \_/ \___|_|
#
# =========================================================
#        Instalado de Laravel + MSSQL Hecho por Diegote
#             Para AlmaLinux (BlackArch es mejor BTW)
# =========================================================
#
#  Este script:
#
#   • Instala drivers de Microsoft SQL Server
#   • Configura PHP para MSSQL
#   • Crea un proyecto Laravel
#   • Ajusta permisos automáticamente
#   • Verifica que todo funcione
#
# =========================================================

set -e

clear

echo "========================================================="
echo "         Instalador Laravel + MSSQL"
echo "========================================================="
echo ""

# ---------------------------------------------------------
#  Paquetes necesarios del sistema
# ---------------------------------------------------------

echo "[+] Instalando dependencias del sistema..."
echo ""

sudo dnf install -y \
unixODBC \
unixODBC-devel \
gcc \
gcc-c++ \
make \
autoconf \
automake \
re2c

# ---------------------------------------------------------
#  Repositorio Microsoft
# ---------------------------------------------------------

echo ""
echo "[+] Agregando repositorio de Microsoft..."
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
mssql-tools18

# ---------------------------------------------------------
#  PATH de herramientas MSSQL
# ---------------------------------------------------------

echo ""
echo "[+] Configurando PATH..."
echo ""

echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc

source ~/.bashrc

# ---------------------------------------------------------
#  Extensiones PHP para SQL Server
# ---------------------------------------------------------

echo ""
echo "[+] Instalando extensiones PHP SQLSRV..."
echo ""

sudo pecl install sqlsrv
sudo pecl install pdo_sqlsrv

# ---------------------------------------------------------
#  Habilitar extensiones PHP
# ---------------------------------------------------------

echo ""
echo "[+] Activando módulos PHP..."
echo ""

sudo bash -c 'cat > /etc/php.d/30-sqlsrv.ini << EOF
extension=sqlsrv.so
extension=pdo_sqlsrv.so
EOF'

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
echo "[+] Verificando módulos SQLSRV..."
echo ""

php -m | grep sqlsrv || true

# ---------------------------------------------------------
#  Información final
# ---------------------------------------------------------

echo ""
echo "========================================================="
echo "              Instalación completada"
echo "========================================================="
echo ""
echo " Ruta del proyecto:"
echo "   /var/www/html/laravel-app"
echo ""
echo " Entrar al proyecto:"
echo "   cd /var/www/html/laravel-app"
echo ""
echo " Levantar servidor Laravel:"
echo "   php artisan serve --host=0.0.0.0 --port=8000"
echo ""
echo " Módulos MSSQL instalados:"
echo "   sqlsrv"
echo "   pdo_sqlsrv"
echo ""
echo "========================================================="
echo "               Todo Listooo UwU"
echo "========================================================="