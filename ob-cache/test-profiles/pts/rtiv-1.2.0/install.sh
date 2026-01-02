#!/bin/sh
rm -rf RayTracingInVulkan-r8
tar -xf RayTracingInVulkan-r8.tar.gz
tar -xf vulkansdk-linux-x86_64-1.4.313.0.tar.xz
cd 1.4.313.0/
source setup-env.sh 
sed -i 's/python /python3 /g' vulkansdk
pip3 install --user jsonschema
./vulkansdk --skip-installing-deps --maxjobs
mkdir ~/RayTracingInVulkan-r8/src/vulkan
mkdir ~/RayTracingInVulkan-r8/src/Vulkan/vulkan
cp -va x86_64/include/vulkan/*.h ~/RayTracingInVulkan-r8/src/vulkan
cp -va x86_64/include/vulkan/*.h ~/RayTracingInVulkan-r8/src/Vulkan/vulkan
cd ~/RayTracingInVulkan-r8/
./vcpkg_linux.sh
./build_linux.sh
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd RayTracingInVulkan-r8/build/linux/bin/
./RayTracer \$@ > \$LOG_FILE" > rtiv
chmod +x rtiv
