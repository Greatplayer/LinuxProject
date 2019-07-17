#!/bin/bash

ipCompartir=$1

read -p "IP ingresado: $1"

read -p "Creando Archivos de test para demostrar la migracion"
touch /home/ejem1.txt
touch /home/ejem2.txt
pause

read -p "Creando carpeta para hospedar el bera-backup"
mkdir /HerramientaBera
read -p "Descargandolo del repositorio"
git clone https://github.com/oslcixug/bera-backup.git --depth 1 --branch=master /HerramientaBera
pause

read -p "Descargando software de NFS Utils"
yum install nfs-utils
read -p "Creación de carpeta compartida con permisos"
mkdir /migracionBackupServer
chmod -R 755 /migracionBackupServer
chown nfsnobody:nfsnobody /migracionBackupServer

read -p "Habilitando los servicios"
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap

read -p "Agregando la IP origen del backup"
echo /migracionBackupServer $ipCompartir (rw,sync,no_root_squash,no_all_squash)  >> /etc/exports

read -p "Reiniciando el servicio de compartido"
exportsfs -a
systemctl restart nfs-server

read -p "configurando el firewall"
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --reload

read -p "Listar los compartidos"
exportfs
