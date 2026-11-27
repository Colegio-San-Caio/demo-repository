import os, sys, getpass, requests

KEY_FILE = os.path.expanduser("~/.groq_key")

def get_api_key():
    if os.path.exists(KEY_FILE):
        with open(KEY_FILE) as f:
            key = f.read().strip()
        if key:
            return key
    
    key = getpass.getpass("Enter your Groq API key (hidden, will be saved): ").strip()
    if key:
        with open(KEY_FILE, "w") as f:
            f.write(key)
        try:
            os.chmod(KEY_FILE, 0o600)
        except:
            pass
        print("Key saved. You won't have to paste it again.\n")
    return key

key = get_api_key()

def ask_llama(q):
    global key
    try:
        r = requests.post(
            "https://api.groq.com/openai/v1/chat/completions",
            headers={"Authorization": f"Bearer {key}", "Content-Type": "application/json"},
            json={"model": "openai/gpt-oss-20b", "messages": [{"role": "user", "content": q}]},
            timeout=60
        )
        data = r.json()
        if "error" in data:
            err_msg = data["error"].get("message", str(data))
            print(f"\nAPI Error: {err_msg}")
            if data["error"].get("code") == "invalid_api_key":
                if os.path.exists(KEY_FILE):
                    os.remove(KEY_FILE)
                print("Invalid API key detected and cleared from cache. Please re-run with a valid key.")
        elif "choices" in data:
            print("\n" + data["choices"][0]["message"]["content"] + "\n")
        else:
            print("\n" + str(data) + "\n")
    except Exception as e:
        print("\nError:", e, "\n")

if len(sys.argv) > 1:
    ask_llama(" ".join(sys.argv[1:]))
else:
    print("Meta Llama CLI - type 'exit' to quit\n")
    while True:
        try:
            q = input("Ask Meta: ").strip()
        except (KeyboardInterrupt, EOFError):
            print("\nExiting.")
            break
        if q.lower() in ["exit", "quit"]:
            break
        if not q:
            continue
        ask_llama(q)
