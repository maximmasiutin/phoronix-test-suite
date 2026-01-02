#!/bin/sh
rm -rf pogocache-1.2.0
tar -xf pogocache-1.2.0.tar.gz
cd pogocache-1.2.0
make
retVal=$?
if [ $retVal -ne 0 ]; then
	echo $retVal > ~/install-exit-status
	exit $retVal
fi
cd ~
tar -xf memtier_benchmark-2.2.0.tar.gz
cd memtier_benchmark-2.2.0/
autoreconf -ivf
./configure
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status

cd ~
echo "#!/bin/sh
cd pogocache-1.2.0
./pogocache -t \$NUM_CPU_CORES &
POGOCACHE_PID=\$!
sleep 6
cd ~/memtier_benchmark-2.2.0/
./memtier_benchmark --hide-histogram -t \$NUM_CPU_CORES \$@ > \$LOG_FILE
sleep 1
kill \$POGOCACHE_PID
sleep 1" > pogocache
chmod +x pogocache

