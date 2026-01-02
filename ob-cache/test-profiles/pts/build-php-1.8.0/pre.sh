#!/bin/sh
rm -rf php-8.4.9
tar -xf php-8.4.9.tar.xz
cd php-8.4.9
./configure --without-sqlite3 --without-pdo-sqlite
make clean
