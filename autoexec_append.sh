#!/usr/bin/env bash
set -e
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EPOCH=$(date +%s)
mkdir -p articles
FILE="articles/Julia_Menge_eigenOENEYE_$(printf "%03d" $(ls articles/ | wc -l | tr -d ' '))_xTitin_${EPOCH}.md"
cat > "$FILE" <<MD3
# xTitin(t) auto-append by Julia_Menge_eigenOENEYE
Timestamp: $TS
Epoch: $EPOCH
xTitin_(n+1)(t) = Ŵ(xTitin_n(t)) + A_𝔄
∅ ⊂ ℱ0(t) ⊂ ... ⊂ ℱ∞(t)
TRIT = $((EPOCH % 3 - 1))
MD3
echo "APPENDED $FILE at $TS"
./static_own_index.sh
