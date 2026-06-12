#!/bin/bash

FECHA=$(date +%Y-%m-%d_%H-%M-%S)

BASE_DIR="$HOME/mi_proyecto/backup_gdrive"
TEMP_DIR="$BASE_DIR/temp"
LOG_DIR="$BASE_DIR/logs"
LOG_FILE="$LOG_DIR/backup.log"

mkdir -p "$TEMP_DIR"
mkdir -p "$LOG_DIR"

ARCHIVO="$TEMP_DIR/backup_$FECHA.tar.gz"

echo "$(date) - Inicio respaldo" >> "$LOG_FILE"

tar --exclude="$TEMP_DIR" -czf "$ARCHIVO" "$HOME/mi_proyecto"

echo "$(date) - Archivo generado: $ARCHIVO" >> "$LOG_FILE"

ACCESS_TOKEN=$("$HOME/mi_proyecto/refresh_token.sh")

curl -s -X POST -H "Authorization: Bearer $ACCESS_TOKEN" -F "metadata={name:'$(basename "$ARCHIVO")'};type=application/json;charset=UTF-8" -F "file=@$ARCHIVO;type=application/gzip" "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart"

echo "$(date) - Archivo enviado a Google Drive" >> "$LOG_FILE"

rm -f "$ARCHIVO"

echo "$(date) - Archivo local eliminado: $ARCHIVO" >> "$LOG_FILE"

echo "$(date) - Respaldo finalizado" >> "$LOG_FILE"

echo "Respaldo finalizado"
