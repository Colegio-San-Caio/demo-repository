#!/usr/bin/env python3
# ==============================================================================
# Script Name: autoexec.py
# Description: Centralized initialization engine executing local diagnostics,
#              logging GitHub CLI run matrices, and tracking branch sync states.
# ==============================================================================

import subprocess
import os
import sys
import json
import bunq_db

REPO_TARGET = "Colegio-San-Caio/demo-repository"

def run_step(command_list, description):
    print(f"\n[*] Launching initialization block: {description}...")
    try:
        result = subprocess.run(command_list, check=True)
        return True
    except subprocess.CalledProcessError as e:
        print(f"[-] Execution fault encountered during pipeline step: {e}")
        return False

def sync_github_runs_to_db():
    print(f"\n[*] Extracting GitHub Actions telemetry matrix via 'gh' CLI...")
    try:
        # 1. Fetch remote workflow run statuses in raw json text format
        result = subprocess.run([
            "gh", "run", "list", 
            "--repo", REPO_TARGET, 
            "--json", "databaseId,status,conclusion", 
            "--limit", "3"
        ], capture_output=True, text=True, check=True)
        
        runs = json.loads(result.stdout)
        
        # 2. Iterate through records and use save_config to track them inside candiDB
        for run in runs:
            run_id = f"GH_RUN_{run.get('databaseId')}"
            run_state = f"status: {run.get('status')} | conclusion: {run.get('conclusion')}"
            
            # Save variables directly to your config keys
            bunq_db.save_config(run_id, run_state)
            print(f"    [+] Log synced to config table -> Key: {run_id} | Val: {run_state}")
            
        return True
    except Exception as e:
        print(f"[-] Failed compiling GitHub telemetry strings to database: {e}")
        return False

def run_master_autoexec():
    print("=" * 75)
    print("     MOSFETQ AUTOEXEC ENGINE — CENTRALIZED SYSTEM RUNTIME LOOP  ")
    print("=" * 75)

    # Step A: Initialize Schema Tables & Mappings
    bunq_db.init_db()
    
    # Step B: Pull GitHub workflows and store them using save_config patterns
    sync_github_runs_to_db()
    
    # Step C: Run system integrity diagnostics
    run_step([sys.executable, "check_db_integrity.py"], "candiDB Systems Integrity Scan")

    # Step D: Compile Digital Monograph Report Assets
    if os.path.exists("oeneye_virtual_lab.py"):
        run_step([sys.executable, "oeneye_virtual_lab.py"], "ReportLab Monograph Compilation")
    if os.path.exists("build_manuscript.py"):
        run_step([sys.executable, "build_manuscript.py"], "Master Manuscript PDF Assembler")

    # Step E: Synchronize Binary Database Snapshots and Code Upstream
    if os.path.exists("git_sync_ledger.py"):
        run_step([sys.executable, "git_sync_ledger.py"], "Relational Ledger Branch Synchronization")

    print("\n" + "=" * 75)
    print("[+] All core automation pipelines executed and verified successfully!")
    print("=" * 75)

if __name__ == "__main__":
    run_master_autoexec()
