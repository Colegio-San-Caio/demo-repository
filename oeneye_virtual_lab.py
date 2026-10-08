#!/usr/bin/env python3
# ==============================================================================
# Script Name: oeneye_virtual_lab.py
# Description: Generates the oeneyeVirtualLab official PDF monograph asset
#              using ReportLab, logging the transaction sequence to SQLite.
# ==============================================================================

import os
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib import colors
import bunq_db

def generate_virtual_lab_pdf():
    # Ensure local relational database and directory paths exist
    bunq_db.init_db()
    output_dir = "MOSFETQexchange/output"
    os.makedirs(output_dir, exist_ok=True)
    pdf_path = os.path.join(output_dir, "oeneyeVirtualLab_Monograph.pdf")
    
    doc = SimpleDocTemplate(pdf_path, pagesize=letter, rightMargin=36, leftMargin=36, topMargin=36, bottomMargin=36)
    story = []
    
    styles = getSampleStyleSheet()
    title_style = ParagraphStyle(
        'TitleStyle',
        parent=styles['Heading1'],
        fontName='Helvetica-Bold',
        fontSize=16,
        leading=20,
        textColor=colors.HexColor('#1f2428')
    )
    body_style = ParagraphStyle(
        'BodyStyle',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=10,
        leading=14,
        textColor=colors.HexColor('#24292e')
    )
    
    story.append(Paragraph("OENEYEVIRTULLAB — ARCHITECTURAL SYSTEMICS & TELEMETRY", title_style))
    story.append(Spacer(1, 12))
    
    intro_text = """
    <b>Author / ORCID:</b> Kai Olaf Ketelhut (0000-0001-6049-8873)<br/>
    <b>Station Metadata:</b> Berlin, Germany (52.5200 N, 13.4050 E)<br/>
    <b>Axiom Constraint:</b> 1 + 0 = 1 | Namespace: NN | PL: 36883<br/>
    <b>Primary Target:</b> ISBN 9783000684630
    """
    story.append(Paragraph(intro_text, body_style))
    story.append(Spacer(1, 15))
    
    data = [
        ["Pipeline Component", "Target Reference / URI", "Status"],
        ["Acquisition Mask", "https://bunq.me/9783000684630", "Active"],
        ["Sandbox API", "https://public-api.sandbox.bunq.com/v1/", "Provisioned"],
        ["Static Portal", "https://colegio-san-caio.github.io/demo-repository/", "Synchronized"]
    ]
    
    t = Table(data, colWidths=[130, 260, 110])
    t.setStyle(TableStyle([
        ('BACKGROUND', (0,0), (-1,0), colors.HexColor('#eaecef')),
        ('TEXTCOLOR', (0,0), (-1,0), colors.HexColor('#24292e')),
        ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
        ('FONTSIZE', (0,0), (-1,-1), 9),
        ('BOTTOMPADDING', (0,0), (-1,0), 6),
        ('GRID', (0,0), (-1,-1), 0.5, colors.HexColor('#d1d5da')),
    ]))
    
    story.append(t)
    doc.build(story)
    
    # Commit execution milestone back to database log history
    bunq_db.log_event("MONOGRAPH_COMPILE", f"Successfully built oeneyeVirtualLab_Monograph.pdf")
    print(f"[+] oeneyeVirtualLab PDF asset successfully compiled at: {pdf_path}")

if __name__ == "__main__":
    generate_virtual_lab_pdf()
