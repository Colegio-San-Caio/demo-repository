#!/bin/bash
# oeneyeOS Auto-Response Handler (AH) with HTTPX and Auto flags
# Usage: ./ah_engine.sh <trigger> [-httpx <url>] [-auto _auto]

INPUT_TRIGGER="$1"
FLAG_TWO="$2"
VAL_TWO="$3"
FLAG_THREE="$4"
VAL_THREE="$5"
RULE_DIR="suomidb/rules"

mkdir -p "$RULE_DIR"

echo "[*] Processing trigger: '$INPUT_TRIGGER'"

# Parse arguments for -httpx and -auto flags
TARGET_URL=""
AUTO_MODE=0

if [ "$FLAG_TWO" = "-httpx" ]; then
    TARGET_URL="$VAL_TWO"
elif [ "$FLAG_THREE" = "-httpx" ]; then
    TARGET_URL="$VAL_THREE"
fi

if [ "$FLAG_TWO" = "-auto" ] && [ "$VAL_TWO" = "_auto" ]; then
    AUTO_MODE=1
elif [ "$FLAG_THREE" = "-auto" ] && [ "$VAL_THREE" = "_auto" ]; then
    AUTO_MODE=1
fi

# Handle fetch if URL provided
if [ -n "$TARGET_URL" ]; then
    echo "[*] Querying target via HTTPS: $TARGET_URL"
    if [ "$AUTO_MODE" -eq 1 ]; then
        echo "[*] Auto-mode (_auto) enabled: processing payload stream..."
    fi
    
    FETCHED_CONTENT=$(curl -sL "$TARGET_URL")
    if [ $? -eq 0 ]; then
        echo "[+] Successfully fetched content."
        echo "--- Content Preview ---"
        echo "$FETCHED_CONTENT" | head -n 8
        echo "-----------------------"
    else
        echo "[-] Failed to retrieve content from $TARGET_URL"
    fi
    exit 0
fi

# Fallback to standard rule lookup
RESPONDED=0
for rule in "$RULE_DIR"/*.cfg; do
    if [ -f "$rule" ]; then
        source "$rule"
        if [ "$INPUT_TRIGGER" = "$TRIGGER" ]; then
            echo "[+] Match found! Auto-response: $RESPONSE"
            RESPONDED=1
            break
        fi
    fi
done

if [ "$RESPONDED" -eq 0 ]; then
    echo "[-] No matching rule found for '$INPUT_TRIGGER'."
fi
