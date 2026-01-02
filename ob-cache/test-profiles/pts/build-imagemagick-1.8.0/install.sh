#!/bin/sh
echo "#!/bin/sh
cd ImageMagick-7.1.2-3
make -s -j\$NUM_CPU_JOBS 2>&1
echo \$? > ~/test-exit-status" > time-compile-imagemagick
chmod +x time-compile-imagemagick
