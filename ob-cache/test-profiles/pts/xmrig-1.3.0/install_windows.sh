#!/bin/sh
# Windows support currently disabled since it doesn't auto quit at the end...
unzip -o xmrig-6.25.0-windows-x64.zip
chmod +x xmrig-6.25.0/xmrig.exe
echo "#!/bin/sh
cd xmrig-6.25.0
./xmrig.exe --no-color --threads=\$NUM_CPU_CORES \$@ --verbose -l out.log >> \$LOG_FILE 2>&1
cat out.log > \$LOG_FILE" > xmrig
chmod +x xmrig
