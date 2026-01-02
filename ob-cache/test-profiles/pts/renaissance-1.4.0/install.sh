#!/bin/sh
echo "#!/bin/sh
java -jar renaissance-mit-0.16.0.jar -t 60 \$@ --csv \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > renaissance
chmod +x renaissance
