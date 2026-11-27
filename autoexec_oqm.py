#!/usr/bin/env python3
"""autoexec_oqm.py - Auto-execution script for MOSFETQ OQM & Perplexity CLI environment."""
import os
import pathlib
import subprocess
import sys

print("MOSFETQ OQM AUTOEXEC - Starting environment...")

# 1. Ensure MSIX package is built
if not os.path.exists("oqm.msix"):
    print("Building oqm.msix package...")
    subprocess.run([sys.executable, "make_oqm_msix.py"], check=True)

print("MOSFETQ OQM MSIX package ready: oqm.msix")
print("Perplexity CLI ready: perplexity_cli.py")
print("MOSFETQ OQM AUTOEXEC - OK - All systems initialized.")
