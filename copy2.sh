#!/bin/bash

source_dir="/home/administrator/logs"

remote_server="administrator@123.12.123.12"
remote_dir="/opt/bkp/logs"

log_file="/home/script/copy_logs.log"

scp -r "$source_dir"/*.tar.gz "$remote_server":"$remote_dir" >> "$log_file" 2>&1

# Проверка на успешность
if [ $? -eq 0 ]; then
    rm -rf "$source_dir"/*
    echo "Архив успешно скопирован на сервер: $remote_server:$remote_dir и все файлы удалены из $source_dir." >> "$log_file"
else
    echo "Ошибка при копировании архивов на сервер." >> "$log_file"
fi


