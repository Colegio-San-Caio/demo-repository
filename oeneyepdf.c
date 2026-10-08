#!/usr/bin/env python3
import os
NAME=os.environ.get("FAX_NAME","oeneye.c + oeneyepdf.c")
FAX=f"FAX by {NAME} - set by oeneye.c + oeneyepdf.c - FAX by oeneyeFAX - PL:36883"
out=os.environ.get("PDF","./MOSFETQexchange/output/jc_sigma.pdf")
def esc(s): return s.replace("\\","\\\\").replace("(","\\(").replace(")", "\\)")
stream=f"BT /F1 12 Tf 50 750 Td ({esc(FAX)}) Tj ET\nBT /F1 10 Tf 50 730 Td (1+0=1 0 has jc PL:36883 g=0) Tj ET\n"
sb=stream.encode()
objs=[b"1 0 obj << /Type /Catalog /Pages 2 0 R >> endobj\n",b"2 0 obj << /Type /Pages /Kids [3 0 R] /Count 1 >> endobj\n",b"3 0 obj << /Type /Page /Parent 2 0 R /MediaBox [0 0 595 842] /Resources << /Font << /F1 << /Type /Font /Subtype /Type1 /BaseFont /Helvetica >> >> >> /Contents 4 0 R >> endobj\n",f"4 0 obj << /Length {len(sb)} >> stream\n".encode()+sb+b"\nendstream endobj\n"]
pdf=b"%PDF-1.4\n"; offs=[]
for o in objs: offs.append(len(pdf)); pdf+=o
xref=len(pdf); pdf+=f"xref\n0 {len(objs)+1}\n0000000000 65535 f \n".encode()
for off in offs: pdf+=f"{off:010d} 00000 n \n".encode()
pdf+=f"trailer << /Size {len(objs)+1} /Root 1 0 R /Info << /Title (JC) /Author ({esc(NAME)}) /Creator (oeneyepdf.c) >> >>\nstartxref\n{xref}\n%%EOF".encode()
os.makedirs(os.path.dirname(out), exist_ok=True); open(out,"wb").write(pdf)
print(f"[+] {out} len={len(pdf)} {FAX}")
