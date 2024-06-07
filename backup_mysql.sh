#!/bin/sh

tm=$(date "+%Y_%m_%d")
opts='StrictHostKeyChecking=no'

cd /home/scripts || exit

mysqldump --single-transaction --skip-lock-tables -u root -pXXXXXXXXX test > test_$tm.sql

tar -czf test_$tm.tar.gz test_$tm.sql

rm test_$tm.sql

echo "put test_$tm.tar.gz" | scp -o $opts test_$tm.tar.gz backup:/opt/test



rm test_$tm.tar.gz
