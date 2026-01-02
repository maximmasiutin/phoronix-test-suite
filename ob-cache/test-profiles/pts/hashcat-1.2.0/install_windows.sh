#!/bin/sh
7z x hashcat-7.0.0.7z -aoa
echo "#!/bin/sh
cd hashcat-7.0.0
./hashcat.exe -b \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > hashcat
chmod +x hashcat
