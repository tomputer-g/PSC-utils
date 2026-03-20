# Setting up a conda environment for SGLang inference

On a Bridges2 Login node:

```bash
# Load the Anaconda module
module load anaconda3

# Create and activate a fresh environment
conda create -n sglang_env python=3.10 -y
conda activate sglang_env

# Install SGLang and the OpenAI client
pip install --upgrade pip
pip install "sglang[all]" openai

pip install -U --pre triton
pip install nvidia-cudnn-cu12==9.16.0.29
```

# Interactive mode

Request either a H100 or a L40S node. Using a V100 node has a sm version that is too low for SGLang to function.

1. Get a node. Modify the time according to usage:
```bash
interact -p GPU-shared --gres=gpu:l40s-48:1 -t 02:00:00
# or use H100, which is more widely available on PSC:
interact -p GPU-shared --gres=gpu:h100-80:1 -t 02:00:00
```

2. Note down the node name (for example, `w008`).

3. Host the model:

```bash
module load anaconda3
module load cuda
conda activate sglang_env

python -m sglang.launch_server \
    --model-path Qwen/Qwen2.5-VL-7B-Instruct \
    --chat-template qwen2-vl \
    --port 8000 \
    --host 0.0.0.0 \
    --mem-fraction-static 0.7 \
    --context-length 8192 \
    --max-running-requests 10
```

4. Test out the model

```bash
python test_prompt.py w008
# Substitute node name above from step 2
```

If this generates a response to the question "Explain hierarchical reinforcement learning in one sentence.", you are good to go.
