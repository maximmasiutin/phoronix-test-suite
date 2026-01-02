#!/bin/sh
unzip -o john-38cfbe9cc2477a64a233d477d0c45a300fb2f8ed.zip
cd john-38cfbe9cc2477a64a233d477d0c45a300fb2f8ed/src/
CFLAGS="-O3 -march=native $CFLAGS" ./configure --disable-native-tests --disable-opencl
CFLAGS="-O3 -march=native $CFLAGS" make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~/
echo "#!/bin/sh
cd john-38cfbe9cc2477a64a233d477d0c45a300fb2f8ed/run/
./john \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > john-the-ripper
chmod +x john-the-ripper
