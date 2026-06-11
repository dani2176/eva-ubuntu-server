#!/bin/bash

FECHA=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p ../temp

echo "Iniciando respaldo..."

tar -czf ../temp/backup_$FECHA.tar.gz /home/daniel/mi_proyecto

echo "$(date) - Backup generado correctamente" >> ../logs/backup.log

echo "Respaldo finalizado"
