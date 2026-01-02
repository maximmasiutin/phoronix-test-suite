#!/bin/sh
tar -xf NeatBench6_Linux_x64.tgz
echo "#!/bin/sh
echo \"\n\" | ./NeatBench6 \$@  > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > neatbench
chmod +x neatbench
