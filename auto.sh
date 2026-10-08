#!/usr/bin/env bash
set -e
mkdir -p articles
mkdir -p.chat

while true; do
  TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  EPOCH=$(date +%s)
  echo "$TS | $EPOCH | one-auto chat" >>.chat/history.log

  # 1. auto find new codes
  N=$(ls articles/ 2>/dev/null | wc -l | tr -d ' ')
  F="articles/Julia_Menge_eigenOENEYE_$(printf "%03d" $((N+1)))_xTitin_${EPOCH}.md"
  echo "# xTitin(t) $TS Epoch $EPOCH - one auto" > "$F"
  echo "[auto] $F"

  # 2. rebuild original pages - candiOQM_xTitin.html + clock + index
 ./static_own_index.sh 2>/dev/null || true

  # 3. push
  git add -A
  git commit -m "one-auto $TS - $(ls articles/ | wc -l) arts" || true
  git push 2>&1 | tail -n 5

  # 4. trigger pages.yml
  gh workflow run pages.yml 2>/dev/null || true
  sleep 5

  # 5. VIEW LOOP in_progress - this was gone
  clear
  echo "=== ONE AUTO $TS | $(ls articles/ | wc -l) articles ==="
  gh run list --workflow="pages.yml" -L 5
  echo ""
  echo "-- in_progress --"
  gh run list --workflow="pages.yml" --status in_progress -L 3 2>/dev/null || true
  echo "-- queued --"
  gh run list --workflow="pages.yml" --status queued -L 3 2>/dev/null || true
  ID=$(gh run list --workflow="pages.yml" -L 1 --json databaseId -q '.[0].databaseId' 2>/dev/null || echo "")
  if [ -n "$ID" ]; then
    echo ""
    echo ">> gh run view $ID"
    gh run view $ID 2>&1 | tail -n 50
  fi

  echo ""
  echo "sleep 15 - Ctrl+C to stop one-auto"
  sleep 15
done
