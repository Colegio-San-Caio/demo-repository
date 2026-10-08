#!/usr/bin/env python3
# ==============================================================================
# Script Name: bunq_db.py
# Description: Refined SQLite3 relational data engine managing telemetry states 
#              and credential maps via upsert query operations.
# ==============================================================================

import sqlite3
import os

DB_PATH = "MOSFETQexchange/output/telemetry.db"

def init_db():
    os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS config (
            key TEXT PRIMARY KEY,
            value TEXT
        )
    """)
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS telemetry_logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
            event_type TEXT,
            details TEXT
        )
    """)
    conn.commit()
    conn.close()

def save_config(key, value):
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("REPLACE INTO config (key, value) VALUES (?, ?)", (key, value))
    conn.commit()
    conn.close()

def get_config(key):
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT value FROM config WHERE key = ?", (key,))
    row = cursor.fetchone()
    conn.close()
    return row[0] if row else None

def log_event(event_type, details):
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO telemetry_logs (event_type, details) VALUES (?, ?)", (event_type, details))
    conn.commit()
    conn.close()

if __name__ == "__main__":
    init_db()
    print(f"[+] Relational core engine online at: {DB_PATH}")
