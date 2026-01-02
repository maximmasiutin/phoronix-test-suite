#!/bin/sh
unzip -o unvanquished_0.55.5.zip
cd unvanquished_0.55.5
if [ $OS_ARCH = "aarch64" ]
then
	unzip -o linux-arm64.zip
else
	unzip -o linux-amd64.zip
fi
chmod +x daemon
cd ~
xz -d -k unvanquished-benchmark_0.55.5.dm_86.xz
mkdir -p ~/.local/share/unvanquished/demos
mkdir -p ~/.local/share/unvanquished/config
mv unvanquished-benchmark_0.55.5.dm_86 ~/.local/share/unvanquished/demos
echo "#!/bin/sh
cd unvanquished_0.55.5
./daemon \$@ > \$LOG_FILE 2>&1" > unvanquished
chmod +x unvanquished
