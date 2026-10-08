#!/usr/bin/env bash
set -e
EPOCH=$(date +%s)
mkdir -p articles
N=$(ls articles/ | wc -l | tr -d ' ')
F="articles/Julia_Menge_eigenOENEYE_$(printf "%03d" $((N+1)))_xTitin_${EPOCH}.md"
echo "# xTitin(t) $(date -u +%Y-%m-%dT%H:%M:%SZ) Epoch $EPOCH LOOP by Julia" > "$F"
echo "appended $F"
