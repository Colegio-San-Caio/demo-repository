#!/usr/bin/env bash
set -e
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EPOCH=$(date +%s)
mkdir -p articles images

# --- ORIGINAL PAGE candiOQM_xTitin.html ---
cat >candiOQM_xTitin.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>CANDI OQM xTitin $TS</title>
<style>body{background:#000;color:#0f0;font-family:monospace;padding:20px} a{color:#0ff} #c{border:1px solid #0f0;padding:10px;margin-top:20px}</style>
</head><body>
<h1>CANDI OQM ∅ ⊂ ℱ0(t) ⊂... ⊂ ℱ∞(t) — Julia_Menge_eigenOENEYE</h1>
<p>Last build: $TS | $EPOCH | <span id="art">$(ls articles/ | wc -l)</span> articles</p>
<p><a href="candiOQM_clock.html">→ CLOCK</a> | <a href="index.html">→ INDEX</a></p>
<div id="c">xTitin_(n+1)(t) = Ŵ(xTitin_n(t)) + A_𝔄<br>Loop: xTitin(t) auto-job active<br>Timestamp: $TS</div>
<script>const u=new URLSearchParams(location.search);document.body.innerHTML+= "<br>ts="+ (u.get('ts')||"$EPOCH");</script>
</body></html>
HTML

# --- ORIGINAL PAGE candiOQM_clock.html ---
cat >candiOQM_clock.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>CLOCK $TS</title>
<style>body{background:#000;color:#ff0;font-family:monospace;padding:40px;text-align:center} #t{font-size:48px}</style>
</head><body>
<h1>∅⊂ℱ CLOCK — Julia_Menge_eigenOENEYE</h1><div id="t">--:--:--</div><p>$TS</p><p><a href="candiOQM_xTitin.html" style="color:#0ff">→ ENGINE</a></p>
<script>setInterval(()=>{document.getElementById('t').innerText=new Date().toISOString()},1000)</script>
</body></html>
HTML

# --- index.html ---
cat >index.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><title>INDEX $TS</title></head><body style="background:#000;color:#0f0;font-family:monospace;padding:20px">
<h1>INDEX - $TS - $(ls articles/ | wc -l) articles</h1>
<p><a href="candiOQM_xTitin.html?ts=$EPOCH" style="color:#0ff">!engine 4716b → candiOQM_xTitin.html</a></p>
<p><a href="candiOQM_clock.html?ts=$EPOCH" style="color:#ff0">→ clock</a></p>
<pre>$(ls -1 articles/ | sort | tail -n 20)</pre>
</body></html>
HTML
echo "PERSISTENT BUILD $TS - original pages restored"
