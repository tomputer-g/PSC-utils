import sys
from openai import OpenAI

# 1. Check if the node name was provided
if len(sys.argv) < 2:
    print("Error: Missing node name.")
    print("Usage: python test_prompt.py <node_name>")
    print("Example: python test_prompt.py w008")
    sys.exit(1)

# 2. Grab the node name from the first command-line argument
node_name = sys.argv[1]

# 3. Dynamically build the URL
api_url = f"http://{node_name}:8000/v1"
print(f"Connecting to SGLang server at: {api_url}...\n")

# 4. Initialize the client with the dynamic URL
client = OpenAI(
    base_url=api_url,
    api_key="EMPTY"
)

# 5. Send the prompt
response = client.chat.completions.create(
    model="Qwen/Qwen2.5-7B-Instruct",
    messages=[
        {"role": "system", "content": "You are a helpful AI assistant."},
        {"role": "user", "content": "What are the primary scaling challenges in multi-agent path finding algorithms?"}
    ],
    max_tokens=256
)

print(response.choices[0].message.content)
