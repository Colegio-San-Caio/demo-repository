#!/usr/bin/env bash
mkdir -p articles
mkdir -p "./.chat"
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EPOCH=$(date +%s)
CNT=$(ls articles/ | wc -l | tr -d ' ')

cat >candiOQM_xTitin.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>CANDI OQM xTitin $TS</title>
<style>body{background:#000;color:#0f0;font-family:monospace;padding:20px}a{color:#0ff}#engine{border:1px solid #0f0;padding:15px} #footer{margin-top:40px;border-top:1px solid #333;padding-top:10px;color:#888;font-size:12px} #minimum-box{margin-top:15px;border:1px dashed #0f0;background:#0a0a0a;padding:10px;color:#0f0;font-size:11px}</style></head><body>
<h1>CANDI OQM ∅ ⊂ ℱ0(t) ⊂...⊂ ℱ∞(t) — Julia_Menge_eigenOENEYE</h1>
<p>Build: $TS | Epoch: $EPOCH | $CNT articles</p>
<p><a href="candiOQM_clock.html?ts=$EPOCH">→ CLOCK</a> | <a href="index.html?ts=$EPOCH">→ INDEX</a></p>
<div id=engine>xTitin_(n+1)(t) = Ŵ(xTitin_n(t)) + A_𝔄<br>Loop: ONE AUTO active<br>Run: 37751083306<br>$TS</div>

<div id=footer>© 2026 Colegio-San-Caio / Julia_Menge_eigenOENEYE — xTitin(t) — All rights reserved — $TS</div>

<div id=minimum-box>
<b>MINIMUM BOX</b> — ABCD one auto<br>
INDEX $TS<br>
$CNT articles<br>
$EPOCH<br>
<pre style="margin:5px 0;color:#0ff">$(ls -1 articles/ | sort | tail -n 10)</pre>
<a href="index.html" style="color:#0ff">index</a> | $TS
</div>

</body></html>
HTML

cat >index.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><title>INDEX $TS</title><style>body{background:#000;color:#0f0;font-family:monospace;padding:20px}a{color:#0ff}</style></head><body><h1>INDEX - $TS - $CNT</h1><a href="candiOQM_xTitin.html?ts=$EPOCH">engine</a><pre>$(ls articles/|tail -n 30)</pre></body></html>
HTML

echo "full + minimum-box under copyright $TS"
