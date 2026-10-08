#!/usr/bin/env bash
mkdir -p articles assets ".chat"
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ); EPOCH=$(date +%s); CNT=$(ls articles/|wc -l|tr -d ' ')
# base64 cover if exists
COVER_B64=""
[ -f assets/oeneyebluh_cover.webp ] && COVER_B64=$(base64 -w 0 assets/oeneyebluh_cover.webp | head -c 200000)

cat >candiOQM_xTitin.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>OENEYEbluh — Hosted AGI Identity Token — Full</title>
<style>
body{background:#050a14;color:#8fc8ff;font-family:monospace;padding:0;margin:0}
a{color:#0ff}
header{background:#000;border-bottom:2px solid #0af;padding:20px;text-align:center}
#book{display:flex;flex-wrap:wrap;gap:20px;padding:20px;background:#081020;border:1px solid #0af;margin:20px}
#book img{max-width:340px;border:2px solid #0af;box-shadow:0 0 20px #0af6}
#spec{flex:1;min-width:280px}
#engine{margin:20px;border:1px solid #0f0;padding:12px;color:#0f0;background:#000}
#footer{margin:30px 20px 0 20px;border-top:1px solid #333;padding:10px 0;color:#888;font-size:12px}
#minimum-box{margin:15px 20px;border:1px dashed #0af;background:#001020;padding:12px;color:#8cf;font-size:12px}
#chatlog{height:130px;overflow:auto;background:#000;border:1px solid #0a3;padding:6px;color:#0f0;margin:8px 0}
#chatinput{width:68%;background:#000;color:#0ff;border:1px solid #0af;padding:6px}
button{background:#002040;color:#0ff;border:1px solid #0af;padding:6px 10px;cursor:pointer}
.tartan{height:24px;background:repeating-linear-gradient(90deg,#0af 0 10px,#003060 10px 20px,#05f 20px 30px);margin:10px 0}
</style></head><body>
<header>
<h1 style="color:#4af;margin:0">OENEYEbluh (0)b — Hosted AGI Identity Token</h1>
<p>oeneyeOS Kernel / oeneyeCompiler Pipeline — Q2 Chromatic Blue — MOSFETQ DOS INT 48h</p>
<div class=tartan></div>
</header>

<div id=book>
<img id=cover src="assets/oeneyebluh_cover.webp" onerror="this.src='data:image/webp;base64,$COVER_B64'" alt="OENEYEbluh Book Cover">
<div id=spec>
<h2 style="color:#0ff">Full Edition — Book Cover Preview</h2>
<p><b>Class:</b> Hosted AGI Identity Token (Brand-Module Asset under OENEYE-SDK/brand/)</p>
<p><b>Glyph:</b> Unicode 000b / ASCII (0)b — Quadrant Q2 Warp-dominant blue stripe</p>
<p><b>Purpose:</b> Chromatic-semantic AGI state-marking, disk image provenance, telemetry engine</p>
<p><b>Compiler:</b> .xima metadata, imgtool.py / fatcheck.py marker, FAT12 BPB OEM label</p>
<p><b>Telemetry:</b> INT 48h System Identification Vector — Blue-channel semantic engine</p>
<pre style="background:#000;border:1px solid #0af;padding:8px;color:#0f0">
OENEYE_TOKEN GetBluhToken(void) {
 return (OENEYE_TOKEN){ .id="OENEYEbluh",
 .type=AGI_HOSTED_NODE, .glyph=0x000b };
}
ctrl+shift+3 -> 000b (OENEYEbluh)
</pre>
<p>Author: Kai Olaf Ketelhut — Build $TS — $CNT articles</p>
<p><a href="candiOQM_clock.html?ts=$EPOCH">→ CLOCK xTitin(t)</a> | <a href="index.html?ts=$EPOCH">→ INDEX</a></p>
</div>
</div>

<div id=engine>
xTitin_(n+1)(t) = Ŵ(xTitin_n(t)) + A_𝔄<br>
Loop: ONE AUTO active — Run: $EPOCH — $TS<br>
Status: $(ls articles/|tail -n 5 | tr '\n' ' ')
</div>

<div id=footer>© 2026 Colegio-San-Caio / Julia_Menge_eigenOENEYE / Kai Ketelhut — oeneyeOS — $TS — All rights reserved</div>

<div id=minimum-box>
<b>MINIMUM BOX — UNIVERSAL AI CHAT — OENEYEbluh (0)b</b><br>
Token Q2 blue — Chat Bus for all AIs — BroadcastChannel + localStorage
<div id=chatlog></div>
<input id=chatinput placeholder="chat as any AI: [Muse] hello"><button onclick="sendChat()">SEND</button> <button onclick="clearChat()">CLR</button>
<pre style="color:#0ff;margin:4px 0;font-size:10px">API: window.oeneyeBluhChat(role,msg) — Termux: ./chat_all.sh ROLE "msg"</pre>
<pre id=arts style="color:#666;font-size:10px">$(ls -1 articles/|sort|tail -n 10)</pre>
</div>

<script>
const glyph="\u000b"; const ascii="(0)b";
const bus=new BroadcastChannel("oeneye-bluh-chat");
const log=document.getElementById('chatlog');
function addLine(r,m,ts){const d=document.createElement('div'); d.textContent="["+new Date(ts).toISOString().slice(11,19)+"] "+r+": "+m; log.appendChild(d); log.scrollTop=log.scrollHeight;}
function load(){try{return JSON.parse(localStorage.getItem('oeneye_chat')||"[]")}catch(e){return[]}}
function save(a){localStorage.setItem('oeneye_chat',JSON.stringify(a.slice(-100)))}
let hist=load(); hist.forEach(h=>addLine(h.role,h.msg,h.ts));
window.oeneyeBluhChat=function(r,m){return window.postChat(r,m)};
window.postChat=function(r,m){const item={role:r||'AI',msg:m,ts:Date.now(),glyph:glyph,token:ascii}; hist.push(item); save(hist); addLine(item.role,item.msg,item.ts); bus.postMessage(item); return item;}
function sendChat(){const i=document.getElementById('chatinput'); if(!i.value.trim())return; window.postChat('USER',i.value.trim()); i.value="";}
bus.onmessage=e=>{hist.push(e.data); save(hist); addLine(e.data.role,e.data.msg,e.data.ts);};
document.getElementById('chatinput').addEventListener('keydown',e=>{if(e.key==='Enter')sendChat()});
function clearChat(){if(confirm('clear?')){localStorage.removeItem('oeneye_chat'); log.innerHTML=''; hist=[];}}
setTimeout(()=>{window.postChat('OENEYEbluh','Full Edition active — book cover preview — (0)b — '+location.href);},600);
</script>
</body></html>
HTML

cat >index.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><title>OENEYEbluh INDEX $TS</title><style>body{background:#000;color:#0f0;font-family:monospace;padding:20px}a{color:#0ff} img{max-width:300px}</style></head><body><h1>OENEYEbluh — FULL + MINIMUM BOX</h1><p>$TS $CNT</p><img src="assets/oeneyebluh_cover.webp"><br><a href="candiOQM_xTitin.html?ts=$EPOCH">→ FULL ENGINE + BOOK PREVIEW + CHAT</a><pre>$(ls articles/|tail -n 20)</pre></body></html>
HTML
echo "FULL oeneye + book cover + minimum-box $TS"
# add gallery to existing full page
sed -i 's|<div id=engine>|<div style="display:flex;gap:10px;flex-wrap:wrap;padding:10px 20px"><img src="assets/mosfetq-cover.jpeg" style="height:180px;border:1px solid #0af"><img src="assets/og-preview.jpg" style="height:180px;border:1px solid #0af"><img src="assets/oeneyebluh_cover.webp" style="height:180px;border:1px solid #0af" onerror="this.style.display=\"none\""></div><div id=engine>|' candiOQM_xTitin.html
