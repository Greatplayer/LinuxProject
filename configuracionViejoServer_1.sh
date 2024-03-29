#!/bin/bash

ipDestino=$1

if [ -z "$ipDestino" ]
then
      echo "No ingreso IP destino"
      exit
fi

read -p "--------------Crear archivos de prueba--------------"
touch /home/ejemplo1.txt
touch /home/ejemplo2.txt


read -p "--------------IP destino ingresado: $1--------------"
mkdir /migracionServer

read -p "--------------Crear carpeta de destino backup--------------"
chmod 777 /migracionServer

mount -t nfs $1:/migracionBackupServer /migracionServer

read -p "--------------instalar libreria perl para el backup--------------"
yum -y install php-pear

read -p "--------------Creando carpeta para hospedar el bera-backup--------------"
mkdir /HerramientaBera
chmod 777 /HerramientaBera

read -p "--------------Descargandolo del repositorio--------------"
git clone https://github.com/oslcixug/bera-backup.git --depth 1 --branch=master /HerramientaBera


read -p "--------------Dandole permisos al script de bera-backup--------------"
chmod 777 /HerramientaBera/bera-backup.sh

read -p "--------------Creando configuracion en base al modelo--------------"
cp /HerramientaBera/_bera_backup_config_example  /HerramientaBera/_bera_config
rm -f /HerramientaBera/_bera_restore_config_example
rm -f /HerramientaBera/bera-restore.sh
rm -f /HerramientaBera/backup_download.sh

read -p "--------------Creando carpeta donde se almacenara el backup--------------"
mkdir -p /home/backups/backups

read -p "--------------Configuracion Inicial Terminada--------------"

echo "Final de script: configuracionViejoServer_1.sh"
