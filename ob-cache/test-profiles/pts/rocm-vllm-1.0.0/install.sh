#!/bin/bash
rm -rf workspace/vllm-sources
tar -xf vllm-0.10.0.tar.gz
mkdir workspace
mv vllm-0.10.0 workspace/vllm-sources
docker pull hyoon11/vllm-dev:20250715_6.4_120_py3.12_torch2.7_triton3.3_navi_upstream_a5dd03c_ubuntu24.04
echo $? > ~/install-exit-status
echo "#!/bin/bash
NUM_GPUS=\`amd-smi list -e | grep HIP_UUID | wc -l\`
EXTRA_ARGS=\"\"
if ! [ \"\$NUM_GPUS\" -eq \"\$NUM_GPUS\" ] 2> /dev/null
then
    echo \"NUM_GPUS is not a number: \$NUM_GPUS\"
else
    EXTRA_ARGS=\"\$EXTRA_ARGS --tensor-parallel-size=\$NUM_GPUS\"
fi
BENCH_ARGS=\"\$@\"
docker run -i --network=host --group-add=video --ipc=host --device /dev/kfd --device /dev/dri --shm-size 10G --security-opt seccomp=unconfined --security-opt apparmor=unconfined --cap-add=SYS_PTRACE -v \$HOME/workspace:/workspace --env HUGGINGFACE_HUB_CACHE=/workspace --env HUGGING_FACE_HUB_TOKEN=\"\$HUGGING_FACE_HUB_TOKEN\" hyoon11/vllm-dev:20250715_6.4_120_py3.12_torch2.7_triton3.3_navi_upstream_a5dd03c_ubuntu24.04 /bin/bash -c \"cd /workspace && echo \"\"vllm bench \$BENCH_ARGS \$EXTRA_ARGS\"\" && vllm bench \$BENCH_ARGS \$EXTRA_ARGS\" > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ~/rocm-vllm
chmod +x ~/rocm-vllm
