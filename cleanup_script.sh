#!/bin/bash

directories=("/opt/x" "/opt/y" "/opt/z" "/opt/w" "/opt/k" "/opt/v" "/opt/q")
days_to_keep=3

for dir in "${directories[@]}"; do
    echo "Обработка директории: $dir"
    find "$dir" -type f -mtime +"$days_to_keep" -exec rm {} \;
done
