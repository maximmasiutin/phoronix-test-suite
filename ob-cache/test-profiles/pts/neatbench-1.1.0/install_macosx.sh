#!/bin/sh
unzip -o NeatBench6_MacOS.zip
echo "#!/bin/sh
echo \"\n\" | ./NeatBench6 \$@  > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > neatbench
chmod +x neatbench
