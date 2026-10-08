#!/usr/bin/env bash
set -e
DATE=$(date -u +%Y-%m-%dT%H:%M:%SZ)
cat > index.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>CANDI OQM xTitin - Julia_Menge_eigenOENEYE</title></head><body style="font-family:monospace;background:#000;color:#0f0;padding:20px">
<h1>CANDI OQM ∅⊂ℱ∞ xTitin</h1>
<h2>by Julia_Menge_eigenOENEYE</h2>
<p><a href="candiOQM_xTitin.html" style="color:#0ff;font-size:18px">→ !engine FULL filtration (4716b)</a></p>
<h3>Articles:</h3>
<ul>
<li><a href="articles/Julia_Menge_eigenOENEYE_001_Main.md" style="color:#a0f">001 Main Theory</a></li>
<li><a href="articles/Julia_Menge_eigenOENEYE_002_Formal_Filtration.md" style="color:#a0f">002 Formal Filtration ∅⊂ℱn⊂ℱ∞</a></li>
<li><a href="articles/Julia_Menge_eigenOENEYE_003_Finite_vs_Infinite.md" style="color:#a0f">003 Finite vs Infinite</a></li>
<li><a href="articles/Julia_Menge_eigenOENEYE_004_Operator_A-Void.md" style="color:#a0f">004 Ŵ + A_𝔄 Operator</a></li>
</ul>
<p style="font-size:12px">$DATE</p>
<p style="font-size:11px">xTitin_(n+1)=Ŵ(xTitin_n)+A_𝔄 | RD_TILE_PX=32 | TRIT [-1,0,1]</p>
</body></html>
HTML
# keep candiOQM_xTitin.html as is - already built
echo "index $(wc -c < index.html)b - Julia_Menge_eigenOENEYE series $DATE"
ls -lh articles/
