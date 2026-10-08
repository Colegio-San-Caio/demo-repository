#!/usr/bin/env bash
# ==============================================================================
# Script Name: status_check.sh
# Description: Diagnostic workspace audit for MOSFETQexchange / oeneyeFAX pipeline.
# ==============================================================================

echo "===================================================================="
echo " MOSFETQexchange & oeneyeFAX Pipeline Audit Status"
echo "===================================================================="
echo "[*] Timestamp: $(date -u +'%Y-%m-%d %H:%M:%S UTC')"
echo ""

echo "--- 1. Output Files ---"
if [ -d "MOSFETQexchange/output" ]; then
    ls -lh MOSFETQexchange/output/
else
    echo "[!] MOSFETQexchange/output directory missing."
fi

echo ""
echo "--- 2. Spool Queue ---"
if [ -d "MOSFETQexchange/spool/fax" ]; then
    ls -lh MOSFETQexchange/spool/fax/
else
    echo "[!] Spool directory missing."
fi

echo ""
echo "--- 3. Git Working Tree ---"
git status -s

echo "===================================================================="
echo " Framework Identity: 1 + 0 = 1 | PL:36883"
echo "===================================================================="
