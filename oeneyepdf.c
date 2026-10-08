#!/usr/bin/env python3
import os
NAME = os.environ.get("FAX_NAME","oeneye.c + oeneyepdf.c")
FAX = f"FAX by {NAME} — set by oeneye.c + oeneyepdf.c — FAX by oeneyeFAX — PL:36883"
title=os.environ.get("TITLE","JC Theta Sigma"); body=os.environ.get("BODY","1+0=1 0 has jc"); eq=os.environ.get("EQ","1+0=1"); doc=os.environ.get("DOC","jc_sigma"); out=os.environ.get("PDF","./MOSFETQexchange/output/jc_sigma.pdf")
def esc(s): return s.replace(chr(92),chr(92)+chr(92)).replace("(",r"\(").replace(")",r"\)")
lines=[FAX,f"Title: {title}",f"Doc: {doc}","",body[:1200],"",f"Eq: {eq}","","1+0=1 g=0 V(f-F)=0"]
y=780; stream=""
for l in lines:
 for chunk in [l[i:i+90] for i in range(0,max(1,len(l)),90)] or [""]:
  stream+=f"BT /F1 10 Tf 50 {y} Td ({esc(chunk)}) Tj ET\n"; y-=14
  if y<40: stream+="showpage\n"; y=780
sb=stream.encode(); objs=[]
objs.append(b"1 0 obj << /Type /Catalog /Pages 2 0 R >> endobj\n")
objs.append(b"2 0 obj << /Type /Pages /Kids [3 0 R] /Count 1 >> endobj\n")
objs.append(b"3 0 obj << /Type /Page /Parent 2 0 R /MediaBox [0 0 595 842] /Resources << /Font << /F1 << /Type /Font /Subtype /Type1 /BaseFont /Helvetica >> >> >> /Contents 4 0 R >> endobj\n")
objs.append(f"4 0 obj << /Length {len(sb)} >> stream\n".encode()+sb+b"\nendstream endobj\n")
pdf=b"%PDF-1.4\n"; offs=[]
for o in objs: offs.append(len(pdf)); pdf+=o
xref=len(pdf); pdf+=f"xref\n0 {len(objs)+1}\n0000000000 65535 f \n".encode()
for off in offs: pdf+=f"{off:010d} 00000 n \n".encode()
pdf+=f"trailer << /Size {len(objs)+1} /Root 1 0 R /Info << /Title ({esc(title)}) /Author ({esc(NAME)}) /Creator (oeneyepdf.c) >> >>\nstartxref\n{xref}\n%%EOF".encode()
open(out,"wb").write(pdf); print(f"[+] {out} by {NAME} len={len(pdf)} {FAX}")
