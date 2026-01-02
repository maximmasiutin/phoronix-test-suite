#!/bin/sh
gunzip -k linux-6.14.tar.gz
tar -xf lzbench-2.0.1.tar.gz
cd lzbench-2.0.1
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd lzbench-2.0.1
./lzbench -t10,10 -v \$@ ../linux-6.14.tar > \$LOG_FILE
echo \$? > ~/test-exit-status" > lzbench
chmod +x lzbench
