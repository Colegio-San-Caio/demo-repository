import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body
        b = ((x-60.0)**2)/(26.0*26.0) + ((y-38.0)**2)/(15.0*15.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-28)**2)**0.5 < 16: v = 255
        # RED eyes: huge, bulging
        if ((x-50)**2 + (y-24)**2)**0.5 < 6: v = 255
        if ((x-50)**2 + (y-24)**2)**0.5 < 2.5: v = 0
        if ((x-70)**2 + (y-24)**2)**0.5 < 6: v = 255
        if ((x-70)**2 + (y-24)**2)**0.5 < 2.5: v = 0
        # eye shine: tiny white dot
        if ((x-49)**2 + (y-23)**2)**0.5 < 1: v = 255
        if ((x-69)**2 + (y-23)**2)**0.5 < 1: v = 255
        # smile
        if 48 <= x <= 72 and 32 <= y <= 33: v = 0
        # belly
        if 46 <= x <= 74 and 46 <= y <= 48: v = 0
        # sticky toe pads: tree frog feet
        if 36 <= x <= 42 and 50 <= y <= 56: v = 255
        if 78 <= x <= 84 and 50 <= y <= 56: v = 255
        # branch
        if 24 <= x <= 96 and 56 <= y <= 58: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm70.ximg","wb").write(header + comp)
open("rm70.raw","wb").write(raw)
print(f"made rm70.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
