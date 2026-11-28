# oeneye-quantum 🐱⚛️

### ORNOP Cat Suite - Quantum Classical Gates
![Cat Diagram](cat-diagram.png)
![Logo](logo.png)

**ornop.qasm** = OR + NOP
- OR: `a,b -> a v b`
- NOP: phase-tracked no-op
- Cat: |ψ⟩ = α|alive⟩ + β|dead⟩

Built entirely on Android - Termux + Ubuntu proot
Author: clevjhon (oeneye@proton.me)

## Files
- `ornop.qasm` - ORNOP gate
- `omq.qasm` - OR + Measurement + Qubit cat
- `cat-diagram.png` - superposition diagram
- `logo.png` - qubit cat logo

## 🐛 Launchpad Bug #2170612 - Verified

[![Launchpad](https://img.shields.io/badge/Launchpad-Bug%20%232170612-critical?logo=launchpad)](https://bugs.launchpad.net/launchpad/+bug/2170612)
[![cURL](https://img.shields.io/badge/cURL-7.47.0%20verified-blue)](https://bugs.launchpad.net/launchpad/+bug/2170612)
[![SHA256](https://img.shields.io/badge/SHA256-5b35c475...-green)](BUG_REPORT.md)

- **cURL**: libcurl3-gnutls 7.47.0-1ubuntu2.19 - no source fetch, build died before curl
- **CHECKSUM**: SHA256 5b35c47516499f82bc23dd85d4146c8b04b9e4dd06141fc73d379817893f234 / MD5 66ecd534dc947e0b04d56e07c950583
- **Root**: snapd.socket missing in lp-xenial-s390x

## PPA - sandbox-ppa
PPA: https://launchpad.net/~oeneye/+archive/ubuntu/sandbox-ppa
Purpose: reproduce Xenial snap builder environment for Bug #2170612

# index.html - Kai Olaf Ketelhut - GitHub Pages

Live site: **https://kaiolafketelhut.github.io/index.html/**

One file, two projects. All built in Termux on Android.

## 1. BOA84 MAIL - OneEyeMail

Make email + write, in the browser, no server.

- To / Subject / Write
- Save Draft / Send
- Drafts / Sent list saved in `localStorage`
- Section: `id="boa84-mail-box"` in `index.html`

## 2. KDP.XIMG - TIER Project - 120 x 64 XIMG Image

A mystery 161-byte file, reverse-engineered to a real image.

| File | Size | What it is |
| --- | --- | --- |
| `kdp.ximg` | 161 bytes | XIMG container, `XIMG` + `01 01` + `78 9C` zlib at offset 14 |
| `kdp.raw` | 7680 bytes | Decompressed: `120 x 64` = 7680, 1 byte per pixel, grayscale |
| `kdp.png` | 1.2K | `120x64` enlarged to `480x256`, pixelated, for Pages |
| `kdp_decode.py` | - | Decoder: `XIMG -> PNG`, pure Python + Pillow |
| `index.html` | 714 lines | Shows `kdp.png` + download links |

### Proof

