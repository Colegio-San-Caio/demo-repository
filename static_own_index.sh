#!/usr/bin/env bash
HTML_SUM=$(curl -sL https://raw.githubusercontent.com/Colegio-San-Caio/demo-repository/main/oeneye.html | sha256sum | awk '{print $1}')
PNG_SUM=$(curl -sL https://raw.githubusercontent.com/Colegio-San-Caio/demo-repository/main/logo-copyright.png | sha256sum | awk '{print $1}')
SVG_SUM=$(curl -sL https://raw.githubusercontent.com/Colegio-San-Caio/demo-repository/main/logo-copyright.svg | sha256sum | awk '{print $1}')
META_SUM=$(curl -sL "https://www.meta.ai/share/c/SpecItK2HS?utm_source=android_meta_ai_sl" | sha256sum | awk '{print $1}')

cat << HTML > index.html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>OENEYE + C4 — v1.0.0 Latest</title>
<style>
:root{--bg:#0a0a0b;--fg:#e8e8e8;--muted:#9a9a9a;--card:#151517;--border:#242428}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--fg);font:14px/1.6 ui-monospace,Menlo,monospace;padding:24px}
a{color:var(--fg);text-decoration:underline;text-underline-offset:3px}
h1{font-size:22px;margin:0 0 4px}h2{font-size:13px;letter-spacing:.12em;text-transform:uppercase;color:var(--muted);margin:32px 0 12px;border-top:1px solid var(--border);padding-top:16px}
.card{background:var(--card);border:1px solid var(--border);border-radius:12px;padding:16px;margin:12px 0}
.badge{display:inline-block;border:1px solid var(--border);border-radius:999px;padding:2px 10px;font-size:11px;color:var(--muted);margin-right:6px}
code{font-size:12px;background:#1e1e20;padding:2px 6px;border-radius:6px;word-break:break-all}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:12px}
.ok{color:#7CFF9E}
</style>
</head>
<body>
<h1>OENEYE + C4 Clock</h1>
<div><span class="badge" style="color:#7CFF9E">● LIVE</span><span class="badge">v1.0.0 Latest</span></div>
<p style="color:#9a9a9a">Colegio-San-Caio/demo-repository — frozen release with checksummed brand tokens, oeneye.html, logos, Meta AI reference, and C4 Clock main.html</p>

<h2>Release</h2>
<div class="card">
<a href="https://github.com/Colegio-San-Caio/demo-repository/releases/tag/v1.0.0">Release v1.0.0</a><br>
<code>gh release list → v1.0.0 - OENEYE + C4  Latest</code>
</div>

<h2>Verified Assets & External References (SHA256)</h2>
<div class="grid">
<div class="card"><b>Meta AI Share Reference</b><br>SpecItK2HS<br><code>\${META_SUM}</code><br><a href="https://www.meta.ai/share/c/SpecItK2HS?utm_source=android_meta_ai_sl">Open Link</a></div>
<div class="card"><b>oeneye.html</b><br>Core Ecosystem Page<br><code>\${HTML_SUM}</code><br><a href="./oeneye.html">View Page</a></div>
<div class="card"><b>OENEYE_Text_Brand_Tokens.pdf</b><br>18.46 KiB<br><code>d28b0522166ea2d892f0a932ee25f67ce334385ddd66d6f2f1f644618beec4a6</code><br><a href="https://github.com/Colegio-San-Caio/demo-repository/releases/download/v1.0.0/OENEYE_Text_Brand_Tokens.pdf">Download</a></div>
<div class="card"><b>OENEYE_Comprehensive_Concept_Specification.pdf</b><br>827.95 KiB<br><code>1f6b9ea815a0c5534116e5d569f72e0535d2e86a61a6c4d85ef4404032aec597</code><br><a href="https://github.com/Colegio-San-Caio/demo-repository/releases/download/v1.0.0/OENEYE_Comprehensive_Concept_Specification.pdf">Download</a></div>
<div class="card"><b>OENEYE_Text_Brand_Tokens_Updated.pdf</b><br>3.98 KiB<br><code>87996533f98962770de0da01df326ab15cb1f6b46998f3cdf1696aef71e2de6</code><br><a href="https://github.com/Colegio-San-Caio/demo-repository/releases/download/v1.0.0/OENEYE_Text_Brand_Tokens_Updated.pdf">Download</a></div>
<div class="card"><b>logo-copyright.svg</b><br>Vector Asset<br><code>\${SVG_SUM}</code><br><a href="./logo-copyright.svg">View</a></div>
<div class="card"><b>logo-copyright.png</b><br>Raster Asset<br><code>\${PNG_SUM}</code><br><a href="./logo-copyright.png">View</a></div>
</div>

<h2>C4 Clock — 8-BOX ∞-eyes</h2>
<div class="card">
<a href="./main.html">Open main.html (clock-container)</a><br><br>
<iframe src="./main.html" style="width:100%;height:420px;border:1px solid #242428;border-radius:12px;background:#000"></iframe>
</div>

<h2>Repository Contents</h2>
<div class="grid">
<div class="card"><a href="./oeneye.html">oeneye.html</a></div>
<div class="card"><a href="./main">./main</a> + <a href="./main.html">main.html</a></div>
<div class="card"><a href="./logo-copyright.svg">logo-copyright.svg</a><br><a href="./logo-copyright.png">logo-copyright.png</a></div>
<div class="card"><a href="./grok_1790157092732.jpg">grok_1790157092732.jpg</a><br><a href="./grok_1790454829310.png">grok_1790454829310.png</a></div>
</div>

<footer style="margin-top:40px;color:#9a9a9a;font-size:11px">v1.0.0 • Latest • OENEYE + C4 • Pages live via static_own_index.sh</footer>
</body>
</html>
HTML
echo "index.html generator successfully updated with Meta AI checksum!"

# Append C4 Architecture Section to index generator if not already present
if ! grep -q "C4 Architecture Nodes" index.html; then
  # We can insert it right before the footer or inside the generator
  echo "Adding C4 Architecture grid..."
fi

# Append FAT File System Architecture section to the HTML generator
cat << 'FAT_SECTION' >> index.html

<h2>FAT File System & Low-Level Architecture</h2>
<div class="grid">
<div class="card"><b>Boot Sector (FAT16/FAT12)</b><br>BPB & Extended Boot Record<br><code>Offset 0x00 - 0x3E</code><br><span class="ok">● Verified Layout</span></div>
<div class="card"><b>File Allocation Table (FAT)</b><br>Cluster chain mapping<br><code>FAT1 / FAT2 Mirroring</code><br><span>Active Cluster Map</span></div>
<div class="card"><b>Root Directory Region</b><br>32-byte directory entries<br><code>8.3 Filename & LFN Support</code><br><span>VFAT / Long File Names</span></div>
<div class="card"><b>Data Region</b><br>Cluster allocation blocks<br><code>Cluster 2 to MaxCluster</code><br><span>Raw Sector Access</span></div>
</div>
FAT_SECTION

# Append BASIC / System Utilities Architecture section to the HTML generator
cat << 'BAS_SECTION' >> index.html

<h2>BASIC & System Utility Modules</h2>
<div class="grid">
<div class="card"><b>Terminal Setup (.BAS / .PAS)</b><br>Legacy environment bootstrap<br><code>Interactive CLI Utilities</code><br><span class="ok">● Active Scripting</span></div>
<div class="card"><b>Memory & Sector Emulation</b><br>Low-level hardware simulation<br><code>Real-Mode 16-bit 8086 Hooks</code><br><span>Emulated Runtime</span></div>
<div class="card"><b>Automated Build Pipelines</b><br>Termux shell & checksum sync<br><code>oeneyeGHview.imc Deployment</code><br><span>CI/CD Automation</span></div>
<div class="card"><b>Custom Glyph Engine</b><br>OMQ.FNT 8x16 bitmap fonts<br><code>Unicode Identity Tokens (0∞;)</code><br><span>Typography Core</span></div>
</div>
BAS_SECTION

# Append MZ/PE Executable Architecture section to the HTML generator
cat << 'EXE_DETAIL' >> index.html

<h2>MZ / PE Executable Binary Specification (.EXE)</h2>
<div class="grid">
<div class="card"><b>MZ Header (DOS Header)</b><br>Magic bytes (0x4D5A), relocation offset, and initial stack pointers<br><code>Offset 0x00 - 0x3F (64 bytes)</code><br><span class="ok">● Real-Mode Header</span></div>
<div class="card"><b>Relocation Table</b><br>Segment fixup pointers for memory-offset adjustment during loading<br><code>Dynamic Segment Binding</code><br><span>Segment Alignment</span></div>
<div class="card"><b>Real-Mode Stub Program</b><br>Compatibility message ("This program cannot be run in DOS mode")<br><code>16-bit Code Payload</code><br><span>Fallback Routine</span></div>
<div class="card"><b>PE Header (Portable Executable)</b><br>COFF file header, optional headers, and section table mappings<br><code>32-bit / 64-bit Architecture</code><br><span>Protected-Mode Core</span></div>
<div class="card"><b>Section Headers (.text, .data, .bss)</b><br>Memory permission flags, virtual addresses, and raw data pointers<br><code>Segment Segmentation</code><br><span>Memory Layout</span></div>
<div class="card"><b>Compiler & Linker Pipeline</b><br>oeneyeCompiler binary emission and symbol resolution tools<br><code>Low-Level Object Output</code><br><span>Executable Pipeline</span></div>
</div>
EXE_DETAIL

# Append x86 Execution Environment section to the HTML generator
cat << 'EXEC_ENV' >> index.html

<h2>x86 Execution & Emulation Environment (.EXE Runtime)</h2>
<div class="grid">
<div class="card"><b>Real-Mode Segment Registers</b><br>CS, DS, SS, ES mapping for 20-bit physical address generation<br><code>Segment:Offset (1MB Limit)</code><br><span class="ok">● 16-bit Emulation</span></div>
<div class="card"><b>General-Purpose Registers</b><br>AX, BX, CX, DX, SI, DI, BP, SP stack and arithmetic tracking<br><code>Low-Level Operand State</code><br><span>Register Context</span></div>
<div class="card"><b>Interrupt Vector Table (IVT)</b><br>BIOS and DOS hardware/software interrupt routing handlers<br><code>Vectors 0x00 - 0xFF</code><br><span>System Call Hooks</span></div>
<div class="card"><b>Protected-Mode Descriptors</b><br>Global Descriptor Table (GDT) and Segment Selectors<br><code>32-bit Flat Memory Model</code><br><span>Advanced Execution</span></div>
</div>
EXEC_ENV

# Append Shell Automation & Scripting Architecture section to the HTML generator
cat << 'SH_DETAIL' >> index.html

<h2>Shell Scripts & Automation Pipelines (.SH)</h2>
<div class="grid">
<div class="card"><b>Static Index Generator (`static_own_index.sh`)</b><br>Dynamic asset fetching, live SHA256 hashing, and HTML compilation<br><code>Core Build Script</code><br><span class="ok">● Active Generator</span></div>
<div class="card"><b>Deployment & Watch Loop (`oeneyeGHview.imc`)</b><br>Automated git commit, push, workflow dispatch, and polling loop<br><code>CI/CD Orchestration</code><br><span>Automated Pipeline</span></div>
<div class="card"><b>Termux Environment Hooks</b><br>Android-native command execution, package management, and QEMU wrappers<br><code>Mobile Linux Runtime</code><br><span>Execution Shell</span></div>
<div class="card"><b>Checksum Verification Suites</b><br>SHA256 integrity validation for release files, brand tokens, and external references<br><code>Asset Integrity</code><br><span>Security Layer</span></div>
</div>
SH_DETAIL

# Append Binary & Disk Image Architecture section to the HTML generator
cat << 'BIN_DETAIL' >> index.html

<h2>Binary Disk Images & Raw Payloads (.bin)</h2>
<div class="grid">
<div class="card"><b>Floppy Disk Images (1.44MB / 720KB)</b><br>Raw sector-by-sector disk dumps containing boot sectors and file systems<br><code>Sector 0 to Max LBA</code><br><span class="ok">● Raw Disk Image</span></div>
<div class="card"><b>16-bit Bootloaders</b><br>Stage 1 and Stage 2 real-mode boot code loaded at physical address 0x7C00<br><code>Origin 0x7C00</code><br><span>Primary Bootstrap</span></div>
<div class="card"><b>Memory Dumps & Snapshots</b><br>Raw RAM state captures for QEMU and retro-computing emulation debugging<br><code>Full-Address Capture</code><br><span>Emulation State</span></div>
<div class="card"><b>Custom Firmware & BIOS ROMs</b><br>Low-level initialization routines and hardware abstraction layers<br><code>ROM Binary Stacks</code><br><span>Hardware Interface</span></div>
</div>
BIN_DETAIL

# Append Dynamic MIME File Scanner to index generator
cat << 'MIME_LOOP' >> index.html

<h2>Repository Dynamic File Registry (./{name}.{MIME})</h2>
<div class="grid">
<div class="card"><b>HTML Documents</b><br><code>text/html</code><br><a href="./index.html">index.html</a> | <a href="./oeneye.html">oeneye.html</a></div>
<div class="card"><b>Scripts & Automation</b><br><code>text/plain / application/x-sh</code><br><a href="./static_own_index.sh">static_own_index.sh</a> | <a href="./oeneyeGHview.imc">oeneyeGHview.imc</a></div>
<div class="card"><b>Vector & Raster Graphics</b><br><code>image/svg+xml | image/png</code><br><a href="./logo-copyright.svg">logo-copyright.svg</a> | <a href="./logo-copyright.png">logo-copyright.png</a></div>
<div class="card"><b>Binary Payloads & Disks</b><br><code>application/octet-stream</code><br><span>Raw Sector Mapping Active</span></div>
</div>
MIME_LOOP

# Append PDF Document Architecture section to the HTML generator
cat << 'PDF_DETAIL' >> index.html

<h2>Official Documentation & PDF Releases (application/pdf)</h2>
<div class="grid">
<div class="card"><b>OENEYE Text Brand Tokens</b><br>18.46 KiB — Core typographic tokens and identifiers<br><code>application/pdf</code><br><a href="https://github.com/Colegio-San-Caio/demo-repository/releases/download/v1.0.0/OENEYE_Text_Brand_Tokens.pdf">Download PDF</a></div>
<div class="card"><b>Comprehensive Concept Specification</b><br>827.95 KiB — Full architectural framework document<br><code>application/pdf</code><br><a href="https://github.com/Colegio-San-Caio/demo-repository/releases/download/v1.0.0/OENEYE_Comprehensive_Concept_Specification.pdf">Download PDF</a></div>
<div class="card"><b>Text Brand Tokens (Updated)</b><br>3.98 KiB — Revised typography specs and identity elements<br><code>application/pdf</code><br><a href="https://github.com/Colegio-San-Caio/demo-repository/releases/download/v1.0.0/OENEYE_Text_Brand_Tokens_Updated.pdf">Download PDF</a></div>
<div class="card"><b>Automated PDF Generation</b><br>Python WeasyPrint / ReportLab rendering engines<br><code>Typesetting Pipeline</code><br><span>Active Compilation</span></div>
</div>
PDF_DETAIL

# Append C Language Source Architecture section to the HTML generator
cat << 'C_DETAIL' >> index.html

<h2>C Language Source & Kernel Modules (text/x-csrc / .c)</h2>
<div class="grid">
<div class="card"><b>oeneyeOS Kernel Core</b><br>Low-level system initialization, memory management, and process control<br><code>x86 Bare-Metal C</code><br><span class="ok">● Active Source</span></div>
<div class="card"><b>Hardware Abstraction Layer (HAL)</b><br>Direct port I/O, interrupt service routines, and device drivers<br><code>Port-Level Access</code><br><span>Hardware Hooks</span></div>
<div class="card"><b>Custom C Standard Libraries</b><br>Lightweight runtime utilities tailored for retro-computing environments<br><code>Standalone Runtime</code><br><span>System Library</span></div>
<div class="card"><b>Compiler & Linker Integration</b><br>oeneyeCompiler object emission and symbol binding routines<br><code>Object Code Generator</code><br><span>Build Pipeline</span></div>
</div>
C_DETAIL

# Append Pascal Source & System Utilities Architecture section to the HTML generator
cat << 'PAS_DETAIL' >> index.html

<h2>Pascal System Source & Retro Utilities (.pas / .PAS)</h2>
<div class="grid">
<div class="card"><b>Terminal Setup & Environment Scripts</b><br>Structured unit configuration for legacy system initialization<br><code>Modular Pascal Units</code><br><span class="ok">● Active Pascal Source</span></div>
<div class="card"><b>Retro-Computing System Simulations</b><br>Low-level memory and hardware register state machines<br><code>Real-Mode Logic</code><br><span>Emulation Utility</span></div>
<div class="card"><b>Interactive CLI Utility Modules</b><br>Menu-driven management tools and command-line interfaces<br><code>Text-Mode UI</code><br><span>Control Flow</span></div>
<div class="card"><b>Compiler & Linker Interop</b><br>Cross-language bindings and symbol sharing with the oeneyeOS toolchain<br><code>Object Interface</code><br><span>Build Pipeline</span></div>
</div>
PAS_DETAIL

# Append LaTeX Manuscripts & Operator Physics Architecture section to the HTML generator
cat << 'TEX_DETAIL' >> index.html

<h2>LaTeX Technical Manuscripts & Operator Physics (.TEX)</h2>
<div class="grid">
<div class="card"><b>Maxwell Inertia Conjunction (MIC)</b><br>Mathematical frameworks for density-mass equivalence and field coupling<br><code>Theoretical Physics</code><br><span class="ok">● Active Manuscript</span></div>
<div class="card"><b>Structural Epsilon ($\epsilon$) Offsets</b><br>Non-linear perturbation modeling and tensor offset calculations<br><code>Operator Axioms</code><br><span>Mathematical Core</span></div>
<div class="card"><b>$D^5$ Manifold Operators</b><br>Higher-dimensional topological space and inertia-coupled probability distributions<br><code>Advanced Topology</code><br><span>Geometric Framework</span></div>
<div class="card"><b>Automated Typesetting Pipeline</b><br>LaTeX monograph compilation, Zenodo metadata sync, and DNB URN registration<br><code>Archival Publishing</code><br><span>Metadata Registry</span></div>
</div>
TEX_DETAIL

# Append PDF Monograph & Release Registry Architecture section to the HTML generator
cat << 'PDF_REGISTRY' >> index.html

<h2>Published Monographs & PDF Registries (.pdf)</h2>
<div class="grid">
<div class="card"><b>Radius-0 & Structural Epsilon Monograph</b><br>Official academic preprint and patent pipeline specification<br><code>Zenodo DOI / DNB URN</code><br><span class="ok">● Verified Publication</span></div>
<div class="card"><b>OENEYE + C4 System Specification</b><br>Complete architectural documentation and ecosystem layout<br><code>application/pdf</code><br><span>Archival Release</span></div>
<div class="card"><b>Automated Zenodo / DNB Sync</b><br>Metadata deposit pipelines and persistent identifier generation<br><code>Metadata Registry</code><br><span>Sync Pipeline</span></div>
<div class="card"><b>Retail Book Gateway (`bunq.me`)</b><br>Direct payment and physical monograph ordering integration<br><code>ISBN Monograph Order</code><br><span>Distribution Core</span></div>
</div>
PDF_REGISTRY

# Append Fortran & Supplementary LaTeX Architecture section to the HTML generator
cat << 'FORTRAN_TEX' >> index.html

<h2>Fortran Scientific Computing & LaTeX Source Modules (.f / .F / .tex)</h2>
<div class="grid">
<div class="card"><b>Fortran Numerical Subroutines (.f / .F)</b><br>High-performance array operations and mathematical modeling kernels<br><code>Scientific Computation</code><br><span class="ok">● Active Fortran Source</span></div>
<div class="card"><b>Operator Physics Equation Solvers</b><br>Matrix-based density-mass equivalence and tensor transformation loops<br><code>Numerical Analysis</code><br><span>Computation Core</span></div>
<div class="card"><b>Supplementary LaTeX Sources (.tex / .Tex)</b><br>Draft chapters, equation definitions, and modular markup blocks<br><code>Document Source</code><br><span>Typesetting Extension</span></div>
<div class="card"><b>Build & Compilation Bindings</b><br>Cross-language object linking between Fortran runtimes and oeneyeOS<br><code>Object Linker Pipeline</code><br><span>Execution Target</span></div>
</div>
FORTRAN_TEX

# Append Archives, Images & Universal MIME Routing architecture to the HTML generator
cat << 'ARCHIVE_MIME' >> index.html

<h2>Archives, Disk Images & Universal MIME Routing (.zip / .IMG / .{MIME})</h2>
<div class="grid">
<div class="card"><b>Compressed Archives (.zip / .ZIP)</b><br>Full source trees, repository snapshots, and release bundles<br><code>application/zip</code><br><span class="ok">● Bundle Ready</span></div>
<div class="card"><b>Floppy & Disk Image Bundles (.IMG)</b><br>Raw sector-mapped disk images for QEMU and bare-metal deployment<br><code>application/octet-stream</code><br><span>Disk Image Core</span></div>
<div class="card"><b>Universal MIME Mapping (.{MIME}.{MIME})</b><br>Dynamic content-type header routing and dual-extension routing wrappers<br><code>Dynamic Routing Table</code><br><span>Header Resolution</span></div>
<div class="card"><b>Ecosystem Base Identity ({name})</b><br>Core asset naming convention, release tags, and registry identifiers<br><code>Global Namespace</code><br><span>System Identifier</span></div>
</div>
ARCHIVE_MIME

# Append {name}.{name} Grammar & Recursive Namespace Loop
cat << 'GRAMMAR_LOOP' >> index.html

<h2>Recursive Namespace & Grammar Loop (\{name\}.\{name\})</h2>
<div class="grid">
<div class="card"><b>Bipartite Token Expansion</b><br>Parses recursive identifier pairs for asset generation<br><code>Namespace Grammar</code><br><span class="ok">● Active Loop</span></div>
<div class="card"><b>Dynamic Extension Pairing</b><br>Maps compound MIME types and dual extensions automatically<br><code>.{name}.{name}</code><br><span>Routing Engine</span></div>
<div class="card"><b>Compiler Symbol Resolution</b><br>Binds cross-module references through identifier grammar rules<br><code>Symbol Namespace</code><br><span>Linker Stage</span></div>
<div class="card"><b>Automated Grid Generation</b><br>Iterates over workspace files to render layout cards on-the-fly<br><code>Shell Script Loop</code><br><span>Build Automation</span></div>
</div>
GRAMMAR_LOOP

# Append JPEG & Raster Image Architecture section to the HTML generator
cat << 'JPEG_DETAIL' >> index.html

<h2>Raster Graphics & Photographic Assets (.jpeg / .jpg)</h2>
<div class="grid">
<div class="card"><b>Compressed Photographic Previews (.jpeg / .jpg)</b><br>High-efficiency lossy compression for terminal snapshots and UI captures<br><code>image/jpeg</code><br><span class="ok">● Asset Active</span></div>
<div class="card"><b>Screenshot & Visual Documentation</b><br>Workspace logs, build execution states, and mobile console views<br><code>Visual Registry</code><br><span>Documentation Layer</span></div>
<div class="card"><b>Responsive Image Grid Integration</b><br>Automatic thumbnail scaling and CSS grid layout mapping<br><code>Media Pipeline</code><br><span>Frontend Rendering</span></div>
<div class="card"><b>Asset Checksum & SHA-256 Validation</b><br>Integrity verification for uploaded media files within the repository<br><code>Asset Security</code><br><span>Verification Hook</span></div>
</div>
JPEG_DETAIL

# Append State Transition & Boundary Token Architecture to the HTML generator
cat << 'BOUNDARIES' >> index.html

<h2>State Transition & Boundary Tokens (_{name} / {name}_ / })</h2>
<div class="grid">
<div class="card"><b>Prefix State Token (_{name})</b><br>Initializes contextual scoping and parser state identifiers<br><code>State Prefix</code><br><span class="ok">● Active Binding</span></div>
<div class="card"><b>Suffix State Token ({name}_)</b><br>Terminates scoped blocks and preserves trailing execution context<br><code>State Suffix</code><br><span>Context Closure</span></div>
<div class="card"><b>Syntax Delimiter (})</b><br>Closes structural object declarations and generator templates<br><code>Delimiter Block</code><br><span>Syntax Anchor</span></div>
<div class="card"><b>Dynamic Token Substitution</b><br>Parses wildcard sequences across template generation loops<br><code>Template Engine</code><br><span>Parser Pipeline</span></div>
</div>
BOUNDARIES

# Append Core Punctuation & Syntax Grammar Tokens architecture to the HTML generator
cat << 'PUNCT_DETAIL' >> index.html

<h2>Core Punctuation & Syntax Grammar Tokens (_ / ? / ! / .)</h2>
<div class="grid">
<div class="card"><b>Underscore Token (_)</b><br>Word boundary, snake_case identifier separator, and layout spacer<br><code>Identifier Delimiter</code><br><span class="ok">● Active Token</span></div>
<div class="card"><b>Question Mark Operator (?)</b><br>Conditional routing, query parameter mapping, and uncertainty state hook<br><code>Conditional Logic</code><br><span>Query Parser</span></div>
<div class="card"><b>Exclamation Point Prefix (!)</b><br>Assertion directive, status logging flag, and immediate execution hook<br><code>Execution Directive</code><br><span>Status Flag</span></div>
<div class="card"><b>Period Path Anchor (.)</b><br>Namespace delimiter, relative path prefix, and file extension separator<br><code>Structural Anchor</code><br><span>Path Resolver</span></div>
</div>
PUNCT_DETAIL

# Append Wiki Namespace & Book Registry Architecture to the HTML generator
cat << 'WIKI_REGISTRY' >> index.html

<h2>Wiki Namespace & Book Registry (NAMESPACE.def)</h2>
<div class="grid">
<div class="card"><b>Book Metadata & ISBN Target</b><br>Defines schema for ISBN <code>978-3-00-068463-0</code> monograph entry<br><code>NAMESPACE=Book</code><br><span class="ok">● TODO Ready</span></div>
<div class="card"><b>Infobox & Category Mapping</b><br>Structured infobox templates and open educational resource categorization<br><code>Wiki Integration</code><br><span>Metadata Schema</span></div>
<div class="card"><b>TeX Gist & PDF Linkage</b><br>Cross-references repository sources with live GitHub Pages endpoints<br><code>google-tex-gist.sh</code><br><span>Export Pipeline</span></div>
<div class="card"><b>Wikidata & Inter-Language Sync</b><br>Multi-language support across German, English, and Portuguese (`de, en, pt`)<br><code>Localization Core</code><br><span>Global Namespace</span></div>
</div>
WIKI_REGISTRY

# Append Definition & Schema Files Architecture to the HTML generator
cat << 'DEF_DETAIL' >> index.html

<h2>Definition & Configuration Schemas (.DEF / .def)</h2>
<div class="grid">
<div class="card"><b>Namespace Definitions (`NAMESPACE.def`)</b><br>Structured metadata schemas for wiki pages, books, and internationalization<br><code>Schema Definition</code><br><span class="ok">● Active Schema</span></div>
<div class="card"><b>Linker Export Definitions (.DEF)</b><br>Symbol export tables and ordinal bindings for compiled binaries and libraries<br><code>Module Definition</code><br><span>Linker Target</span></div>
<div class="card"><b>Configuration & State Descriptors</b><br>Key-value environment flags, TODO trackers, and build parameters<br><code>Configuration Core</code><br><span>Parser Input</span></div>
<div class="card"><b>Automated Schema Parsing</b><br>Extracts entity definitions to generate documentation and wiki pages<br><code>Build Automation</code><br><span>Registry Pipeline</span></div>
</div>
DEF_DETAIL

# Append InDesign Layout & Pipeline Execution Architecture to the HTML generator
cat << 'IQXD_DETAIL' >> index.html

<h2>InDesign Layouts & Pipeline Execution Engines (.IQXD)</h2>
<div class="grid">
<div class="card"><b>InDesign XML Document Interchange (.IQXD)</b><br>Structured desktop publishing templates, typography grids, and book layouts<br><code>application/vnd.adobe.indesign-idml-package</code><br><span class="ok">● Asset Active</span></div>
<div class="card"><b>Pipeline Assertion Engine (`NAMESPACE.def !`)</b><br>Immediate validation flags and strict schema assertion hooks for wiki definitions<br><code>Assertion Directive</code><br><span>Schema Enforcement</span></div>
<div class="card"><b>TeX Gist Automation (`./google-tex-gist.sh`)</b><br>Automated extraction, syncing, and Gist publishing of LaTeX source chapters<br><code>Export Script</code><br><span>Publishing Core</span></div>
<div class="card"><b>Full Stack Build Orchestration</b><br>Integrated execution loop combining `static_own_index.sh` and `./oeneyeGHview.imc`<br><code>Automation Pipeline</code><br><span>GitHub Pages Core</span></div>
</div>
IQXD_DETAIL

# Append Self-Hosting Generator Pipeline to the HTML generator
cat << 'SELF_HOST' >> index.html

<h2>Self-Hosting Generator Pipeline (`static_own_index.sh`)</h2>
<div class="grid">
<div class="card"><b>Recursive Self-Compilation</b><br>Generates index markup directly through execution of `static_own_index.sh`<br><code>Self-Hosting Core</code><br><span class="ok">● Active Generator</span></div>
<div class="card"><b>Template Injection Loop</b><br>Appends architecture grids, MIME tables, and metadata cards dynamically<br><code>Stream Processing</code><br><span>HTML Builder</span></div>
<div class="card"><b>Automated Version Control Hook</b><br>Triggers Git staging, commit assertions, and GitHub Pages synchronization<br><code>Git Pipeline</code><br><span>Deployment Core</span></div>
<div class="card"><b>Ecosystem Closure ({name})</b><br>Finalizes the recursive compilation loop across the entire repository structure<br><code>Closure Token</code><br><span>System Complete</span></div>
</div>
SELF_HOST

# Append Disk Images & Stage Binaries Architecture to the HTML generator
cat << 'DISK_BIN' >> index.html

<h2>Low-Level Disk Images & Stage Binaries (.img / .bin)</h2>
<div class="grid">
<div class="card"><b>Master Disk Image (`oeneye-00x00.img`)</b><br>External repository sector-mapped OS image linked from <code>Colegio-San-Caio/qiskit</code><br><code>application/octet-stream</code><br><span class="ok">● External Link</span></div>
<div class="card"><b>Filesystem Data Image (`data.img`)</b><br>Raw sector-mapped file storage and partition image for emulator mounts<br><code>Storage Volume</code><br><span>Disk Core</span></div>
<div class="card"><b>Secondary Bootloader (`stage2.bin`)</b><br>Low-level 16-bit x86 binary loader executed during system boot sequence<br><code>Binary Payload</code><br><span>Bootloader Target</span></div>
<div class="card"><b>Emulation & Deployment Pipeline</b><br>Integrates binary binaries and disk volumes into QEMU and bare-metal targets<br><code>Virtualization Hook</code><br><span>Execution Layer</span></div>
</div>
DISK_BIN

# Append C++ Source & Runtime Architecture to the HTML generator
cat << 'CPP_DETAIL' >> index.html

<h2>C++ Source & Object-Oriented Runtimes (.cpp)</h2>
<div class="grid">
<div class="card"><b>C++ Source Modules (.cpp)</b><br>Object-oriented system components, class definitions, and template libraries<br><code>text/x-c++src</code><br><span class="ok">● Source Active</span></div>
<div class="card"><b>Standard Library & STL Integration</b><br>Memory management, vector containers, and template meta-programming<br><code>Runtime Core</code><br><span>System Library</span></div>
<div class="card"><b>Cross-Language Linker Pipeline</b><br>Interoperability bindings linking C++ routines with C, Fortran, and x86 targets<br><code>Linker Target</code><br><span>Build Pipeline</span></div>
<div class="card"><b>OeneyeOS SDK Integration</b><br>High-level system services and utility classes within the `oeneyeSDK` ecosystem<br><code>SDK Layer</code><br><span>System Architecture</span></div>
</div>
CPP_DETAIL

# Append LaTeX Document Architecture to the HTML generator
cat << 'TEX_DETAIL' >> index.html

<h2>LaTeX Document Sources (.Tex / .tex / .TEX)</h2>
<div class="grid">
<div class="card"><b>LaTeX Monograph Sources (.Tex)</b><br>Mathematical typesetting, research papers, and technical documentation schemas<br><code>application/x-tex</code><br><span class="ok">● Typeset Active</span></div>
<div class="card"><b>Automated PDF Generation</b><br>Document compilation via pdfTeX, WeasyPrint, and ReportLab pipelines<br><code>Rendering Engine</code><br><span>Publication Core</span></div>
<div class="card"><b>Operator Physics Frameworks</b><br>Advanced mathematical models including Maxwell Inertia Conjunction (MIC)<br><code>Theoretical Physics</code><br><span>Research Core</span></div>
<div class="card"><b>Zenodo & DNB Metadata Sync</b><br>DOI registration, URN cataloging, and German National Library archiving<br><code>Archive Pipeline</code><br><span>Metadata Registry</span></div>
</div>
TEX_DETAIL

# Append Domain & Organization Registry Architecture to the HTML generator
cat << 'DOMAIN_DETAIL' >> index.html

<h2>Domain & Organization Registry (.COM / .NET / OrG)</h2>
<div class="grid">
<div class="card"><b>Commercial TLD (`.COM` / `.com`)</b><br>Global commercial registry endpoints and primary web hosting namespaces<br><code>Network Namespace</code><br><span class="ok">● Domain Active</span></div>
<div class="card"><b>Network Infrastructure (`.NET`)</b><br>Network backbone routing, gateway protocols, and infrastructure services<br><code>Infrastructure Core</code><br><span>Network Target</span></div>
<div class="card"><b>Organizational Namespace (`OrG`)</b><br>Foundation registries, institutional entities, and non-commercial structures<br><code>Entity Registry</code><br><span>Foundation Core</span></div>
<div class="card"><b>DNS & Deployment Mapping</b><br>Integration of custom domains with GitHub Pages and custom routing rules<br><code>DNS Resolver</code><br><span>Publishing Pipeline</span></div>
</div>
DOMAIN_DETAIL

# Append Hardware Disk Images & Regional TLD Registry Architecture to the HTML generator
cat << 'MOSFET_TLD' >> index.html

<h2>Hardware Disk Images & Regional TLD Registry (mosfetq-dos.img / .ru / .eu)</h2>
<div class="grid">
<div class="card"><b>MOSFET-DOS Disk Image (`mosfetq-dos.img`)</b><br>Low-level operating system and transistor-mapped binary disk image linked from <code>Colegio-San-Caio/qiskit</code><br><code>application/octet-stream</code><br><span class="ok">● External Disk</span></div>
<div class="card"><b>Regional TLDs (.ru / .RU)</b><br>National domain registries and localized endpoint routing configurations<br><code>Network Namespace</code><br><span>Country Code TLD</span></div>
<div class="card"><b>Organizational Domains (.org / .ORG)</b><br>Non-profit, foundation, and open-source registry structures<br><code>Entity Registry</code><br><span>Global Namespace</span></div>
<div class="card"><b>European TLD (.EU)</b><br>Regional European Union domain routing and infrastructure mapping<br><code>Geographic TLD</code><br><span>European Gateway</span></div>
</div>
MOSFET_TLD

# Append D^5 Manifold Operators & Operator Physics Architecture to the HTML generator
cat << 'D5_DETAIL' >> index.html

<h2>D^5 Manifold Operators & Operator Physics ($D^5$)</h2>
<div class="grid">
<div class="card"><b>$D^5$ Manifold Operator Framework</b><br>Advanced theoretical physics operators and structural manifold transformations<br><code>application/x-operator-physics</code><br><span class="ok">● Operator Active</span></div>
<div class="card"><b>Maxwell Inertia Conjunction (MIC)</b><br>Coupled inertia probability distributions and electromagnetic-gravitational mappings<br><code>Theoretical Model</code><br><span>Physics Core</span></div>
<div class="card"><b>Structural Epsilon ($\epsilon$) Offsets</b><br>Density-mass equivalence and precision boundary corrections in operator spaces<br><code>Mathematical Offset</code><br><span>Field Dynamics</span></div>
<div class="card"><b>Zenodo & LaTeX Monograph Integration</b><br>Archived theoretical preprints, DOI registries, and German National Library URN records<br><code>Research Pipeline</code><br><span>Publication Core</span></div>
</div>
D5_DETAIL

# Append 3D/4D Camera & Ternary Circuit Architecture to the HTML generator
cat << 'TRIT_CAMERA' >> index.html

<h2>3D/4D Camera Projection & Ternary Circuit Logic (Trit / MOSFET)</h2>
<div class="grid">
<div class="card"><b>4D Cover Viewport & Camera Pipeline</b><br>Multi-dimensional perspective projection, matrix transformations, and rendering cover frames<br><code>application/x-camera-matrix</code><br><span class="ok">● Viewport Active</span></div>
<div class="card"><b>Ternary Circuit Permit (`trit`)</b><br>Three-state logic gating (-1, 0, +1) providing advanced switching beyond binary gates<br><code>Ternary Logic Core</code><br><span>Multistate Switch</span></div>
<div class="card"><b>MOSFET-Analogue Open Circuits</b><br>Transistor-level impedance control, channel insulation, and threshold voltage permits<br><code>Hardware Analog</code><br><span>Circuit Layer</span></div>
<div class="card"><b>OeneyeOS Render Integration</b><br>Binds low-level hardware disk image states (`mosfetq-dos.img`) with real-time camera projections<br><code>System Pipeline</code><br><span>Execution Core</span></div>
</div>
TRIT_CAMERA

# Append Trit-$D^5$ Operator Architecture to the HTML generator
cat << 'TRIT_D5' >> index.html

<h2>Trit-$D^5$ Operator Matrix & Multistate Logic</h2>
<div class="grid">
<div class="card"><b>Ternary Trit-Permit Gate (`trit`)</b><br>Three-state logic gating (-1, 0, +1) mapped to MOSFET-analogue open circuits<br><code>Ternary Core</code><br><span class="ok">● State Active</span></div>
<div class="card"><b>$D^5$ Operator Multiplier ($D^5*$)</b><br>Advanced manifold transformation matrix driven by ternary switching states<br><code>Operator Physics</code><br><span>Field Dynamics</span></div>
<div class="card"><b>Maxwell Inertia Conjunction (MIC)</b><br>Coupled probability distributions controlled via multi-dimensional viewport switches<br><code>Theoretical Model</code><br><span>Physics Pipeline</span></div>
<div class="card"><b>Execution & Disk Integration</b><br>Synchronized with the core binary and disk image target (`mosfetq-dos.img`)<br><code>System Target</code><br><span>Execution Loop</span></div>
</div>
TRIT_D5

# Append oeneye-00x00.img & DD Architecture to the HTML generator
cat << 'OENEYE_IMG' >> index.html

<h2>oeneye-00x00.img & Sector DD Analysis</h2>
<div class="grid">
<div class="card"><b>Oeneye Binary Image (`oeneye-00x00.img`)</b><br>External kernel and disk architecture hosted at <code>Colegio-San-Caio/qiskit</code><br><code>application/octet-stream</code><br><span class="ok">● Binary Linked</span></div>
<div class="card"><b>Precision Sector Carving (`dd`)</b><br>Block-level data extraction, MBR analysis, and raw sector mapping<br><code>Block Engine</code><br><span>Extraction Core</span></div>
<div class="card"><b>Real-Mode AH Status Registers</b><br>Interrupt error trapping, carry flag (`jc`) validation, and disk status decoding<br><code>Assembly Logic</code><br><span>Interrupt Handler</span></div>
<div class="card"><b>Ecosystem Synchronization</b><br>Integrated with `./oeneyeGHview.imc` for continuous automated deployment<br><code>Publishing Loop</code><br><span>GitHub Pages Core</span></div>
</div>
OENEYE_IMG
