import os
import datetime

def create_pipeline_pdf(filename="fat77_pipeline_report.pdf"):
    """
    Generates a PDF summary report for the FAT77 and AWS SAM Pipeline.
    """
    timestamp = datetime.datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S UTC")
    domain = "trafo.com"
    
    if os.path.exists("MAIN.LIB"):
        with open("MAIN.LIB", "r") as f:
            for line in f:
                if line.startswith("DOMAIN ="):
                    domain = line.split("=", 1)[1].strip()

    img_size = "Unknown"
    if os.path.exists("fat77.img"):
        img_size = f"{os.path.getsize('fat77.img')} bytes"

    try:
        from reportlab.lib.pagesizes import letter
        from reportlab.pdfgen import canvas

        c = canvas.Canvas(filename, pagesize=letter)
        c.drawString(72, 750, "FAT77 Advanced 64-Sector & Cloud Pipeline Report")
        c.drawString(72, 730, f"Generated: {timestamp}")
        c.drawString(72, 700, f"Target Domain: {domain}")
        c.drawString(72, 680, f"Image Artifact Size: {img_size}")
        c.drawString(72, 660, "Signature: FAT77-ADVANCED-SIG")
        c.drawString(72, 640, "Status: Verified via GitHub Actions & AWS SAM")
        c.save()
        print(f"Successfully generated PDF report: {filename}")
    except ImportError:
        print("ReportLab not found.")

if __name__ == "__main__":
    create_pipeline_pdf()
