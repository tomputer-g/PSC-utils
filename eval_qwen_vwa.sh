#!/bin/bash

# This shall be run on a H100-80 type node on PSC.
# Same machine hosts Qwen AND the evaluation code.
export OPENAI_BASE_URL=http://localhost:8000/v1
export EVAL_OPENAI_BASE_URL=https://ai-gateway.andrew.cmu.edu

echo "Sourcing conda environment..."

module load cuda



# Run VWA evaluation code
echo "Setting up VWA..."
conda activate vwa
cd /ocean/projects/cis260044p/shared/src/visualwebarena

echo "Install playwright..."
playwright install
bash prepare.sh

echo "Starting evaluation."
python run.py \
   --instruction_path agent/prompts/jsons/p_som_cot_id_actree_3s.json \
   --test_start_idx 0   --test_end_idx 1  \
   --result_dir ./results/  \
   --test_config_base_dir=config_files/vwa/test_classifieds  \
   --model Qwen/Qwen2.5-VL-3B-Instruct   \
   --action_set_tag som  --observation_type image_som \
   --provider openai --max_obs_length 15360 --mode chat
