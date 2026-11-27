#!/usr/bin/env python3
"""perplexity_cli.py - Perplexity AI CLI client for MOSFETQ OQM / RED workspace."""
import os
import sys
import getpass
import requests

KEY_FILE = os.path.expanduser("~/.perplexity_key")

def get_api_key():
    if os.path.exists(KEY_FILE):
        with open(KEY_FILE) as f:
            key = f.read().strip()
        if key:
            return key
    
    key = getpass.getpass("Enter your Perplexity API key (hidden, will be saved): ").strip()
    if key:
        with open(KEY_FILE, "w") as f:
            f.write(key)
        try:
            os.chmod(KEY_FILE, 0o600)
        except:
            pass
        print("Key saved securely.\n")
    return key

def ask_perplexity(prompt):
    key = get_api_key()
    if not key:
        print("Error: No Perplexity API key provided.")
        return
    
    try:
        r = requests.post(
            "https://api.perplexity.ai/chat/completions",
            headers={
                "Authorization": f"Bearer {key}",
                "Content-Type": "application/json"
            },
            json={
                "model": "sonar",
                "messages": [
                    {"role": "system", "content": "Be precise, concise, and helpful."},
                    {"role": "user", "content": prompt}
                ]
            },
            timeout=60
        )
        data = r.json()
        if "error" in data:
            print(f"\nAPI Error: {data['error']}\n")
        elif "choices" in data:
            content = data["choices"][0]["message"]["content"]
            print(f"\nPerplexity Response:\n{content}\n")
        else:
            print(f"\n{data}\n")
    except Exception as e:
        print(f"\nError: {e}\n")

if __name__ == "__main__":
    query = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else input("Perplexity Query: ")
    if query.strip():
        ask_perplexity(query)
