#!/bin/sh
cd gcc-15.2.0
make distclean
./configure --disable-multilib --enable-checking=release
