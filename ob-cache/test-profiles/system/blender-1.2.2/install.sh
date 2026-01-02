#!/bin/bash
if which blender>/dev/null 2>&1 ;
then
	echo 0 > ~/install-exit-status
else
	echo "ERROR: Blender is not found on the system! This test profile needs a working blender installation in the PATH."
	echo 2 > ~/install-exit-status
fi
unzip -o cycles_benchmark_20160228.zip
echo "#!/bin/bash
BLEND_ARGS=\$@
if [[ \$@ =~ .*CPU.* ]]
then
	BLEND_ARGS=\${BLEND_ARGS/_gpu/_cpu}
fi
blender \$BLEND_ARGS > \$LOG_FILE 2> /dev/null
echo \$? > ~/test-exit-status
blender --version | cut -d \" \" -f 2 > ~/pts-test-version 2>/dev/null 
rm -f output.test" > blender
chmod +x blender
