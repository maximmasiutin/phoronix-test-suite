#!/bin/sh
unzip -o byte-unixbench-6.0.0.zip
cd byte-unixbench-6.0.0/UnixBench

patch -p2 <<'EOL'
diff --git a/UnixBench/Makefile b/UnixBench/Makefile
index 3169c03..f0c4cf0 100644
--- a/UnixBench/Makefile
+++ b/UnixBench/Makefile
@@ -85,7 +85,7 @@ else
 
   ## gcc optimization flags
   ## (-ffast-math) disables strict IEEE or ISO rules/specifications for math funcs
-  OPTON = -O3 -ffast-math
+  OPTON = -O3 -ffast-math -std=c89
 
   ## OS detection.  Comment out if gmake syntax not supported by other 'make'. 
   OSNAME:=$(shell uname -s)
EOL

make clean
make
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
rm -f result
cd byte-unixbench-6.0.0/UnixBench
./Run -i 1 -c \$(nproc) \$1 > \$LOG_FILE" > byte
chmod +x byte

