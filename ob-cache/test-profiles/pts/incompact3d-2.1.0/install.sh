#!/bin/sh
tar -xf Incompact3d-5.0.tar.gz
cd Incompact3d-5.0
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status

cd ~/
cat>incompact3d<<EOT
#!/bin/sh
cd Incompact3d-5.0/build/bin
mpirun --allow-run-as-root -np \$NUM_CPU_PHYSICAL_CORES xcompact3d ../../examples/\$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
EOT
chmod +x incompact3d

