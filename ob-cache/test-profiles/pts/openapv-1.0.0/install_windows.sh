#!/bin/sh
7z x Bosphorus_1920x1080_120fps_420_8bit_YUV_RAW.7z -aoa
rm -f Bosphorus_Copyright.txt
7z x Bosphorus_3840x2160_120fps_420_8bit_YUV_Y4M.7z -aoa
rm -f Bosphorus_Copyright.txt
7z x Beauty_3840x2160_120fps_420_10bit_YUV_RAW.7z -aoa
rm -f Beauty_Copyright.txt
unzip -o OpenAPV-0.1.13-win64.zip
chmod +x OpenAPV-0.1.13-win64/bin/oapv_app_enc.exe
echo "#!/bin/sh
./OpenAPV-0.1.13-win64/bin/oapv_app_enc.exe \$@ -o out.apv > \$LOG_FILE 2>&1
rm -f out.apv" > openapv
chmod +x openapv
