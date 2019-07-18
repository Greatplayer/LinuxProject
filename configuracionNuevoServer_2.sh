#!/bin/bash

read -p "--------------Creando carpeta para descomprimir el archivo--------------"
mkdir /backupRestaura
chmod 777 /backupRestaura

read -p "--------------Copiando archivo de backup generado en origen--------------"
cp /migracionBackupServer/backup190720.tar /backupRestaura
chmod 777 /migracionBackupServer/backup190720.tar

read -p "--------------Desempaquetar el archivo tar--------------"
tar -xvf /migracionBackupServer/backup190720.tar

read -p "--------------Copiar la configuracion de restauracion--------------"
cp /HerramientasBera/_bera_restore_config_example _bera_config

echo "Final de script: configuracionNuevoServer_2.sh"
