#!/bin/bash
chmod +x llamafile-bench-0.8.17
echo $? > ~/install-exit-status
echo "#!/bin/sh
./llamafile-bench-0.8.17 -t \$NUM_CPU_PHYSICAL_CORES -v \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ~/llamafile
chmod +x ~/llamafile
