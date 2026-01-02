#!/bin/bash
tar -xf llama.cpp-b7083.tar.gz
rm -rf llama.cpp-BLAS
rm -rf llama.cpp-CUDA
cp -va llama.cpp-b7083 llama.cpp-BLAS
cd llama.cpp-BLAS
cmake -B build -DGGML_BLAS=ON -DCMAKE_BUILD_TYPE=Release -DGGML_BLAS_VENDOR=OpenBLAS
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
	cp -va llama.cpp-b7083 llama.cpp-CUDA
	cd llama.cpp-CUDA
	cmake -B build -DGGML_CUDA=ON -DCMAKE_BUILD_TYPE=Release
	cmake --build build --config Release -j $NUM_CPU_CORES
	cd ~
fi
if which hipconfig >/dev/null 2>&1 ;
then
	rm -rf llama.cpp-ROCM
	cp -va llama.cpp-b7083 llama.cpp-ROCM
	cd llama.cpp-ROCM
	HIPCXX="$(hipconfig -l)/clang" HIP_PATH="$(hipconfig -R)" cmake -S . -B build -DGGML_HIP=ON  -DCMAKE_BUILD_TYPE=Release -DAMDGPU_TARGETS=`rocminfo | grep gfx | head -n 1 | grep -o "gfx.*"`
	cmake --build build --config Release -j $NUM_CPU_CORES
	cd ~
fi
cd ~
mkdir llama.cpp-VULKAN
cd llama.cpp-VULKAN
# Use prebuilt Llama.cpp Vulkan since automating the Vulkan SDK can be messy/problematic in some configurations
unzip -o ../llama-b7083-bin-ubuntu-vulkan-x64.zip
cd ~
rm -rf llama.cpp-b7083
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
