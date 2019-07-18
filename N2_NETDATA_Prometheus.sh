#!/bin/bash

read -p "----------------------------Instalar prometheus--------------"
wget -O /tmp/prometheus-2.3.2.linux-amd64.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.3.2/prometheus-2.3.2.linux-amd64.tar.gz

read -p "----------------------------Crear usuario de prometheus--------------"
useradd -r prometheus

read -p "----------------------------Crear directorio de prometheus--------------"
mkdir /opt/prometheus
chown prometheus:prometheus /opt/prometheus

read -p "----------------------------Desempaquetar el software de prometheus--------------"
tar -xvf /tmp/prometheus-2.3.2.linux-amd64.tar.gz -C /opt/prometheus --strip=1

read -p "----------------------------Copiar el service en la carpeta--------------"
cp /RepositorioInicial/prometheus.service /etc/systemd/system/prometheus.service

read -p "----------------------------Copiar el service en la carpeta--------------"
#0975 copiar el prometheus.yml en /opt/prometheus/prometheus.yml (ponerlo en directorio de documentos)
cp /RepositorioInicial/prometheus.yml /opt/prometheus/prometheus.yml

read -p "----------------------------Iniciar prometheus--------------"
systemctl start prometheus
systemctl enable prometheus

