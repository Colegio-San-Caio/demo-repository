#!/usr/bin/env bash
set -e
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EPOCH=$(date +%s)
mkdir -p articles

# APPEND new xTitin timestamp file, never delete old
FILE="articles/Julia_Menge_eigenOENEYE_$(printf "%03d" $(ls articles/ | wc -l))_xTitin_${EPOCH}.md"
cat > "$FILE" <<MD
# xTitin(t) auto-append by Julia_Menge_eigenOENEYE
Timestamp: $TS
Epoch: $EPOCH
xTitin_(n+1)(t) = Ŵ(xTitin_n(t)) + A_𝔄
∅ ⊂ ℱ0(t) ⊂ ℱ1(t) ⊂ ... ⊂ ℱ∞(t)
t = $TS

Deployed: $TS via autoexec_append
TRIT = $((EPOCH % 3 - 1))
Build: $EPOCH
MD

echo "APPENDED $FILE at $TS"

# update index - append-only
./static_own_index.sh
