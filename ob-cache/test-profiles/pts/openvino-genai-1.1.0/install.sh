#!/bin/bash
pip3 install --user openvino-genai==2025.1 openvino==2025.1 diffusers==0.33.1 transformers==4.52.3 optimum==1.25.3 optimum.intel==1.15.0 onnx==1.18.0
EXIT_STATUS=$?
if [ $EXIT_STATUS -ne 0 ]; then
	echo $EXIT_STATUS > ~/install-exit-status
	exit 2
fi
tar -xvf openvino.genai-2025.1.0.0.tar.gz
cd openvino.genai-2025.1.0.0/tools/llm_bench/
pip install --user optimum-intel@git+https://github.com/huggingface/optimum-intel.git
pip install --user -r requirements.txt
~/.local/bin/optimum-cli export openvino --trust-remote-code --model TinyLlama/TinyLlama-1.1B-Chat-v1.0 TinyLlama-1.1B-Chat-v1.0

cd ~
echo "#!/bin/bash
cd openvino.genai-2025.1.0.0/tools/llm_bench/
python3 ./benchmark.py \$@ > \$LOG_FILE
echo \$? > ~/test-exit-status" > openvino-genai
chmod +x openvino-genai
