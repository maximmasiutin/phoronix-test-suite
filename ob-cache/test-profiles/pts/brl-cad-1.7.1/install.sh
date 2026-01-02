#!/bin/bash
rm -rf brlcad-rel-7-42-0
tar -xf brlcad-rel-7-42-0.tar.gz
BENCHMARK_DIRECTORY="brlcad-rel-7-42-0/build/bench"
mkdir brlcad-rel-7-42-0/build
cd brlcad-rel-7-42-0/build
cmake .. -DBRLCAD_ENABLE_STRICT=NO -DBRLCAD_BUNDLED_LIBS=ON -DBRLCAD_OPTIMIZED=ON -DBRLCAD_PNG=OFF -DCMAKE_BUILD_TYPE=Release -DBRLCAD_WARNINGS=OFF
if [ "$OS_TYPE" = "BSD" ]
then
	gmake -j $NUM_CPU_CORES
else
	make -j $NUM_CPU_CORES
fi
BUILD_EXIT_STATUS=$?
if [ $BUILD_EXIT_STATUS -ne 0 ] && [[ "$OS_ARCH" == "x86_64" ]];
then
	echo "Switching to x86_64 build if available due to build failure... Likely due to new compiler version? Seems to be common issue with BRL-CAD builds on latest GCC..."
	cd ~
	tar -xf BRL-CAD_7.42.0_Linux_x86_64.tar.bz2
	BENCHMARK_DIRECTORY="BRL-CAD_7.42.0_Linux_x86_64/bin/"
	BUILD_EXIT_STATUS=0
fi
echo $BUILD_EXIT_STATUS > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd $BENCHMARK_DIRECTORY
./benchmark run -P\$NUM_CPU_CORES > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > brl-cad
chmod +x brl-cad
