#!/bin/sh
unzip -o waifu2x-ncnn-vulkan-20250504-ubuntu.zip
cd waifu2x-ncnn-vulkan-20250504-ubuntu/
tar -xvf ../stock-photos-jpeg-2018-1.tar.xz
cd ~/
cat>waifu2x-ncnn<<EOT
#!/bin/sh
cd waifu2x-ncnn-vulkan-20250504-ubuntu/
./waifu2x-ncnn-vulkan -i 20180726_194657.JPG -o out.png \$@  > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
EOT
chmod +x waifu2x-ncnn
