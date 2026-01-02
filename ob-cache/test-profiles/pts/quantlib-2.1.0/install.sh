#!/bin/bash
tar -xf QuantLib-1.37.tar.gz
cd QuantLib-1.37
mkdir build
cd build
CFLAGS_EXTRA=""
arch=$(uname -i)
if [ "$arch" == 'x86_64' ];
then
	# Since -march=native doesn't work for most other archs...
	CFLAGS_EXTRA=" -march=native"
fi
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-O3 $CFLAGS_EXTRA" -DCMAKE_C_FLAGS="-O3 $CFLAGS_EXTRA" -DQL_ENABLE_PARALLEL_UNIT_TEST_RUNNER=ON 
if [ $OS_TYPE = "BSD" ]
then
	gmake -j $NUM_CPU_CORES
	echo $? > ~/install-exit-status
else
	make -j $NUM_CPU_CORES
	echo $? > ~/install-exit-status
fi
cd ~
echo "#!/bin/bash
cd QuantLib-1.37/build
./test-suite/quantlib-benchmark --nProc=\$NUM_CPU_CORES --verbose=1 \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > quantlib
chmod +x quantlib
