#!/bin/bash
# oeneyeOS Auto-Response Handler (AH)
# Usage: ./ah_engine.sh "incoming_trigger"

INPUT_TRIGGER="$1"
RULE_DIR="suomidb/rules"

mkdir -p "$RULE_DIR"

# Default rule if none exists
if [ ! -f "$RULE_DIR/default.cfg" ]; then
    echo "TRIGGER=ping" > "$RULE_DIR/default.cfg"
    echo "RESPONSE=pong" >> "$RULE_DIR/default.cfg"
fi

echo "[*] Processing trigger: '$INPUT_TRIGGER'"

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
