#!/bin/bash
# oeneye-pkg.sh - list packages and recent changes
cd "$(dirname "$0")" || exit 1
PATTERNS='\.(deb|zip|img|bin|tar\.gz)$'
case "$1" in
  list)
    git ls-files | grep -E "$PATTERNS" | while read -r f; do
      printf '%s  %8s  %s\n' "$(sha256sum "$f" | cut -c1-12)" "$(stat -c %s "$f")" "$f"
    done ;;
  ""|changes)
    H="${2:-24}"
    out=$(git log --since="$H hours ago" --name-status --format= | grep -E "$PATTERNS" | sort -u)
    if [ -z "$out" ]; then echo "No package changes in the last $H hours."; else echo "$out"; fi ;;
  *)
    echo "usage: $0 [changes [hours] | list]" ;;
esac
