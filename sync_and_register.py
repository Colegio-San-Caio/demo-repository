#!/usr/bin/env python3
# ==============================================================================
# Script Name: sync_and_register.py
# Description: Dynamically imports generated Bunq Sandbox parameters to execute
#              authenticated webhook deployment routines via native urllib.
# ==============================================================================

import os
import json
import urllib.request
import urllib.error

CONFIG_PATH = "MOSFETQexchange/output/bunq_sandbox_config.json"
WEBHOOK_TARGET = "https://colegio-san-caio.github.io/demo-repository/index.html"

USER_ID = "0"
OENEYE_TOKEN = "OENEYE_MOCK_TOKEN_36883"

def execute_sync_pipeline():
    if not os.path.exists(CONFIG_PATH):
        print(f"[-] Execution failure: Config file {CONFIG_PATH} not found.")
        return

    with open(CONFIG_PATH, "r") as f:
        config = json.load(f)

    base_endpoint = config["api_endpoint"]
    target_route = f"{base_endpoint}user/{USER_ID}/notification-filter-url"

    print(f"[*] Initializing sync for Author: {config['author']} (ORCID: {config['orcid']})")
    print(f"[*] Target Station Coordinates: {config['station_coordinates']}")
    print(f"[*] Connecting telemetry pipeline via Oeneye token to: {target_route}")

    payload = {
        "notification_filters": [
            {
                "category": "MUTATION",
                "notification_target": WEBHOOK_TARGET
            }
        ]
    }

    data = json.dumps(payload).encode("utf-8")
    headers = {
        "Content-Type": "application/json",
        "Cache-Control": "no-cache",
        "X-Bunq-Client-Authentication": OENEYE_TOKEN
    }

    req = urllib.request.Request(target_route, data=data, headers=headers, method="POST")

    try:
        with urllib.request.urlopen(req, timeout=10) as response:
            print(f"[+] HTTP Status Code: {response.status}")
            print(f"[+] Route Map: {WEBHOOK_TARGET} <- Linked under Constraint [{config['axiom_constraint']}]")
    except urllib.error.HTTPError as e:
        print(f"[-] HTTP Transport failure: {e.code} - {e.reason}")
    except Exception as e:
        print(f"[-] Transport layer failure: {e}")

if __name__ == "__main__":
    execute_sync_pipeline()
