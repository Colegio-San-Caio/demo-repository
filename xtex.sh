#!/usr/bin/env bash
set -e
mkdir -p MOSFETQexchange/output MOSFETQexchange/spool/fax MOSFETQexchange/spool/vnc
export FAX_NAME="oeneye.c + oeneyepdf.c"
echo "FAX by $FAX_NAME"
python3 oeneyepdf.c
ls -lh MOSFETQexchange/output/
