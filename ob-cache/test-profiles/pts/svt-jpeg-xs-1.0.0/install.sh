#!/bin/sh
7z x Bosphorus_1920x1080_120fps_420_8bit_YUV_RAW.7z -aoa
7z x Bosphorus_3840x2160_120fps_420_8bit_YUV_Y4M.7z -aoa
7z x Beauty_3840x2160_120fps_420_10bit_YUV_RAW.7z -aoa

tar -xf SVT-JPEG-XS-0.9.0.tar.gz
cd SVT-JPEG-XS-0.9.0
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
./SVT-JPEG-XS-0.9.0/Bin/Release/SvtJpegxsEncApp -n 9999 --lp \$NUM_CPU_CORES -b /dev/null \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > svt-jpeg-xs
chmod +x svt-jpeg-xs
