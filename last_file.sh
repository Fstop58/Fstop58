#!/bin/bash

REMOTE_USER="user123"
REMOTE_HOST="123.12.123.12"
REMOTE_DIR="/Data/VGK/PostgreBackUpVGK/VG"

LOCAL_DIR="/opt/VG"

# Путь к файлу журнала
LOG_FILE="/home/script/backup.log"


echo "=== Начало копирования ===" > "$LOG_FILE"

# Получение последнего файла из удаленного каталога с расширением .dump
echo "Получение последнего файла с $REMOTE_HOST:$REMOTE_DIR..." >> "$LOG_FILE"
LATEST_FILE=$(ssh "$REMOTE_USER@$REMOTE_HOST" "ls -t $REMOTE_DIR/*.dump | head -n 1")

if [ -z "$LATEST_FILE" ]; then
    echo "Файлы с расширением .dump не найдены." >> "$LOG_FILE"
else
    echo "Последний файл: $(basename $LATEST_FILE)" >> "$LOG_FILE"
    echo "Копирование последнего файла $(basename $LATEST_FILE) с $REMOTE_HOST:$REMOTE_DIR в $LOCAL_DIR..." >> "$LOG_FILE"
    
    # Копирование последнего файла с расширением .dump
    scp "$REMOTE_USER@$REMOTE_HOST:$LATEST_FILE" "$LOCAL_DIR" >> "$LOG_FILE" 2>&1

    
    if [ $? -eq 0 ]; then
        echo "копирование завершено успешно." >> "$LOG_FILE"
    else
        echo "Произошла ошибка во время копирования. Подробности см. в $LOG_FILE." >> "$LOG_FILE"
    fi
fi

echo "=== Завершение копирования ===" >> "$LOG_FILE"