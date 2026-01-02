#!/bin/sh
echo "#!/bin/sh
cd otp_src_28.1
make -j \$NUM_CPU_CORES
echo \$? > ~/test-exit-status" > build-erlang
chmod +x build-erlang
