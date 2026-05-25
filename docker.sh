#!/bin/bash

clear

echo "========================================================="
echo "      ____             _"
echo "     |  _ \  ___   ___| | _____ _ __"
echo "     | | | |/ _ \ / __| |/ / _ \ '__|"
echo "     | |_| | (_) | (__|   <  __/ |"
echo "     |____/ \___/ \___|_|\_\___|_|"
echo ""
echo "========================================================="
echo "          Docker MSSQL Installer"
echo "              by Diegote"
echo "========================================================="

set -e

PROJECT="docker-mssql"
SA_PASSWORD="TuPasswordSuperSegura123!"

echo ""
echo "[+] Instalando Docker..."

dnf update -y
dnf install -y dnf-plugins-core curl git wget nano unzip

dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable docker
systemctl start docker

echo ""
echo "[+] Creando estructura..."

mkdir -p $PROJECT
cd $PROJECT

cat > docker-compose.yml <<EOF
services:
  mssql:
    image: mcr.microsoft.com/mssql/server:2022-latest
    container_name: docker_mssql
    restart: unless-stopped
    environment:
      ACCEPT_EULA: "Y"
      SA_PASSWORD: "$SA_PASSWORD"
      MSSQL_PID: "Developer"
    ports:
      - "1433:1433"
    volumes:
      - mssql_data:/var/opt/mssql

volumes:
  mssql_data:
EOF

echo ""
echo "[+] Levantando MSSQL..."

docker compose up -d

echo ""
echo "[+] Esperando inicialización..."
sleep 20

echo ""
echo "====================================================="
echo "               MSSQL listo"
echo "====================================================="
echo "Host: TU-IP"
echo "Puerto: 1433"
echo "Usuario: sa"
echo "Password: $SA_PASSWORD"
echo "====================================================="
echo "                    UWU"
echo "====================================================="