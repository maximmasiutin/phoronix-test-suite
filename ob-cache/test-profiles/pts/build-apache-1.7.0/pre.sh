#!/bin/sh
rm -rf httpd/
rm -rf httpd-2.4.63/
tar -xjvf httpd-2.4.63.tar.bz2
mv httpd-2.4.63 httpd/
tar -jxvf apr-util-1.6.3.tar.bz2
tar -jxvf apr-1.7.6.tar.bz2
mv apr-1.7.6 httpd/srclib/apr
mv apr-util-1.6.3 httpd/srclib/apr-util
cd httpd/
./configure --with-included-apr > /dev/null
make clean

