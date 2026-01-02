#!/bin/bash
chmod +x localscore-0.9.3
echo $? > ~/install-exit-status
echo "#!/bin/bash
if [[ \"\$@\" == *\"--gpu auto\"* ]]; then
	LISTED_GPUS=\`NO_COLOR=1 ./localscore-0.9.3  --list-gpus 2>&1\`
	if [[ \"\$LISTED_GPUS\" == *\"No Accelerator support\"* ]]; then
	  echo \"ERROR: No GPU/accelerator support found\"
	  echo 2 > ~/test-exit-status
	  exit
	fi
fi
NO_COLOR=1 ./localscore-0.9.3 --plaintext --no-send-results \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ~/localscore
chmod +x ~/localscore
