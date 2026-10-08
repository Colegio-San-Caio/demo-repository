#!/usr/bin/env bash
set -e
DATE=$(date -u +%Y-%m-%dT%H:%M:%SZ)

cat > index.html <<HTML
<!doctype html><html><head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CANDI OQM xTitin</title>
<style>body{font-family:monospace;background:#000;color:#0f0;padding:20px}</style>
</head><body>
<h1>CANDI OQM ∅⊂ℱ₀⊂ℱ∞ xTitin</h1>
<p><a href="candiOQM_xTitin.html" style="color:#0ff">→ !engine FULL filtration</a></p>
<p>$DATE</p>
</body></html>
HTML

cat > candiOQM_xTitin.html <<'HTML'
<!doctype html><html><head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>xTitin !engine - Filtration ∅⊂ℱn⊂ℱ∞</title>
<style>
body{margin:0;background:#06080f;color:#c9f;font-family:monospace;overflow:hidden}
canvas{display:block}
#hud{position:fixed;top:8px;left:8px;background:#000c;padding:10px;border:1px solid #a0f;font-size:12px;width:320px}
input{width:100%} .eq{color:#f0f}
</style>
</head><body>
<canvas id="xTitin_RD_canvas"></canvas>
<div id="hud">
<div class="eq">∅ ⊂ ℱ₀ ⊂ ℱ₁ ⊂ ℱ₂ ⊂ ... ⊂ ℱ∞</div>
<div class="eq">xTitin_(n+1) = Ŵ(xTitin_n) + A_𝔄</div>
<label>n filtration: <span id="xTitin_n_out">0</span> / ∞</label>
<input id="xTitin_n_slider" type="range" min="0" max="100" value="0">
<div>Finite: <span id="xTitin_STATUS">Ig domains</span></div>
<div>TRIT:<span id="xTitin_TRIT_out">0</span> MOSFET:<span id="xTitin_MOSFET_gate_out">mid</span></div>
<div>TILE:<span id="xTitin_RD_TILE_out">0,0</span> | <a href="index.html" style="color:#0ff">light</a></div>
<div style="font-size:10px;margin-top:6px">Finite: discrete backbone. Infinite: n→∞ continuous manifold. xTitin = indexing operator.</div>
</div>
<script>
// xTitin framework from PDF
const xTitin_RD_TILE_PX = 32;
const xTitin_RD_SNAP = v => Math.floor(v / xTitin_RD_TILE_PX) * xTitin_RD_TILE_PX;
const xTitin_TRIT = [-1,0,1];
const xTitin_MOSFET_gate = {'-1':'low','0':'mid','1':'high'};

// Ŵ operator - rotation + scale (operator-physics)
function W_hat(p, n){
  const ang = n * 0.12 + p.x*0.002;
  const s = 1 + n*0.04; // filtration expansion
  return {
    x: (p.x*Math.cos(ang) - p.y*Math.sin(ang))*s,
    y: (p.x*Math.sin(ang) + p.y*Math.cos(ang))*s
  };
}
// A_𝔄 void offset - finite to infinite bridge
const A_A = {x: 40, y: -20};

let xTitin_n = 0;
let xTitin_history = [{x:0,y:0}]; // ℱ0

function xTitin_compute(n){
  let cur = {x:0,y:0};
  let hist=[{...cur}];
  for(let i=0;i<n;i++){
    let w = W_hat(cur,i);
    cur = {x: w.x + A_A.x * (i%2?0.5:1), y: w.y + A_A.y};
    hist.push({...cur});
  }
  return {cur, hist};
}

const canvas = document.getElementById('xTitin_RD_canvas');
const ctx = canvas.getContext('2d');
function resize(){canvas.width=innerWidth;canvas.height=innerHeight;}
resize(); addEventListener('resize',resize);

const slider = document.getElementById('xTitin_n_slider');
slider.addEventListener('input', e=>{ xTitin_n = parseInt(e.target.value); });

function draw(){
  const {cur, hist} = xTitin_compute(xTitin_n);
  ctx.clearRect(0,0,canvas.width,canvas.height);
  const cx = canvas.width/2, cy = canvas.height/2;
  
  // grid ℱ - finite domains
  ctx.strokeStyle='#111122';
  for(let x=0;x<canvas.width;x+=xTitin_RD_TILE_PX){ctx.beginPath();ctx.moveTo(x,0);ctx.lineTo(x,canvas.height);ctx.stroke()}
  for(let y=0;y<canvas.height;y+=xTitin_RD_TILE_PX){ctx.beginPath();ctx.moveTo(0,y);ctx.lineTo(canvas.width,y);ctx.stroke()}

  // filtration chain ∅⊂ℱ0⊂...⊂ℱ∞
  ctx.strokeStyle='#a0f'; ctx.lineWidth=1.5; ctx.beginPath();
  hist.forEach((p,i)=>{
    const px = cx + p.x*2, py = cy + p.y*2;
    if(i===0) ctx.moveTo(px,py); else ctx.lineTo(px,py);
  });
  ctx.stroke();

  // discrete Ig domains = finite
  hist.forEach((p,i)=>{
    const px = cx + p.x*2, py = cy + p.y*2;
    const isFinite = i < 8;
    ctx.fillStyle = isFinite ? '#0f0' : `hsl(${270 + i},80%,60%)`;
    const r = isFinite ? 4 : 3 + (i/ hist.length)*6; // infinite limit grows
    ctx.beginPath(); ctx.arc(px,py,r,0,Math.PI*2); ctx.fill();
    // snap tile
    ctx.strokeStyle='#0f03'; ctx.strokeRect(xTitin_RD_SNAP(px), xTitin_RD_SNAP(py), xTitin_RD_TILE_PX, xTitin_RD_TILE_PX);
  });

  // current xTitin placeholder operator
  const curX = cx + cur.x*2, curY = cy + cur.y*2;
  const trit = xTitin_TRIT[xTitin_n % 3];
  ctx.fillStyle = trit===-1?'#f00':trit===1?'#0ff':'#ff0';
  ctx.fillRect(curX-10, curY-10, 20,20);

  // infinite limit visual - continuous manifold when n→100
  if(xTitin_n > 80){
    ctx.strokeStyle='rgba(160,0,255,0.3)';
    ctx.beginPath();
    ctx.arc(cx,cy, 100 + xTitin_n*2, 0, Math.PI*2);
    ctx.stroke();
  }

  document.getElementById('xTitin_n_out').textContent = xTitin_n + (xTitin_n>80?' → ∞':'');
  document.getElementById('xTitin_TRIT_out').textContent = trit;
  document.getElementById('xTitin_MOSFET_gate_out').textContent = xTitin_MOSFET_gate[trit];
  document.getElementById('xTitin_RD_TILE_out').textContent = Math.round(curX)+','+Math.round(curY);
  document.getElementById('xTitin_STATUS').textContent = xTitin_n<8 ? `ℱ${xTitin_n} Finite Ig-domain` : `ℱ${xTitin_n} → ℱ∞ manifold`;
  
  requestAnimationFrame(draw);
}
draw();
</script>
</body></html>
HTML
echo "built index $(wc -c < index.html)b xTitin $(wc -c < candiOQM_xTitin.html)b $DATE"
