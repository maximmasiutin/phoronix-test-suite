#!/bin/sh
unzip -o NeatBench6_Win_x64.zip
chmod +x NeatBench6.exe
echo "#!/bin/sh
echo \"\n\" | ./NeatBench6.exe \$@  > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > neatbench
chmod +x neatbench
