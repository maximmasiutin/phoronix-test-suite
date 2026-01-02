#!/bin/sh
unzip -o SuperTuxKart-1.5-win.zip
echo "#!/bin/sh
cd SuperTuxKart-1.5-win/stk-code/build-x86_64/bin/

supertuxkart.exe %* 2>&1
copy /Y \"%APPDATA%\supertuxkart\config-0.10\stdout.log\" ..\stdout.log
cd ~
" > supertuxkart.bat
chmod +x supertuxkart.bat
echo "#!/bin/sh

supertuxkart.bat \$@
mv stdout.log \$LOG_FILE
" > supertuxkart
chmod +x supertuxkart
