#!/bin/bash

read -p "----------------------------Conseguir dependencias de NETDATA--------------"
wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm

read -p "----------------------------Instalar NETDATA--------------"
bash <(curl -Ss https://my-netdata.io/kickstart.sh) all

read -p "----------------------------Iniciar NETDATA--------------"
systemctl start netdata

read -p "----------------------------Agregar excepciones a los puertos del firewall--------------"
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --zone=public --add-port=19999/tcp --permanent
firewall-cmd --zone=public --add-port=9090/tcp --permanent
firewall-cmd --reload

