#!/bin/bash
ipCompartir=$1

if [ -z "$ipCompartir" ]
then
      echo "No ingreso IP"
      exit
fi

carpeta=/migracionBackupServer
opciones="(rw,sync,no_root_squash,no_all_squash)"

read -p "----------------------------IP ingresado: $1--------------"
read -p "----------------------------Creando carpeta para hospedar el bera-backup--------------"
mkdir /HerramientaBera
read -p "----------------------------Descargandolo del repositorio--------------"
git clone https://github.com/oslcixug/bera-backup.git --depth 1 --branch=master /HerramientaBera
rm -f /HerramientaBera/_bera_backup_config_example
rm -f /HerramientaBera/bera-backup.sh
rm -f /HerramientaBera/backup_download.sh

read -p "--------------Descargando software de NFS Utils--------------"
yum -y install nfs-utils
read -p "--------------Creación de carpeta compartida con permisos--------------"
mkdir /migracionBackupServer
chmod -R 755 /migracionBackupServer
chown nfsnobody:nfsnobody /migracionBackupServer

read -p "--------------Habilitando los servicios--------------"
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap

read -p "--------------Agregando la IP origen del backup--------------"

echo $carpeta $ipCompartir$opciones>> /etc/exports

read -p "--------------Reiniciando el servicio de compartido--------------"
exportfs -a
systemctl restart nfs-server

read -p "--------------configurando el firewall--------------"
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --reload

read -p "--------------Listar los compartidos--------------"
exportfs

echo "Final de script: configuracionNuevoServer_1.sh"
