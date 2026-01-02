#!/bin/sh
unzip -o stockfish-171-windows-x86-64-avx2.zip
mv stockfish stockfish_171_win_x64_avx2
echo "#!/bin/sh
cd stockfish_171_win_x64_avx2
./stockfish-windows-x86-64-avx2.exe speedtest > \$LOG_FILE 2>&1" > stockfish
chmod +x stockfish

