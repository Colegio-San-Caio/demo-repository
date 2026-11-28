import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: round like a tomato
        b = ((x-60.0)**2)/(28.0*28.0) + ((y-38.0)**2)/(17.0*17.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-28)**2)**0.5 < 17: v = 255
        # eyes: small on top
        if ((x-50)**2 + (y-22)**2)**0.5 < 4: v = 255
        if ((x-50)**2 + (y-22)**2)**0.5 < 1.5: v = 0
        if ((x-70)**2 + (y-22)**2)**0.5 < 4: v = 255
        if ((x-70)**2 + (y-22)**2)**0.5 < 1.5: v = 0
        # mouth: straight line - tomato frog is grumpy
        if 44 <= x <= 76 and 32 <= y <= 33: v = 0
        # belly: lighter stripe
        if 48 <= x <= 72 and 46 <= y <= 48: v = 0
        # stubby legs: barely visible
        if 40 <= x <= 46 and 50 <= y <= 54: v = 255
        if 74 <= x <= 80 and 50 <= y <= 54: v = 255
        # ground
        if 30 <= x <= 90 and 56 <= y <= 58: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm71.ximg","wb").write(header + comp)
open("rm71.raw","wb").write(raw)
print(f"made rm71.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
