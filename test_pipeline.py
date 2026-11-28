import os
import subprocess

def test_c_compilation():
    print("Testing C compiler integration...")
    res = subprocess.run(["gcc", "oeneyepdf.c", "-o", "oeneyepdf"], capture_output=True, text=True)
    assert res.returncode == 0, f"Compilation failed: {res.stderr}"
    print("C compiler test passed.")

def test_pdf_generation():
    print("Testing native PDF generation...")
    res = subprocess.run(["./oeneyepdf"], capture_output=True, text=True)
    assert res.returncode == 0, f"Execution failed: {res.stderr}"
    assert os.path.exists("fat77_pipeline_report.pdf"), "PDF report was not generated."
    print("PDF generation test passed.")

def test_main_lib_parsing():
    print("Testing MAIN.LIB presence and readability...")
    assert os.path.exists("MAIN.LIB"), "MAIN.LIB configuration file missing."
    print("MAIN.LIB test passed.")

if __name__ == "__main__":
    test_c_compilation()
    test_pdf_generation()
    test_main_lib_parsing()
    print("All pipeline unit tests passed successfully!")
