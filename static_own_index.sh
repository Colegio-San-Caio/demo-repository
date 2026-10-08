#!/usr/bin/env bash
set -e
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EPOCH=$(date +%s)
mkdir -p articles images
# auto-stamp existing engines if they exist (replace placeholder)
sed -i "s/deployed .*/deployed $TS<br>/" candiOQM_xTitin.html 2>/dev/null || true
sed -i "s/deployed .*/deployed $TS<br>/" candiOQM_clock.html 2>/dev/null || true
cat > index.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>CANDI OQM xTitin $TS</title></head><body style="font-family:monospace;background:#000;color:#0f0;padding:20px">
<h1>CANDI OQM ∅⊂ℱ∞ xTitin by Julia_Menge_eigenOENEYE</h1>
<p style="color:#ff0">Last deploy: $TS | epoch $EPOCH | xTitin(t)</p>
<p><a href="candiOQM_xTitin.html?ts=$EPOCH" style="color:#0ff">→ !engine 4716b t=$TS</a> | <a href="candiOQM_clock.html?ts=$EPOCH" style="color:#ff0">→ CLOCK t=$TS</a></p>
<h3>Articles persistent [xTitin(t) = $TS]:</h3><ul>
<li><a href="articles/Julia_Menge_eigenOENEYE_001_Main.md">001 Main ∅⊂ℱ∞</a></li>
<li><a href="articles/Julia_Menge_eigenOENEYE_002_Formal_Filtration.md">002 Formal xTitin=Ŵ+A</a></li>
<li><a href="articles/Julia_Menge_eigenOENEYE_003_Finite_vs_Infinite.md">003 Finite vs Infinite</a></li>
<li><a href="articles/Julia_Menge_eigenOENEYE_004_Operator_A-Void.md">004 Ŵ + A_Void</a></li>
<li><a href="articles/Julia_Menge_eigenOENEYE_005_Deploy_IMCs.md">005 Deploy IMCs proof</a></li>
<li><a href="articles/">006 xTitin_Timestamp_$EPOCH.md - t=$TS</a> ← latest</li>
</ul>
<p>Images: <a href="images/">/images/</a></p>
<p style="font-size:11px">$TS | articles $(ls articles/|wc -l) | images $(ls images/|wc -l)</p></body></html>
HTML
echo "PERSISTENT BUILD $TS epoch $EPOCH - xTitin(t) stamped"
