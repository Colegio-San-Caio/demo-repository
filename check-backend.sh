#!/bin/sh

URL="https://fieldberry-backend.onrender.com"
LOGFILE="backend_audit.log"

echo "=== Backend Audit: $(date -u) ===" | tee -a "$LOGFILE"

# Fetch root status endpoint and compute checksum
curl -sL "$URL" | tee response.json | sha256sum | tee -a "$LOGFILE"

echo "----------------------------------------" | tee -a "$LOGFILE"

