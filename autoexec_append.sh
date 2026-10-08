#!/usr/bin/env bash
set -e
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EPOCH=$(date +%s)
mkdir -p articles
N=$(ls articles/ | wc -l | tr -d ' ')
FILE="articles/Julia_Menge_eigenOENEYE_$(printf "%03d" $((N+1)))_xTitin_${EPOCH}.md"
printf "# xTitin(t) %s\nEpoch: %s\nxTitin_(n+1)(t)=W(xTitin_n)+A_A\nEmpty subset F0(t) to Finf(t)\nLOOP active by Julia_Menge_eigenOENEYE\n" "$TS" "$EPOCH" > "$FILE"
echo "appended $FILE"
