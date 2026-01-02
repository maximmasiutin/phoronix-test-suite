#!/bin/sh
tar -xf gdb-16.3.tar.xz
echo "#!/bin/sh
cd gdb-16.3/
mkdir build
cd build
../configure
make -s -j \$NUM_CPU_CORES 2>&1
echo \$? > ~/test-exit-status" > build-gdb
chmod +x build-gdb
