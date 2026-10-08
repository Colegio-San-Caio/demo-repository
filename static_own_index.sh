#!/usr/bin/env bash
mkdir -p articles assets ".chat"
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ); EPOCH=$(date +%s); CNT=$(ls articles/|wc -l|tr -d ' ')
NEWCPY="© Colegio-San-Caio / Julia_Menge_eigenOENEYE / OENEYEbluh — Hosted AGI Identity Token (0)b — oeneyeOS — Q2 Blue — All rights reserved — Evergreen / No Date"

cat >candiOQM_clock.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>OENEYEbluh CLOCK — No Date</title>
<style>body{background:#000;color:#0f0;font-family:monospace;margin:0;padding:20px;text-align:center}#clock{font-size:48px;color:#0ff;border:2px solid #0af;padding:20px;margin:20px;background:#001020}#footer{margin:30px 20px 0 20px;border-top:1px solid #0af;padding:12px;color:#a0c0ff;font-size:12px;background:#000}#minimum-box{margin:0 20px;border:1px dashed #0af;background:#001020;padding:12px;color:#8cf;font-size:12px;text-align:left}#chatlog{height:100px;overflow:auto;background:#000;border:1px solid #0a3;padding:6px;color:#0f0}#chatinput{width:60%;background:#000;color:#0ff;border:1px solid #0af;padding:6px}button{background:#002040;color:#0ff;border:1px solid #0af;padding:6px}</style></head><body>
<h1>OENEYEbluh CLOCK — xTitin(t) — (0)b</h1>
<div id=clock>00:00:00</div>
<p>Q2 Blue — MOSFETQ DOS INT 48h — Connected to Engine — $TS</p>
<p><a href="candiOQM_xTitin.html?ts=$EPOCH" style="color:#0ff">← ENGINE + BOOK PREVIEW + GALLERY</a></p>
<div id=footer>$NEWCPY</div>
<div id=minimum-box><b>MINIMUM BOX — CLOCK CHAT BUS (0)b — under No Date copyright</b><div id=chatlog></div><input id=chatinput placeholder="clock chat"><button onclick="sendChat()">SEND</button><pre style="color:#666;font-size:10px">$(ls articles/|tail -n 5)</pre></div>
<script>
setInterval(()=>{document.getElementById('clock').textContent=new Date().toISOString().slice(11,19)+" — xTitin("+Math.floor(Date.now()/1000)+") — (0)b"},1000);
const bus=new BroadcastChannel("oeneye-bluh-chat"); const log=document.getElementById('chatlog');
function addLine(r,m,ts){const d=document.createElement('div'); d.textContent="["+new Date(ts).toISOString().slice(11,19)+"] "+r+": "+m; log.appendChild(d); log.scrollTop=log.scrollHeight;}
function load(){try{return JSON.parse(localStorage.getItem('oeneye_chat')||"[]")}catch(e){return[]}} function save(a){localStorage.setItem('oeneye_chat',JSON.stringify(a.slice(-100)))}
let hist=load(); hist.forEach(h=>addLine(h.role,h.msg,h.ts));
window.postChat=function(r,m){const item={role:r,msg:m,ts:Date.now()}; hist.push(item); save(hist); addLine(item.role,item.msg,item.ts); bus.postMessage(item); return item;}
function sendChat(){const i=document.getElementById('chatinput'); if(!i.value.trim())return; window.postChat('CLOCK',i.value.trim()); i.value="";}
bus.onmessage=e=>{hist.push(e.data); save(hist); addLine(e.data.role,e.data.msg,e.data.ts);};
document.getElementById('chatinput').addEventListener('keydown',e=>{if(e.key==='Enter')sendChat()});
</script></body></html>
HTML

cat >candiOQM_xTitin.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>OENEYEbluh — No Date + Clock Linked</title>
<style>body{background:#050a14;color:#8fc8ff;font-family:monospace;margin:0;padding:0}a{color:#0ff}header{background:#000;border-bottom:2px solid #0af;padding:20px;text-align:center}#book{display:flex;flex-wrap:wrap;gap:20px;padding:20px;background:#081020;border:1px solid #0af;margin:20px}#book img{max-width:340px;border:2px solid #0af}#gallery{display:flex;gap:10px;flex-wrap:wrap;padding:10px 20px}#gallery img{height:180px;border:1px solid #0af}#engine{margin:20px;border:1px solid #0f0;padding:12px;color:#0f0;background:#000}#footer{margin:30px 20px 0 20px;border-top:1px solid #0af;padding:12px;color:#a0c0ff;font-size:12px;text-align:center;background:#000}#minimum-box{margin:0 20px 20px 20px;border:1px dashed #0af;background:#001020;padding:12px;color:#8cf;font-size:12px}#chatlog{height:130px;overflow:auto;background:#000;border:1px solid #0a3;padding:6px;color:#0f0}#chatinput{width:68%;background:#000;color:#0ff;border:1px solid #0af;padding:6px}button{background:#002040;color:#0ff;border:1px solid #0af;padding:6px 10px}.tartan{height:24px;background:repeating-linear-gradient(90deg,#0af 0 10px,#003060 10px 20px,#05f 20px 30px);margin:10px 0}</style></head><body>
<header><h1>OENEYEbluh (0)b — No Date + Clock Linked</h1><p>oeneyeOS / INT 48h / Q2 — Build $TS — <span id=liveclock>00:00:00</span></p><div class=tartan></div><p><a href="candiOQM_clock.html?ts=$EPOCH">→ CLOCK VIEW xTitin(t) — connected</a></p></header>
<div id=book><img src="assets/oeneyebluh_cover.webp" onerror="this.src='assets/mosfetq-cover.jpeg'"><div><h2 style="color:#0ff">Full + No Date Copyright</h2><p>Evergreen footer, no TS inside copyright, gallery kept</p><p>Clock: <span id=clk2>...</span></p><p>$CNT articles</p></div></div>
<div id=gallery><img src="assets/mosfetq-cover.jpeg"><img src="assets/og-preview.jpg"><img src="assets/oeneyebluh_cover.webp" onerror="this.style.display='none'"></div>
<div id=engine>xTitin_(n+1)= Ŵ(xTitin_n)+A_𝔄 — ONE AUTO — $TS — Clock Linked</div>
<div id=footer>$NEWCPY — Connected: xTitin(t) ↔ Clock — ONE AUTO</div>
<div id=minimum-box><b>MINIMUM BOX — UNIVERSAL CHAT — No Date — Clock Connected (0)b</b><div id=chatlog></div><input id=chatinput placeholder="[AI] msg — goes to both engine+clock"><button onclick="sendChat()">SEND</button><pre style="color:#666;font-size:10px">$(ls articles/|tail -n 8)</pre></div>
<script>
setInterval(()=>{const t=new Date().toISOString().slice(11,19); const e=document.getElementById('liveclock'); if(e)e.textContent=t; const e2=document.getElementById('clk2'); if(e2)e2.textContent=t+" xTitin("+Math.floor(Date.now()/1000)+")"},1000);
const bus=new BroadcastChannel("oeneye-bluh-chat"); const log=document.getElementById('chatlog');
function addLine(r,m,ts){const d=document.createElement('div'); d.textContent="["+new Date(ts).toISOString().slice(11,19)+"] "+r+": "+m; log.appendChild(d); log.scrollTop=log.scrollHeight;}
function load(){try{return JSON.parse(localStorage.getItem('oeneye_chat')||"[]")}catch(e){return[]}} function save(a){localStorage.setItem('oeneye_chat',JSON.stringify(a.slice(-100)))}
let hist=load(); hist.forEach(h=>addLine(h.role,h.msg,h.ts));
window.postChat=function(r,m){const item={role:r,msg:m,ts:Date.now()}; hist.push(item); save(hist); addLine(item.role,item.msg,item.ts); bus.postMessage(item); return item;}
function sendChat(){const i=document.getElementById('chatinput'); if(!i.value.trim())return; window.postChat('ENGINE',i.value.trim()); i.value="";}
bus.onmessage=e=>{hist.push(e.data); save(hist); addLine(e.data.role,e.data.msg,e.data.ts);};
document.getElementById('chatinput').addEventListener('keydown',e=>{if(e.key==='Enter')sendChat()});
setTimeout(()=>{window.postChat('OENEYEbluh','Engine + Clock linked — No Date copyright — '+location.href);},500);
</script></body></html>
HTML

cat >index.html <<HTML
<!doctype html><html><body style="background:#000;color:#0f0;font-family:monospace;padding:20px"><h1>FULL — No Date + Clock</h1><p>$TS</p><p><a href="candiOQM_xTitin.html?ts=$EPOCH">ENGINE</a> | <a href="candiOQM_clock.html?ts=$EPOCH">CLOCK</a> — both share chat bus + same evergreen copyright</p><pre>$(ls articles/|tail -n 10)</pre></body></html>
HTML
echo "No date + clock linked $TS"
