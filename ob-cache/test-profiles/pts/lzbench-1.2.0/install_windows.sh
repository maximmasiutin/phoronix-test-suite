#!/bin/sh
gunzip -k linux-6.14.tar.gz
unzip -o lzbench201_windows_gcc13.zip
chmod +x lzbench201.exe
echo "#!/bin/sh
./lzbench201.exe -t10,10 -v \$@ linux-6.14.tar > \$LOG_FILE" > lzbench
chmod +x lzbench
