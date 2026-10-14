#!/bin/sh
URL="https://fieldberry-backend.onrender.com"
LOGFILE="backend_audit.log"
echo "=== Backend Audit: $(date -u) ===" | tee -a "$LOGFILE"
curl -sL "$URL" > response.json
sed "s/\"time\":\"[^\"]*\"//" response.json | sha256sum | tee -a "$LOGFILE"
echo "----------------------------------------" | tee -a "$LOGFILE"
