#!/bin/sh
7z x Bosphorus_1920x1080_120fps_420_8bit_YUV_RAW.7z -aoa
7z x Bosphorus_3840x2160_120fps_420_8bit_YUV_Y4M.7z -aoa
7z x Beauty_3840x2160_120fps_420_10bit_YUV_RAW.7z -aoa
tar -xf openapv-0.1.13.1.tar.gz
cd openapv-0.1.13.1
cmake -DCMAKE_BUILD_TYPE=Release -S . -B build
cmake --build build
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
./openapv-0.1.13.1/build/bin/oapv_app_enc \$@ -o out.apv > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
rm -f out.apv" > openapv
chmod +x openapv
