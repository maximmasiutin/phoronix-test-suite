#!/bin/bash
tar xf Stockfish-sf_17.1.tar.gz
cd Stockfish-sf_17.1/src/
if [ $OS_TYPE = "BSD" ]
then
	gmake -j profile-build 
else
	make -j profile-build 

fi
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd Stockfish-sf_17.1/src/
./stockfish speedtest > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > stockfish
chmod +x stockfish

