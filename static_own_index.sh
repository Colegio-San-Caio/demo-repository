#!/usr/bin/env bash
mkdir -p articles; mkdir -p "./.chat"
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ); EPOCH=$(date +%s)
cat >candiOQM_xTitin.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>CANDI OQM xTitin $TS</title><style>body{background:#000;color:#0f0;font-family:monospace;padding:20px}a{color:#0ff}#c{border:1px solid #0f0;padding:15px}</style></head><body><h1>CANDI OQM ∅ ⊂ ℱ0(t) ⊂...⊂ ℱ∞(t) — Julia_Menge_eigenOENEYE</h1><p>Build: $TS | $EPOCH | $(ls articles/|wc -l) arts</p><p><a href="candiOQM_clock.html">→ CLOCK</a> | <a href="index.html">→ INDEX</a></p><div id=c>xTitin_(n+1)(t) = Ŵ(xTitin_n(t)) + A_𝔄<br>Loop: ONE AUTO active — $TS</div><script>setInterval(()=>document.title=new Date().toISOString(),1000)</script></body></html>
HTML
cat >candiOQM_clock.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><title>CLOCK $TS</title><style>body{background:#000;color:#ff0;font-family:monospace;padding:40px;text-align:center}#t{font-size:52px}</style></head><body><h1>∅⊂ℱ CLOCK</h1><div id=t>--:--:--</div><p>$TS</p><a href="candiOQM_xTitin.html" style="color:#0ff">→ ENGINE</a><script>setInterval(()=>{document.getElementById('t').innerText=new Date().toISOString()},1000)</script></body></html>
HTML
cat >index.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><title>INDEX $TS</title><style>body{background:#000;color:#0f0;font-family:monospace;padding:20px}a{color:#0ff}</style></head><body><h1>INDEX - $TS - $(ls articles/|wc -l) articles - ONE AUTO</h1><p><a href="candiOQM_xTitin.html?ts=$EPOCH">!engine → candiOQM_xTitin.html</a> | <a href="candiOQM_clock.html">clock</a></p><pre>$(ls -1 articles/|sort|tail -n 25)</pre></body></html>
HTML
echo "full build $TS"
