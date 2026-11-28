import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: MASSIVE - biggest frog in the world
        b = ((x-60.0)**2)/(32.0*32.0) + ((y-40.0)**2)/(18.0*18.0)
        if b < 1: v = 255
        # head: wide, flat
        if ((x-60)**2 + (y-30)**2)**0.5 < 20: v = 255
        # eyes: on top
        if ((x-47)**2 + (y-21)**2)**0.5 < 5: v = 255
        if ((x-47)**2 + (y-21)**2)**0.5 < 2: v = 0
        if ((x-73)**2 + (y-21)**2)**0.5 < 5: v = 255
        if ((x-73)**2 + (y-21)**2)**0.5 < 2: v = 0
        # mouth: huge
        if 36 <= x <= 84 and 34 <= y <= 36: v = 0
        # belly
        if 42 <= x <= 78 and 48 <= y <= 50: v = 0
        # GIANT hind legs: folded, powerful
        if 28 <= x <= 38 and 42 <= y <= 58: v = 255
        if 82 <= x <= 92 and 42 <= y <= 58: v = 255
        # front legs
        if 44 <= x <= 48 and 50 <= y <= 56: v = 255
        if 72 <= x <= 76 and 50 <= y <= 56: v = 255
        # rock
        if 18 <= x <= 102 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm76.ximg","wb").write(header + comp)
open("rm76.raw","wb").write(raw)
print(f"made rm76.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
