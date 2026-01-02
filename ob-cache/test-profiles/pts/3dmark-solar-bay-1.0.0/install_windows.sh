#!/bin/sh
unzip -o 3dmark-pogo_extreme-1.0.3.4-workload-bin.zip
chmod +x bin/windows/x64/workload.exe
echo "#!/bin/sh
echo \"{
    \\\"workload_name\\\": \\\"SolarBayXGt1P\\\",
    \\\"rendering_resolution\\\": [\$1, \$2],
    \\\"asset_root\\\": \\\"assets_desktop\\\",
    \\\"config\\\": \\\"configs/inline.json\\\",
    \\\"backend\\\": \\\"vulkan\\\",
    \\\"fullscreen\\\": true,
    \\\"vsync\\\": false,
    \\\"loop\\\": false,
    \\\"loop_count\\\": 0
}\" > settings/pts.json
rm -f result.json
./bin/windows/x64/workload.exe --in=settings/pts.json --out=result.json
echo \$? > ~/test-exit-status
cat result.json > \$LOG_FILE" > 3dmark-solar-bay
chmod +x 3dmark-solar-bay
