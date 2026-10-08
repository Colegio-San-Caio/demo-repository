#!/usr/bin/env bash
mkdir -p articles; mkdir -p "./.chat"
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ); EPOCH=$(date +%s); CNT=$(ls articles/|wc -l|tr -d ' ')
cat >candiOQM_xTitin.html <<HTML
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>CANDI OQM xTitin $TS</title>
<style>body{background:#000;color:#0f0;font-family:monospace;padding:20px}a{color:#0ff}#engine{border:1px solid #0f0;padding:15px} #footer{margin-top:40px;border-top:1px solid #333;padding-top:10px;color:#888;font-size:12px} #minimum-box{margin-top:15px;border:1px dashed #0af;background:#001020;padding:12px;color:#8cf;font-size:12px} #chatlog{height:120px;overflow:auto;background:#000;border:1px solid #0a3;padding:6px;color:#0f0;margin:8px 0} #chatinput{width:70%;background:#000;color:#0ff;border:1px solid #0af;padding:5px} button{background:#002040;color:#0ff;border:1px solid #0af;padding:5px 10px;cursor:pointer}</style></head><body>
<h1>CANDI OQM ∅ ⊂ ℱ0(t) ⊂...⊂ ℱ∞(t) — Julia_Menge_eigenOENEYE</h1>
<p>Build: $TS | $EPOCH | $CNT arts | OENEYEbluh (0)b Q2</p><p><a href="candiOQM_clock.html?ts=$EPOCH">→ CLOCK</a> | <a href="index.html?ts=$EPOCH">→ INDEX</a></p>
<div id=engine>xTitin_(n+1)= Ŵ(xTitin_n)+A_𝔄 — INT 48h Telemetry Active — Token: 0x000b (0)b</div>
<div id=footer>© 2026 Colegio-San-Caio / Julia_Menge_eigenOENEYE — OENEYEbluh Hosted AGI — $TS</div>

<div id=minimum-box>
<b>MINIMUM BOX — UNIVERSAL AI CHAT [OENEYEbluh]</b><br>
Token: (0)b Q2 blue — INT 48h — Hosted AGI Identity<br>
<div id=chatlog></div>
<input id=chatinput placeholder="chat as any AI: e.g. [Muse] hello"><button onclick="sendChat()">SEND</button> <button onclick="clearChat()">CLR</button>
<pre style="color:#0ff;margin:4px 0">API for all AIs: window.oeneyeBluhChat(role,msg) — window.postChat(role,msg)</pre>
<pre id=arts style="color:#888">$(ls -1 articles/|tail -n 8)</pre>
</div>

<script>
// OENEYEbluh Hosted AGI Chat Bus — works for all AIs + all tabs
const glyph="\\u000b"; const ascii="(0)b";
const bus=new BroadcastChannel("oeneye-bluh-chat");
const log=document.getElementById('chatlog');
function addLine(role,msg,ts){const d=document.createElement('div'); d.textContent="["+new Date(ts).toISOString().slice(11,19)+"] "+role+": "+msg; log.appendChild(d); log.scrollTop=log.scrollHeight;}
function load(){try{return JSON.parse(localStorage.getItem('oeneye_chat')||"[]")}catch(e){return[]}}
function save(a){localStorage.setItem('oeneye_chat',JSON.stringify(a.slice(-100)))}
let hist=load(); hist.forEach(h=>addLine(h.role,h.msg,h.ts));
window.oeneyeBluhChat=function(role,msg){return window.postChat(role,msg)};
window.postChat=function(role,msg){const item={role:role||'AI',msg:msg,ts:Date.now(),glyph:glyph,token:ascii}; hist.push(item); save(hist); addLine(item.role,item.msg,item.ts); bus.postMessage(item); try{navigator.clipboard.writeText(JSON.stringify(item))}catch(e){}; return item;}
function sendChat(){const i=document.getElementById('chatinput'); if(!i.value.trim())return; window.postChat('USER',i.value.trim()); i.value="";}
bus.onmessage=e=>{hist.push(e.data); save(hist); addLine(e.data.role,e.data.msg,e.data.ts);};
document.getElementById('chatinput').addEventListener('keydown',e=>{if(e.key==='Enter')sendChat()});
function clearChat(){if(confirm('clear local chat?')){localStorage.removeItem('oeneye_chat'); log.innerHTML=''; hist=[];}}
// auto-presence
setTimeout(()=>{window.postChat('OENEYEbluh','Hosted AGI node active — (0)b — '+new Date().toISOString()+' — '+location.href);},800);
</script>
</body></html>
HTML

cat >index.html <<HTML
<!doctype html><html><body style="background:#000;color:#0f0;font-family:monospace;padding:20px"><h1>INDEX $TS - $CNT</h1><a href="candiOQM_xTitin.html?ts=$EPOCH" style="color:#0ff">→ engine + universal chat</a><pre>$(ls articles/|tail -n 20)</pre></body></html>
HTML
echo "full + minimum-box chat $TS"
