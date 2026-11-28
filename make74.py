import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: big, beefy
        b = ((x-60.0)**2)/(30.0*30.0) + ((y-40.0)**2)/(16.0*16.0)
        if b < 1: v = 255
        # head: wide
        if ((x-60)**2 + (y-30)**2)**0.5 < 19: v = 255
        # eyes: big, on top
        if ((x-48)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-48)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-72)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-72)**2 + (y-22)**2)**0.5 < 2: v = 0
        # EAR: bullfrog has huge eardrum - circle behind eye
        if ((x-40)**2 + (y-30)**2)**0.5 < 3: v = 0
        if ((x-80)**2 + (y-30)**2)**0.5 < 3: v = 0
        # mouth: wide, straight
        if 38 <= x <= 82 and 34 <= y <= 35: v = 0
        # belly
        if 44 <= x <= 76 and 48 <= y <= 50: v = 0
        # powerful hind legs
        if 32 <= x <= 40 and 44 <= y <= 56: v = 255
        if 80 <= x <= 88 and 44 <= y <= 56: v = 255
        # pond water
        if 20 <= x <= 100 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm74.ximg","wb").write(header + comp)
open("rm74.raw","wb").write(raw)
print(f"made rm74.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
