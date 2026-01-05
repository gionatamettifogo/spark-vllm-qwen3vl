#!/bin/bash
# Entrypoint script for Qwen3-VL vLLM server

set -e

# Install Qwen-VL utils if not present (required for some Qwen models)
if ! python3 -c "import qwen_vl_utils" 2>/dev/null; then
    echo "Installing qwen-vl-utils..."
    pip install --no-cache-dir qwen-vl-utils
fi

# Build the command with required arguments
CMD="vllm serve \"${MODEL}\" \
    --dtype auto \
    --port ${PORT} \
    --host 0.0.0.0 \
    --enforce-eager \
    --trust-remote-code \
    --max-model-len ${MAX_MODEL_LEN:-32768} \
    --gpu-memory-utilization ${GPU_MEMORY_UTILIZATION}"

# Add reasoning parser for Thinking models
if [[ "${MODEL}" == *"Thinking"* ]]; then
    # Use deepseek_r1 parser as it handles implicit opening <think> tags better than the qwen3 parser
    CMD="${CMD} --enable-reasoning --reasoning-parser deepseek_r1"
fi

# Add API key if provided
if [ -n "${VLLM_API_KEY}" ]; then
    CMD="${CMD} --api-key ${VLLM_API_KEY}"
fi

# Execute the command
echo "Starting vLLM server..."
echo "Model: ${MODEL}"
echo "Port: ${PORT}"
echo "GPU Memory Utilization: ${GPU_MEMORY_UTILIZATION}"
if [ -n "${VLLM_API_KEY}" ]; then
    echo "API Key: [configured]"
else
    echo "API Key: [not configured]"
fi

exec bash -c "${CMD}"
