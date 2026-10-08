#!/usr/bin/env bash
set -euo pipefail
BASE_DIR="./MOSFETQexchange"
OUTPUT_DIR="$BASE_DIR/output"
SPOOL_DIR="$BASE_DIR/spool/fax"
mkdir -p "$OUTPUT_DIR" "$SPOOL_DIR"
echo "================================================================Cache Cleared"
echo "[*] Touch *.*"; find . -maxdepth 1 -type f -exec touch {} + 2>/dev/null || true

for XTEX_FILE in *.xtex; do
  [ -f "$XTEX_FILE" ] || continue
  DOC="${XTEX_FILE%.xtex}"
  TEX="${DOC}.tex"
  PDF="$OUTPUT_DIR/${DOC}.pdf"
  FAX="$SPOOL_DIR/${DOC}.fax"

  TITLE=$(grep "^@title" "$XTEX_FILE" | cut -c7-)
  AUTHOR=$(grep "^@author" "$XTEX_FILE" | cut -c9-)
  EQ=$(grep "^@equation" "$XTEX_FILE" | cut -c11-)
  BODY=$(grep "^@body" "$XTEX_FILE" | cut -c7-)

  cat > "$TEX" <<TEXEOF
\\documentclass{article}
\\title{$TITLE}
\\author{$AUTHOR}
\\begin{document}
$BODY
\\end{document}
TEXEOF

  if command -v xelatex >/dev/null 2>&1; then
    xelatex -interaction=nonstopmode "$TEX" >/dev/null; mv "${DOC}.pdf" "$PDF" 2>/dev/null || true
  else
    echo "[!] xelatex not found. .xtex expanded to $TEX successfully."
    echo "[!] bypass: .xtex -> python -> $PDF"
    python3 - <<PY
import sys
try:
    import fitz
    t=r"""${TITLE}""".replace('\q','q')
    a=r"""${AUTHOR}"""
    e=r"""${EQ}"""
    b=r"""${BODY}"""
    n="${DOC}"
    out="${PDF}"
    doc=fitz.open(); p=doc.new_page(width=595,height=842); y=40
    def w(txt, sz=11):
        global y
        for line in [txt[i:i+95] for i in range(0,len(txt),95)]:
            p.insert_text((50,y), line, fontsize=sz)
            y+=sz*1.5
            if y>800:
                p=doc.new_page(width=595,height=842); y=40
    w(t,14); w(a,8); w("FAX by oeneyeFAX — (0)b Evergreen 'N' AH (0)b jc",8); y+=8
    w("Analysis:",11); w(b,10); w(f"Eq: {e}",11)
    doc.save(out)
    print(f"[+] {out}")
except Exception as ex:
    print(f"fitz fail {ex}, using fpdf fallback")
    from fpdf import FPDF
    pdf=FPDF(); pdf.add_page(); pdf.set_font("Arial",size=12)
    pdf.cell(200,10,txt=r"""${TITLE}"""[:100],ln=True)
    pdf.cell(200,10,txt="FAX by oeneyeFAX — (0)b Evergreen",ln=True)
    pdf.multi_cell(0,8,txt=r"""${BODY}"""[:1000])
    pdf.output("${PDF}")
PY
  fi
  # FAX spool — oeneyeFAX
  echo "FAX TO: oeneye / FROM: ${DOC} / FILE: ${PDF} / TITLE: ${TITLE}" > "$FAX"
  cp "$PDF" "./sigma_0b_jc.pdf" 2>/dev/null || true
  echo "[FAX] $FAX queued"
done
echo "================================================================Pipeline Complete"
# auto fax line
export FAX_NAME="oeneye.c + oeneyepdf.c"
echo "FAX by ${FAX_NAME} — set by oeneye.c + oeneyepdf.c"
