#!/bin/bash

read -p "--------------Creando carpeta para descomprimir el archivo--------------"
mkdir /backupRestaura
chmod 777 /backupRestaura

read -p "--------------Copiando archivo de backup generado en origen--------------"
cp /migracionBackupServer/backup190720.tar /backupRestaura
chmod 777 /migracionBackupServer/backup190720.tar

read -p "--------------Desempaquetar el archivo tar--------------"
tar -xvf /backupRestaura/backup190720.tar -C /backupRestaura

read -p "--------------Copiar la configuracion de restauracion--------------"
cp /HerramientaBera/_bera_restore_config_example /HerramientaBera/_bera_config

echo "Final de script: configuracionNuevoServer_2.sh"
