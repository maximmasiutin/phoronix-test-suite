#!/bin/bash
tar -xf llama.cpp-b4397.tar.gz
rm -rf llama.cpp-BLAS
rm -rf llama.cpp-CUDA
cp -va llama.cpp-b4397 llama.cpp-BLAS
cd llama.cpp-BLAS
cmake -B build -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS
cmake --build build --config Release -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~
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
	cp -va llama.cpp-b4397 llama.cpp-CUDA
	cd llama.cpp-CUDA
	cmake -B build -DGGML_CUDA=ON
	cmake --build build --config Release -j $NUM_CPU_CORES
fi
cd ~
rm -rf llama.cpp-b4397
echo "#!/bin/bash
LLAMA_BENCH_ARGS=\`echo \"\$@\" | sed \"s/\$1/ /g\"\`
cd llama.cpp-\$1
if [ -d /usr/local/cuda ]
then
	export LD_LIBRARY_PATH=/usr/local/cuda/lib64/:$LD_LIBRARY_PATH
	export PATH=/usr/local/cuda/bin/:$PATH
fi
./build/bin/llama-bench -t \$NUM_CPU_PHYSICAL_CORES \$LLAMA_BENCH_ARGS > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ~/llama-cpp
chmod +x ~/llama-cpp
