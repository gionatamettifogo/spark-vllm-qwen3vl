# Usage:
#   export LLM_API_KEY=xxx
#   export EMBED_API_KEY=xxx
#   ./quick-test.sh

curl -s http://localhost:8001/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer very-secret-key-to-be-replaced" \
  -d '{
    "model":"Qwen/Qwen3-VL-30B-A3B-Instruct-FP8",
    "messages":[{"role":"user","content":"What is the difference between serotonin and melatonin?"}],
    "max_tokens":600
  }'

echo -e "\n\nTesting Vision Capabilities..."
curl -s http://localhost:8001/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer very-secret-key-to-be-replaced" \
  -d '{
    "model": "Qwen/Qwen3-VL-30B-A3B-Instruct-FP8",
    "messages": [
      {
        "role": "user",
        "content": [
          {
            "type": "text",
            "text": "What is in this image?"
          },
          {
            "type": "image_url",
            "image_url": {
              "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg"
            }
          }
        ]
      }
    ],
    "max_tokens": 300
  }'



# test embedding model
curl -s http://localhost:8002/v1/embeddings \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer very-secret-key-to-be-replaced" \
  -d '{
    "model": "Qwen/Qwen3-Embedding-0.6B",
    "input": [
      "hello world",
      "ciao mondo"
    ]
  }'
