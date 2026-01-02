#!/bin/sh
tar -xf schbench-20230421.tar.xz
cd schbench-20230421
make
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd schbench-20230421
./schbench \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > schbench
chmod +x schbench

