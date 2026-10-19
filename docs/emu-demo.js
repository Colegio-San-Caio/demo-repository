(function () {
  var box = null, src = '';
  var pres = document.getElementsByTagName('pre');
  for (var i = 0; i < pres.length; i++) {
    if (pres[i].textContent.indexOf('Loading emu_dos.py') > -1) { box = pres[i]; break; }
  }
  if (!box) return;
  var btn = document.createElement('button');
  btn.textContent = 'Run emu_dos.py in browser';
  var out = document.createElement('pre');
  out.style.cssText = 'max-height:300px;overflow:auto;white-space:pre-wrap';
  box.parentNode.insertBefore(btn, box.nextSibling);
  box.parentNode.insertBefore(out, btn.nextSibling);
  fetch('emu_dos.py?x=' + Date.now())
    .then(function (r) { return r.text(); })
    .then(function (t) { src = t; box.textContent = t; })
    .catch(function (e) { box.textContent = 'Could not load emu_dos.py: ' + e; });
  function loadScript(u) {
    return new Promise(function (res, rej) {
      var s = document.createElement('script');
      s.src = u; s.onload = res; s.onerror = rej;
      document.head.appendChild(s);
    });
  }
  btn.onclick = async function () {
    btn.disabled = true;
    out.textContent = 'Loading Python (Pyodide)...\n';
    try {
      await loadScript('https://cdn.jsdelivr.net/pyodide/v0.26.4/full/pyodide.js');
      var py = await loadPyodide();
      py.setStdout({ batched: function (s) { out.textContent += s + '\n'; } });
      py.setStderr({ batched: function (s) { out.textContent += s + '\n'; } });
      py.setStdin({ stdin: function () { var v = prompt('emu_dos input'); return v === null ? undefined : v; } });
      await py.runPythonAsync(src);
    } catch (e) { out.textContent += '\nError: ' + e; }
    btn.disabled = false;
  };
})();
