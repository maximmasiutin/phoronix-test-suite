#!/bin/sh
7z x hashcat-7.0.0.7z -aoa
echo $? > ~/install-exit-status
echo "#!/bin/sh
cd hashcat-7.0.0
./hashcat.bin -b \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > hashcat
chmod +x hashcat
