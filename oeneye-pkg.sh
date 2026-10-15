#!/bin/bash
# oeneye-pkg.sh - list packages, recent changes, verify checksums
cd "$(dirname "$0")" || exit 1
PATTERNS='\.(deb|zip|img|bin|tar\.gz)$'
SITE="https://colegio-san-caio.github.io/demo-repository"
case "$1" in
  list)
    git ls-files | grep -E "$PATTERNS" | while read -r f; do
      printf '%s  %8s  %s\n' "$(sha256sum "$f" | cut -c1-12)" "$(stat -c %s "$f")" "$f"
    done ;;
  verify)
    sha256sum -c assets/checksum.sha256
    live=$(curl -s "$SITE/oeneyeOS.img?x=$(date +%s)" | sha256sum | cut -d' ' -f1)
    here=$(sha256sum oeneyeOS.img | cut -d' ' -f1)
    if [ "$live" = "$here" ]; then echo "live oeneyeOS.img: OK"; else echo "live oeneyeOS.img: MISMATCH (Pages may still be deploying)"; fi ;;
  ""|changes)
    H="${2:-24}"
    out=$(git log --since="$H hours ago" --name-status --format= | grep -E "$PATTERNS" | sort -u)
    if [ -z "$out" ]; then echo "No package changes in the last $H hours."; else echo "$out"; fi ;;
  *)
    echo "usage: $0 [changes [hours] | list | verify]" ;;
esac
