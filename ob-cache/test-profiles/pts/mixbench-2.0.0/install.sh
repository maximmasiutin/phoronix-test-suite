#!/bin/bash
unzip -o mixbench-3dc1cdc27a68680caa4bdab7d89c45543d71363d.zip
cd mixbench-3dc1cdc27a68680caa4bdab7d89c45543d71363d
rm -rf build-*
mkdir build-cpu
cd build-cpu
cmake -DCMAKE_BUILD_TYPE=Release ../mixbench-cpu/
cmake --build .
echo $? > ~/install-exit-status
cd ~/mixbench-3dc1cdc27a68680caa4bdab7d89c45543d71363d

mkdir build-opencl
cd build-opencl
cmake -DCMAKE_BUILD_TYPE=Release ../mixbench-opencl/
cmake --build .
echo $? > ~/install-exit-status
cd ~/mixbench-3dc1cdc27a68680caa4bdab7d89c45543d71363d

if ! which nvcc >/dev/null 2>&1 ;
then
	if [ -d /usr/local/cuda ]
	then
		export LD_LIBRARY_PATH=/usr/local/cuda/lib64/:$LD_LIBRARY_PATH
		export PATH=/usr/local/cuda/bin/:$PATH
	fi
fi
if which nvcc >/dev/null 2>&1 ;
then
	mkdir build-cuda
	cd build-cuda
	cmake -DCMAKE_BUILD_TYPE=Release ../mixbench-cuda/
	cmake --build .
	echo $? > ~/install-exit-status
	cd ~/mixbench-3dc1cdc27a68680caa4bdab7d89c45543d71363d
fi

if which hipconfig >/dev/null 2>&1 ;
then
	mkdir build-hip
	cd build-hip
	cmake -DCMAKE_BUILD_TYPE=Release ../mixbench-hip/
	cmake --build .
	echo $? > ~/install-exit-status
	cd ~/mixbench-3dc1cdc27a68680caa4bdab7d89c45543d71363d
fi

cd ~/
echo "#!/bin/sh
cd mixbench-3dc1cdc27a68680caa4bdab7d89c45543d71363d/build-\$1
./mixbench-\$2 > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > mixbench
chmod +x mixbench
