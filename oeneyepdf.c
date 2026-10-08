#!/usr/bin/env python3
import os
NAME = os.environ.get("FAX_NAME", "oeneye.c + oeneyepdf.c")
FAX_LINE = f"FAX by {NAME} — set by oeneye.c + oeneyepdf.c — FAX by oeneyeFAX — PL:36883 g=0"
print(FAX_LINE)
