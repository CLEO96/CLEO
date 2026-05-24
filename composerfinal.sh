'EOF'
#!/bin/bash

set -e

echo "Actualizando sistema..."
dnf update -y

echo "Instalando EPEL..."
dnf install -y epel-release

echo "Instalando utilidades..."
dnf install -y wget curl unzip git tar nano

echo "Instalando PHP..."
dnf install -y \
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

echo "Descargando Composer..."
curl -sS https://getcomposer.org/installer -o composer-setup.php

echo "Instalando Composer..."
php composer-setup.php \
--install-dir=/usr/local/bin \
--filename=composer

rm -f composer-setup.php

echo "Verificando..."
php -v
composer --version

echo "Composer instalado correctamente."
EOF