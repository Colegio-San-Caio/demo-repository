#!/usr/bin/env python3
# ==============================================================================
# Script Name: compile_fuzz_report.py
# Description: Automatically processes flat CSV fuzz sheets to compile an official
#              ReportLab verification ledger report template.
# ==============================================================================

import os
import csv
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib import colors

CSV_INPUT = "fuzz_check.csv"
OUTPUT_PDF = "MOSFETQexchange/output/fuzz_verification_report.pdf"

def build_fuzz_pdf_report():
    print("=" * 75)
    print("    MOSFETQ REPORT CORE — AUTOMATED FUZZ VERIFICATION COMPILER")
    print("=" * 75)

    if not os.path.exists(CSV_INPUT):
        print(f"[-] Compilation error: Source data mapping sheet {CSV_INPUT} missing.")
        return

    os.makedirs(os.path.dirname(OUTPUT_PDF), exist_ok=True)
    story = []
    
    # Initialize Core Paragraph Styling Matrix
    styles = getSampleStyleSheet()
    title_style = ParagraphStyle(
        'FuzzReportTitle',
        parent=styles['Heading1'],
        fontName='Helvetica-Bold',
        fontSize=16,
        leading=20,
        textColor=colors.HexColor('#1f2428')
    )
    
    story.append(Paragraph("<b>MOSFETQ — .FUZZ SYSTEM COMPLIANCE VERIFICATION REPORT</b>", title_style))
    story.append(Spacer(1, 15))

    # Define structural grid headers for our data rows matrix
    table_data = [["ID", "Buchungsdatum", "ISBN / Referenzschlüssel", "Kanal-Zuweisung", "Brutto-Betrag"]]

    # Read flat CSV rows and parse them cleanly into our table cell matrix
    with open(CSV_INPUT, "r", encoding="utf-8") as f:
        reader = csv.reader(f, delimiter="|")
        for row in reader:
            if len(row) >= 5:
                # Add currency sign formatting directly to gross totals column cells
                row[4] = f"€{float(row[4]):.2f}"
                table_data.append(row)

    print(f"[*] Parsing data records directly from source tracker: {CSV_INPUT}")
    print(f"    - Extracted data matrix rows: {len(table_data) - 1} entries")

    # Render ReportLab Table element with strict column padding definitions
    t = Table(table_data, colWidths=[35, 75, 130, 140, 90])
    t.setStyle(TableStyle([
        ('BACKGROUND', (0,0), (-1,0), colors.HexColor('#24292e')),
        ('TEXTCOLOR', (0,0), (-1,0), colors.white),
        ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
        ('FONTSIZE', (0,0), (-1,-1), 9),
        ('GRID', (0,0), (-1,-1), 0.5, colors.HexColor('#d1d5da')),
        ('ROWBACKGROUNDS', (0,1), (-1,-1), [colors.white, colors.HexColor('#f6f8fa')]),
        ('BOTTOMPADDING', (0,0), (-1,-1), 6),
        ('ALIGN', (4,0), (4,-1), 'RIGHT')
    ]))
    
    story.append(t)
    doc = SimpleDocTemplate(OUTPUT_PDF, pagesize=letter, rightMargin=36, leftMargin=36, topMargin=36, bottomMargin=36)
    doc.build(story)
    
    print(f"[+] Compliance document successfully compiled! Asset written to: {OUTPUT_PDF}")
    print("=" * 75)

if __name__ == "__main__":
    build_fuzz_pdf_report()
