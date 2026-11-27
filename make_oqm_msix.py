#!/usr/bin/env python3
"""make_oqm_msix.py - Assemble oqm.msix package for MOSFETQ (Open Packaging Conventions / ZIP format)."""
import os
import zipfile
import pathlib
import sys
import struct
import zlib
import shutil

CODE = "KL5UQ4f48673352"

def png(path, w, h):
    bg = (0x14, 0x18, 0x20)
    rows = bytearray()
    n = len(CODE)
    for y in range(h):
        rows.append(0)
        for x in range(w):
            if h * 0.25 <= y < h * 0.75 and w * 0.1 <= x < w * 0.9:
                c = ord(CODE[int((x - w * 0.1) / (w * 0.8) * n) % n])
                px = ((c * 37) % 200 + 55, (c * 91) % 200 + 55, (c * 53) % 200 + 55)
            else:
                px = bg
            rows += bytes(px)
    def chunk(tag, data):
        body = tag + data
        return struct.pack(">I", len(data)) + body + struct.pack(">I", zlib.crc32(body) & 0xFFFFFFFF)
    data = (b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 2, 0, 0, 0))
            + chunk(b"IDAT", zlib.compress(bytes(rows), 9)) + chunk(b"IEND", b""))
    open(path, "wb").write(data)

def build_oqm_msix(output_path="oqm.msix"):
    layout_dir = pathlib.Path("oqm_layout")
    layout_dir.mkdir(exist_ok=True)
    assets_dir = layout_dir / "Assets"
    assets_dir.mkdir(exist_ok=True)

    # 1. Generate PNG assets
    for name, w, h in (("StoreLogo.png", 50, 50), ("Square44x44Logo.png", 44, 44),
                       ("Square150x150Logo.png", 150, 150), ("Wide310x150Logo.png", 310, 150)):
        png(str(assets_dir / name), w, h)

    # 2. Write AppxManifest.xml for MOSFETQ OQM (RED)
    manifest_content = """<?xml version="1.0" encoding="utf-8"?>
<Package xmlns="http://schemas.microsoft.com/appx/manifest/foundation/windows10"
         xmlns:uap="http://schemas.microsoft.com/appx/manifest/uap/windows10"
         xmlns:rescap="http://schemas.microsoft.com/appx/manifest/foundation/windows10/restrictedcapabilities"
         IgnorableNamespaces="uap rescap">
  <Identity Name="KaiOlafKetelhut.MOSFETQ" Publisher="CN=88544420-228E-4D31-8839-1D4CADF99C43" Version="1.0.0.0" ProcessorArchitecture="x64" />
  <Properties>
    <DisplayName>MOSFETQ OQM (RED)</DisplayName>
    <PublisherDisplayName>Kai Olaf Ketelhut</PublisherDisplayName>
    <Logo>Assets\\StoreLogo.png</Logo>
  </Properties>
  <Dependencies>
    <TargetDeviceFamily Name="Windows.Desktop" MinVersion="10.0.17763.0" MaxVersionTested="10.0.22621.0" />
  </Dependencies>
  <Resources>
    <Resource Language="en-us" />
  </Resources>
  <Applications>
    <Application Id="MOSFETQOQM" Executable="app.py" EntryPoint="Windows.FullTrustApplication">
      <uap:VisualElements DisplayName="MOSFETQ OQM" Description="MOSFETQ OQM State and RFC Editor RED Integration"
          BackgroundColor="#141820" Square150x150Logo="Assets\\Square150x150Logo.png" Square44x44Logo="Assets\\Square44x44Logo.png">
        <uap:DefaultTile Wide310x150Logo="Assets\\Wide310x150Logo.png" />
      </uap:VisualElements>
    </Application>
  </Applications>
  <Capabilities>
    <rescap:Capability Name="runFullTrust" />
  </Capabilities>
</Package>
"""
    (layout_dir / "AppxManifest.xml").write_text(manifest_content, encoding="utf-8")

    # 3. Write [Content_Types].xml
    content_types = """<?xml version="1.0" encoding="utf-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Default Extension="png" ContentType="image/png"/>
  <Default Extension="py" ContentType="text/plain"/>
  <Default Extension="html" ContentType="text/html"/>
  <Default Extension="json" ContentType="application/json"/>
</Types>
"""
    (layout_dir / "[Content_Types].xml").write_text(content_types, encoding="utf-8")

    # 4. Write rich interactive app.py (Local Dashboard Server)
    app_py = '''#!/usr/bin/env python3
"""MOSFETQ OQM Local Dashboard Server (RED RFC Editor Integration)"""
import http.server
import socketserver
import webbrowser
import os

PORT = 8038

HTML_CONTENT = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MOSFETQ OQM - RED Dashboard</title>
    <style>
        body { background: #141820; color: #e1e4e8; font-family: system-ui, sans-serif; margin: 0; padding: 40px; }
        .card { background: #1f242d; border: 1px solid #30363d; border-radius: 8px; padding: 24px; max-width: 600px; margin: auto; box-shadow: 0 4px 12px rgba(0,0,0,0.5); }
        h1 { color: #58a6ff; margin-top: 0; font-size: 24px; }
        .badge { background: #238636; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px; }
        .code { background: #0d1117; padding: 12px; border-radius: 6px; font-family: monospace; border: 1px solid #30363d; margin-top: 16px; }
        .btn { background: #238636; color: white; border: none; padding: 10px 16px; border-radius: 6px; cursor: pointer; font-weight: bold; margin-top: 16px; }
        .btn:hover { background: #2ea043; }
    </style>
</head>
<body>
    <div class="card">
        <h1>MOSFETQ OQM <span class="badge">RED v1.0</span></h1>
        <p>QxD Layer L3 State Evaluator &amp; RFC Editor Integration</p>
        <div class="code">
            <strong>Profile:</strong> KDPMember:KL5UQ4f48673352<br>
            <strong>BOA:</strong> application/vnd.x-mosfetq-dos-image<br>
            <strong>Port:</strong> 8038<br>
            <strong>Status:</strong> Active (Fixpoint Lock Ready)
        </div>
        <button class="btn" onclick="alert('MOSFETQ OQM State Evaluated Successfully!')">Run Trit Evaluation</button>
    </div>
</body>
</html>
"""

class DashboardHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(HTML_CONTENT.encode("utf-8"))
    def log_message(self, format, *args):
        print(f"[MOSFETQ OQM] {format % args}")

if __name__ == "__main__":
    with socketserver.TCPServer(("", PORT), DashboardHandler) as httpd:
        print(f"MOSFETQ OQM Dashboard running at http://localhost:{PORT}")
        webbrowser.open(f"http://localhost:{PORT}")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            pass
'''
    (layout_dir / "app.py").write_text(app_py, encoding="utf-8")
    
    if os.path.exists("meta.py"):
        shutil.copy("meta.py", layout_dir / "meta.py")
    if os.path.exists("README.md"):
        shutil.copy("README.md", layout_dir / "README.md")

    # 5. Pack into ZIP / MSIX archive
    out_file = pathlib.Path(output_path)
    with zipfile.ZipFile(out_file, "w", zipfile.ZIP_DEFLATED) as zf:
        for p in layout_dir.rglob("*"):
            if p.is_file():
                zf.write(p, p.relative_to(layout_dir))

    print(f"Successfully generated {out_file} ({out_file.stat().st_size} bytes)")

if __name__ == "__main__":
    build_oqm_msix()
