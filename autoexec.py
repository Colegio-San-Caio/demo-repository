#!/usr/bin/env python3
# ==============================================================================
# Script Name: autoexec.py
# Description: Centralized initialization engine executing local diagnostics,
#              monograph compilation, and automated branch synchronization loops.
# ==============================================================================

import subprocess
import os
import sys
import time

def run_step(command_list, description):
    print(f"\n[*] Launching initialization block: {description}...")
    try:
        # Executes the targeted python modules using standard subprocess arrays
        result = subprocess.run(command_list, check=True)
        return True
    except subprocess.CalledProcessError as e:
        print(f"[-] Execution fault encountered during pipeline step: {e}")
        return False

def run_master_autoexec():
    print("=" * 72)
    print("     MOSFETQ AUTOEXEC ENGINE — CENTRALIZED SYSTEM RUNTIME LOOP  ")
    print("=" * 72)

    # 1. Step A: Initialize Database Schema Tables & Validation Checks
    if not run_step([sys.executable, "bunq_db.py"], "Relational Table Initialization"):
        sys.exit(1)
        
    if not run_step([sys.executable, "check_db_integrity.py"], "candiDB Systems Integrity Scan"):
        sys.exit(1)

    # 2. Step B: Compile Digital Monograph Report Assets
    if os.path.exists("oeneye_virtual_lab.py"):
        run_step([sys.executable, "oeneye_virtual_lab.py"], "ReportLab Monograph Compilation")
        
    if os.path.exists("build_manuscript.py"):
        run_step([sys.executable, "build_manuscript.py"], "Master Manuscript PDF Assembler")

    # 3. Step C: Synchronize Binary Database Snapshots and Code Upstream
    if os.path.exists("git_sync_ledger.py"):
        run_step([sys.executable, "git_sync_ledger.py"], "Relational Ledger Branch Synchronization")

    print("\n" + "=" * 72)
    print("[+] All core automation pipelines executed and verified successfully!")
    print("=" * 72)

if __name__ == "__main__":
    run_master_autoexec()
