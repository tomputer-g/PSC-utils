#!/bin/bash

# This shall be run on a H100-80 type node on PSC.
# Same machine hosts Qwen AND the evaluation code.
export OPENAI_BASE_URL=http://localhost:8000/v1
export EVAL_OPENAI_BASE_URL=https://ai-gateway.andrew.cmu.edu


echo "Setting up SGLANG and hosting QwenV2.5..."
module load cuda
conda activate sglang_env

python -m sglang.launch_server \
    --model-path Qwen/Qwen2.5-VL-7B-Instruct \
    --port 8000 \
    --host 0.0.0.0 \
    --mem-fraction-static 0.7 \
    --context-length 40000 \
    --max-running-requests 10 \

