#!/bin/bash

logs_dir="/opt/logs"
target_dir="/home/administrator/logs"
archive_name="logs_week_$(date -d 'last sunday' +%Y-%m-%d).tar.gz"
log_file="/root/script/copy.log"

cd "$logs_dir" || { echo "Ошибка: Невозможно перейти в папку $logs_dir" >> "$log_file"; exit 1; }

find . -type f -name "server.log_*" -mtime -7 -exec mv {} "$target_dir" \; >> "$log_file" 2>&1
if [ $? -ne 0 ]; then
    echo "Ошибка: Не удалось переместить файлы в $target_dir" >> "$log_file"
    exit 1
fi

cd "$target_dir" || { echo "Ошибка: Невозможно перейти в папку $target_dir" >> "$log_file"; exit 1; }

tar -czf "${archive_name}" * >> "$log_file" 2>&1
if [ $? -ne 0 ]; then
    echo "Ошибка: Не удалось архивировать файлы в $target_dir" >> "$log_file"
    exit 1
fi

echo "Логи за последнюю неделю перемещены и архивированы." >> "$log_file"
