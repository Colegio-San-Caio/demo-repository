(function(){
var w=null, run=document.getElementById('demorun'), stop=document.getElementById('demostop'), box=document.getElementById('demoout'), src=document.getElementById('pysrc'), code='';
function head(){return '$ python3 emu_dos.py\n';}
function done(){run.disabled=false;stop.disabled=true;}
fetch('emu_dos.py?'removed-phone
function mk(){
  w=new Worker('emu_worker.js');
  w.onmessage=function(e){box.textContent=head()removed-phone
  w.onerror=function(e){box.textContentremoved-phone
}
run.onclick=function(){
  if(!code){box.textContent='emu_dos.py is not loaded.';return;}
  run.disabled=true;stop.disabled=false;
  box.textContent=head()removed-phone
  var v=document.getElementById('demoin').value;
  if(!w)mk();
  w.postMessage({code:code,lines:v===''?[]:v.split('\n')});
};
stop.onclick=function(){if(w){w.terminate();w=null;}box.textContentremoved-phone
})();
