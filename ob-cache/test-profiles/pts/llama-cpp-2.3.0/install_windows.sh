#!/bin/bash
mkdir llama.cpp-BLAS
cd llama.cpp-BLAS
unzip -o ../llama-b7083-bin-win-cpu-x64.zip
cd ~
mkdir llama.cpp-VULKAN
cd llama.cpp-VULKAN
unzip -o ../llama-b7083-bin-win-vulkan-x64.zip
cd ~
echo "#!/bin/bash
LLAMA_BENCH_ARGS=\`echo \"\$@\" | sed \"s/\$1/ /g\"\`
cd llama.cpp-\$1
./llama-bench.exe -t \$NUM_CPU_PHYSICAL_CORES \$LLAMA_BENCH_ARGS > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ~/llama-cpp
chmod +x ~/llama-cpp
