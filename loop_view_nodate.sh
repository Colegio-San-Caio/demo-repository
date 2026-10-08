#!/usr/bin/env bash
while true; do
clear
echo "=== VIEW LOOP AUTO — NO DATE COPYRIGHT ==="
date -u
echo ""
gh run list --workflow="pages.yml" -L 6
echo ""
LATEST=$(gh run list --workflow="pages.yml" -L 1 --json databaseId --jq '.[0].databaseId')
echo "latest: $LATEST"
gh run view $LATEST --log-failed 2>&1 | tail -n 15
echo ""
echo "--- FETCH LIVE PAGE FOOTER CHECK ---"
curl -s "https://colegio-san-caio.github.io/demo-repository/candiOQM_xTitin.html?ts=$(date +%s)" | grep -i -A2 -B2 "©\|footer\|All rights reserved\|minimum-box" | tail -n 30
echo ""
echo "URL: https://colegio-san-caio.github.io/demo-repository/candiOQM_xTitin.html?ts=now"
echo "Expected footer: © Colegio-San-Caio / Julia_Menge_eigenOENEYE / OENEYEbluh — Evergreen / No Date"
echo ""
sleep 12
done
