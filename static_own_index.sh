#!/usr/bin/env bash
set -e
DATE=$(date -u +%Y-%m-%dT%H:%M:%SZ)

# xTitin naming convention: xTitin_{MODULE}_{TYPE}
# e.g. xTitin_TRIT_gate, xTitin_CAM_proj, xTitin_RD_tile

# LIGHT index.html - 850 bytes - for Pages root
cat > index.html <<HTML
<!doctype html><html><head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<meta property="og:type" content="website" />
<meta property="og:title" content="CANDI OQM" />
<meta property="og:url" content="https://colegio-san-caio.github.io/demo-repository/candiOQM.txt" />
<title>CANDI OQM</title></head><body>
<h1>CANDI OQM - Colegio San Caio</h1>
<p><a href="candiOQM.txt">txt</a> | <a href="candiOQM_xTitin.html">xTitin Full</a> | <a href="meta_share.html">meta</a></p>
<p>$DATE - <span id="xTitin_STATUS">OK</span></p>
</body></html>
HTML

# FULL xTitin version - with 3D/4D + Trit
cat > candiOQM_xTitin.html <<HTML
<!doctype html><html><head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CANDI OQM xTitin</title></head><body>
<h1>CANDI OQM xTitin Full</h1>
<pre>
// xTitin naming convention
const xTitin_RD_TILE_PX = 32;
const xTitin_RD_SNAP = (v) => Math.floor(v / xTitin_RD_TILE_PX) * xTitin_RD_TILE_PX;
const xTitin_TRIT = [-1,0,1]; // ternary
const xTitin_CAM_proj = (trit) => trit * 0.5 + 0.5; // gate bias
const xTitin_MOSFET_gate = { low:-1, mid:0, high:1 };
</pre>
<p>Generated: $DATE</p>
<p><a href="index.html">back to light</a></p>
</body></html>
HTML

echo "index.html $(wc -c < index.html) bytes"
echo "candiOQM_xTitin.html $(wc -c < candiOQM_xTitin.html) bytes"
