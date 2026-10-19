(function () {
  var c = window.CATALOG;
  if (!c || !c.archives) return;
  var n = document.getElementById('archive-count');
  var l = document.getElementById('archive-last');
  var ul = document.getElementById('archive-list');
  if (n) n.textContent = c.archives.length;
  if (l) l.textContent = c.last || 'N/A';
  if (ul) {
    c.archives.forEach(function (p) {
      var li = document.createElement('li');
      var a = document.createElement('a');
      a.href = p;
      a.textContent = p.replace('archive/', '');
      li.appendChild(a);
      ul.appendChild(li);
    });
  }
})();
