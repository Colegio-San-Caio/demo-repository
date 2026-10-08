#!/usr/bin/env bash
while true; do
  clear
  echo "=== $(date -u +%Y-%m-%dT%H:%M:%SZ) ==="
  gh run list --workflow="pages.yml" -L 5
  echo ""
  echo "--- in_progress / queued ---"
  gh run list --workflow="pages.yml" --status in_progress -L 5 2>/dev/null
  gh run list --workflow="pages.yml" --status queued -L 5 2>/dev/null
  ID=$(gh run list --workflow="pages.yml" -L 1 --json databaseId -q '.[0].databaseId' 2>/dev/null)
  if [ -n "$ID" ]; then
    echo ""
    echo "--- VIEW $ID ---"
    gh run view $ID --exit-status 2>&1 | head -n 40
  fi
  echo ""
  echo "sleep 5 - Ctrl+C to stop"
  sleep 5
done
