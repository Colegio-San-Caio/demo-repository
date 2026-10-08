#!/usr/bin/env bash
mkdir -p articles
mkdir -p "./.chat"
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EPOCH=$(date +%s)
echo "build $TS"
cat >candiOQM_xTitin.html <<HTML
<!doctype html><html><body><h1>CANDI OQM $TS</h1><p>$EPOCH</p><a href="index.html">index</a></body></html>
HTML
cat >index.html <<HTML
<!doctype html><html><body><h1>INDEX $TS</h1><p>$(ls articles/ | wc -l) articles</p></body></html>
HTML
