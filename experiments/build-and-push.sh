#!/bin/bash
# Build and push the Docker image

IMAGE_NAME="gionata/spark-vllm-qwen3vl"
TAG="${1:-latest}"

echo "Building Docker image: ${IMAGE_NAME}:${TAG}"
docker build -f Dockerfile.spark-vllm-qwen3vl -t ${IMAGE_NAME}:${TAG} .

echo ""
echo "Pushing to Docker Hub..."
docker push ${IMAGE_NAME}:${TAG}

echo ""
echo "Done! Image available at: ${IMAGE_NAME}:${TAG}"
echo ""
echo "Usage examples:"
echo ""
echo "  # Run with default settings (Qwen3-VL-30B on port 8001)"
echo "  docker run --rm -it --gpus all --ipc=host -p 8001:8001 \\"
echo "      -v ~/.cache/huggingface:/root/.cache/huggingface \\"
echo "      ${IMAGE_NAME}:${TAG}"
echo ""
echo "  # Run with API key"
echo "  docker run --rm -it --gpus all --ipc=host -p 8001:8001 \\"
echo "      -e VLLM_API_KEY=your-secret-key \\"
echo "      -v ~/.cache/huggingface:/root/.cache/huggingface \\"
echo "      ${IMAGE_NAME}:${TAG}"
echo ""
echo "  # Run with different model and port"
echo "  docker run --rm -it --gpus all --ipc=host -p 8080:8080 \\"
echo "      -e MODEL=Qwen/Qwen2.5-VL-7B-Instruct \\"
echo "      -e PORT=8080 \\"
echo "      -v ~/.cache/huggingface:/root/.cache/huggingface \\"
echo "      ${IMAGE_NAME}:${TAG}"
