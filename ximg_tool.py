# XIMG Registry Editor - Python version
# Usage: python3 ximg_tool.py kdp.ximg info
#        python3 ximg_tool.py kdp.ximg hex
#        python3 ximg_tool.py rm.ximg make-rm
import sys, zlib, pathlib

def load(fn):
    d = pathlib.Path(fn).read_bytes()
    assert d[0:4]==b'XIMG', "Not XIMG!"
    off = 14
    raw = zlib.decompress(d[off:])
    w = d[6] | (d[7]<<8)
    h = len(raw)//w
    return d, raw, w, h

def save(fn, raw, w=120, magic=b'XIMG', v0=1, v1=1):
    head = bytearray(14)
    head[0:4]=magic; head[4]=v0; head[5]=v1; head[6]=w&255; head[7]=(w>>8)&255
    comp = zlib.compress(bytes(raw), 9)
    pathlib.Path(fn).write_bytes(bytes(head)+comp)
    print(f"Saved {fn}: {14+len(comp)} bytes, raw {len(raw)}")

def info(fn):
    d, raw, w, h = load(fn)
    print(f"=== {fn} ===")
    print(f"Magic: {d[0:4]}")
    print(f"Version: {d[4]}.{d[5]}")
    print(f"Width: {w}  Height: {h}")
    print(f"Header 0-13: {d[:14].hex()}")
    print(f"Zlib 14-20: {d[14:20].hex()}")
    print(f"XIMG size: {len(d)}  RAW size: {len(raw)}  Compression: {len(raw)/len(d):.1f}x")
    print(f"First 16 raw: {raw[:16].hex()}")
    print(f"Pattern: {' '.join(f'{b:02x}' for b in raw[:4])} repeats? {all(raw[i]==raw[i%4] for i in range(100))}")

def hexdump(fn):
    d, raw, w, h = load(fn)
    for r in range(0, len(raw), 16):
        chunk = raw[r:r+16]
        hexs = ' '.join(f"{b:02x}" for b in chunk)
        asc = ''.join(chr(b) if 32<=b<127 else '.' for b in chunk)
        print(f"{r:04x}  {hexs:<47}  |{asc}|")

def make_rm():
    raw = bytearray([0]*7680)
    def box(x0,y0,w,h,v=255):
        for y in range(y0,y0+h):
            for x in range(x0,x0+w):
                if 0<=x<120 and 0<=y<64: raw[y*120+x]=v
    # R
    box(20,15,5,35); box(20,15,20,5); box(20,30,20,5); box(40,15,5,20); box(25,35,4,15); box(35,35,4,15)
    # M
    box(60,15,5,35); box(85,15,5,35); box(65,20,8,8); box(77,20,8,8); box(72,28,6,10)
    for i in range(120): raw[i]=0xFF if i%2==0 else 0x14
    for i in range(7680-120,7680): raw[i]=0xFF if i%2==0 else 0x14
    save("rm.ximg", raw)
    pathlib.Path("rm.raw").write_bytes(bytes(raw))
    print("rm.raw: 7680 bytes ✅")

def edit_byte(fn, offset, value):
    d, raw, w, h = load(fn)
    raw = bytearray(raw)
    raw[offset] = value
    out = fn.replace(".ximg", "_edited.ximg")
    save(out, raw, w)
    print(f"Byte {offset} = 0x{value:02x} -> {out}")

def compare():
    for fn in ["kdp.ximg","rm.ximg"]:
        try: info(fn); print()
        except Exception as e: print(fn, "missing:", e)

if __name__=="__main__":
    if len(sys.argv)<2:
        print("Usage: python3 ximg_tool.py <file> [info|hex]  OR  python3 ximg_tool.py make-rm  OR  python3 ximg_tool.py compare")
        sys.exit(1)
    if sys.argv[1]=="make-rm": make_rm()
    elif sys.argv[1]=="compare": compare()
    elif sys.argv[1]=="edit":
        # python3 ximg_tool.py edit kdp.ximg 0 FF
        edit_byte(sys.argv[2], int(sys.argv[3]), int(sys.argv[4],16))
    else:
        fn=sys.argv[1]; cmd=sys.argv[2] if len(sys.argv)>2 else "info"
        if cmd=="hex": hexdump(fn)
        else: info(fn)
