#!/bin/bash

read -p "----------------------------Empaquetar el backup para la transmision--------------"
tar cvf /home/backups/backup190720.tar /home/backups/backups
chmod 777 /home/backups/backup190720.tar

read -p "----------------------------Copiando el backup al nuevo servidor--------------"
cp /home/backups/backup190720.tar /migracionServer

echo "Final de script: configuracionViejoServer_2.sh"
