'EOF'
#!/bin/bash

set -e

echo "Actualizando sistema..."
dnf update -y

echo "Instalando repositorios necesarios..."
dnf install -y epel-release

echo "Instalando utilidades base..."
dnf install -y \
    wget \
    curl \
    unzip \
    git \
    tar \
    nano

echo "Instalando PHP y extensiones necesarias para Composer/Laravel..."
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
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

echo "Instalando Composer globalmente..."
php composer-setup.php --install-dir=/usr/local/bin --filename=composer

rm -f composer-setup.php

echo "Verificando instalación..."
php -v
composer --version

echo "Composer instalado correctamente."
EOF
