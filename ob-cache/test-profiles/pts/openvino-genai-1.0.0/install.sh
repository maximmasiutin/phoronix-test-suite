#!/bin/bash
pip3 install --user openvino-genai==2024.5.0
EXIT_STATUS=$?
if [ $EXIT_STATUS -ne 0 ]; then
	echo $EXIT_STATUS > ~/install-exit-status
	exit 2
fi
pip install --user optimum-intel@git+https://github.com/huggingface/optimum-intel.git
tar -xvf openvino.genai-2024.5.0.0.tar.gz
cd openvino.genai-2024.5.0.0/samples/python/benchmark_genai
~/.local/bin/optimum-cli export openvino --trust-remote-code --model TinyLlama/TinyLlama-1.1B-Chat-v1.0 TinyLlama-1.1B-Chat-v1.0

git clone https://huggingface.co/OpenVINO/Phi-3-mini-128k-instruct-int4-ov
cd Phi-3-mini-128k-instruct-int4-ov/
git checkout 2c058a40dd71ad888e28ef977fcaed30fa6cf3ed
cd ..
git clone https://huggingface.co/OpenVINO/falcon-7b-instruct-int4-ov
cd falcon-7b-instruct-int4-ov
git checkout 228bfd08da0c6ea3ea738de6db8b299c49ebc1cd
cd ..
git clone https://huggingface.co/OpenVINO/gemma-7b-int4-ov
cd gemma-7b-int4-ov
git checkout 98ecbcaea78a16ec2515107ce7985428fb59088d

cd ~
echo "#!/bin/bash
cd openvino.genai-2024.5.0.0/samples/python/benchmark_genai
python3 benchmark_genai.py \$@ > \$LOG_FILE
echo \$? > ~/test-exit-status" > openvino-genai
chmod +x openvino-genai
