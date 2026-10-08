#!/usr/bin/env bash
set -e
./static_own_index.sh
# append-only
if [ -f autoexec_append.sh ]; then ./autoexec_append.sh; fi
git add -A
git commit -m "global restore $TS - no deletions - Julia_Menge_eigenOENEYE $(date -u +%Y-%m-%dT%H:%M:%SZ)" || echo "nothing to commit"
git push
gh workflow run pages.yml || gh run view --web || true
