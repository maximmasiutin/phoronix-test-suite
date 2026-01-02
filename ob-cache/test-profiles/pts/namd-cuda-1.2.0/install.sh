#!/bin/sh

tar -zxvf NAMD_3.0.1_Linux-x86_64-multicore-CUDA.tar.gz
unzip -o f1atpase.zip
tar -xf stmv_gpu.tar.gz
sed -i 's/\/usr\/tmp/\/tmp/g' f1atpase/f1atpase.namd
cd ~
echo "#!/bin/sh
cd NAMD_3.0.1_Linux-x86_64-multicore-CUDA
./namd3 +idlepoll +p\$NUM_CPU_CORES +setcpuaffinity \$@ > \$LOG_FILE 2>&1" > namd-cuda
chmod +x namd-cuda
