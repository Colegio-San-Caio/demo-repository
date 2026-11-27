#!/usr/bin/env python3
"""make_qxd_console_msix.py - Assemble QxD Trit State Console MSIX package."""
import os
import zipfile
import pathlib
import sys
import struct
import zlib
import shutil

CODE = "KL5UQ4f48673352"

def png(path, w, h):
    bg = (0x07, 0x09, 0x0d)
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

def build_qxd_msix(output_path="qxd_console.msix"):
    layout_dir = pathlib.Path("qxd_layout")
    layout_dir.mkdir(exist_ok=True)
    assets_dir = layout_dir / "Assets"
    assets_dir.mkdir(exist_ok=True)

    # 1. Generate PNG assets
    for name, w, h in (("StoreLogo.png", 50, 50), ("Square44x44Logo.png", 44, 44),
                       ("Square150x150Logo.png", 150, 150), ("Wide310x150Logo.png", 310, 150)):
        png(str(assets_dir / name), w, h)

    # 2. Write AppxManifest.xml with fileTypeAssociation for .qxd files
    manifest_content = """<?xml version="1.0" encoding="utf-8"?>
<Package xmlns="http://schemas.microsoft.com/appx/manifest/foundation/windows10"
         xmlns:uap="http://schemas.microsoft.com/appx/manifest/uap/windows10"
         xmlns:rescap="http://schemas.microsoft.com/appx/manifest/foundation/windows10/restrictedcapabilities"
         IgnorableNamespaces="uap rescap">
  <Identity Name="KaiOlafKetelhut.QxDConsole" Publisher="CN=88544420-228E-4D31-8839-1D4CADF99C43" Version="1.0.0.0" ProcessorArchitecture="x64" />
  <Properties>
    <DisplayName>QxD — Trit State Console</DisplayName>
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
    <Application Id="QxDApp" Executable="QxDConsole.exe" EntryPoint="Windows.FullTrustApplication">
      <uap:VisualElements
        DisplayName="QxD — Trit State Console"
        Description="Interactive balanced ternary (-1, 0, +1) logic editor and console"
        BackgroundColor="#07090d"
        Square150x150Logo="Assets\\Square150x150Logo.png"
        Square44x44Logo="Assets\\Square44x44Logo.png" />
      <Extensions>
        <uap:Extension Category="windows.fileTypeAssociation">
          <uap:FileTypeAssociation Name="qxdscript">
            <uap:SupportedFileTypes>
              <uap:FileType ContentType="application/x-qxd">.qxd</uap:FileType>
            </uap:SupportedFileTypes>
            <uap:DisplayName>QxD Ternary Script</uap:DisplayName>
          </uap:FileTypeAssociation>
        </uap:Extension>
      </Extensions>
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
  <Default Extension="html" ContentType="text/html"/>
  <Default Extension="qxd" ContentType="text/plain"/>
</Types>
"""
    (layout_dir / "[Content_Types].xml").write_text(content_types, encoding="utf-8")

    # 4. Copy console HTML
    if os.path.exists("qxd_trit_console.html"):
        shutil.copy("qxd_trit_console.html", layout_dir / "index.html")

    # 5. Pack into MSIX
    out_file = pathlib.Path(output_path)
    with zipfile.ZipFile(out_file, "w", zipfile.ZIP_DEFLATED) as zf:
        for p in layout_dir.rglob("*"):
            if p.is_file():
                zf.write(p, p.relative_to(layout_dir))

    print(f"Successfully generated {out_file} ({out_file.stat().st_size} bytes)")

if __name__ == "__main__":
    build_qxd_msix()
