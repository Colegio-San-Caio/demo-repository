#!/usr/bin/env bash
set -e
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EPOCH=$(date +%s)
mkdir -p articles images
cat > index.html <<HTML2
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>CANDI OQM xTitin $TS</title></head><body style="font-family:monospace;background:#000;color:#0f0;padding:20px">
<h1>CANDI OQM ∅⊂ℱ∞ xTitin by Julia_Menge_eigenOENEYE</h1>
<p style="color:#ff0">Last deploy: $TS | epoch $EPOCH | xTitin(t) = Ŵ(xTitin_n(t))+A_𝔄</p>
<p><a href="candiOQM_xTitin.html?ts=$EPOCH" style="color:#0ff">→ !engine 4716b t=$TS</a> | <a href="candiOQM_clock.html?ts=$EPOCH" style="color:#ff0">→ CLOCK t=$TS</a></p>
<h3>Articles persistent [GLOBAL ALL CODES $TS]:</h3><ul>
<li>001 Main ∅⊂ℱ∞ - Topological Filtration</li>
<li>002 Formal xTitin=Ŵ+A_𝔄</li>
<li>003 Finite vs Infinite</li>
<li>004 Operator Ŵ+A_Void trit [-1,0,1]</li>
<li>005 Deploy IMCs proof 37745973673/37746282151/37747069024</li>
<li>006 xTitin_Timestamp_${EPOCH}</li>
<li>007 xTitin_1791446495</li>
</ul>
<p>Articles on disk:</p><pre>$(ls -1 articles/ | sed 's/^/ - /')</pre>
<p>Images: <a href="images/">/images/</a> - $(ls images/ 2>/dev/null | wc -l) files</p>
<p style="font-size:11px">$TS | persistent build | never deletes</p></body></html>
HTML2
echo "PERSISTENT BUILD $TS epoch $EPOCH - $(ls articles/ | wc -l) articles kept"
