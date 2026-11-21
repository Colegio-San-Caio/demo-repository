import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: FLAT, pancake-like - Surinam toads are super flat
        b = ((x-60.0)**2)/(32.0*32.0) + ((y-40.0)**2)/(11.0*11.0)
        if b < 1: v = 255
        # head: flat, triangular
        if ((x-60)**2 + (y-32)**2)**0.5 < 14: v = 255
        # eyes: tiny, on top
        if ((x-52)**2 + (y-26)**2)**0.5 < 3: v = 255
        if ((x-52)**2 + (y-26)**2)**0.5 < 1: v = 0
        if ((x-68)**2 + (y-26)**2)**0.5 < 3: v = 255
        if ((x-68)**2 + (y-26)**2)**0.5 < 1: v = 0
        # mouth: wide, flat
        if 44 <= x <= 76 and 34 <= y <= 35: v = 0
        # BACK POCKETS: eggs embedded in back - honeycomb dots!
        if ((x-48)**2 + (y-40)**2)**0.5 < 1.5: v = 0
        if ((x-60)**2 + (y-40)**2)**0.5 < 1.5: v = 0
        if ((x-72)**2 + (y-40)**2)**0.5 < 1.5: v = 0
        if ((x-54)**2 + (y-44)**2)**0.5 < 1.5: v = 0
        if ((x-66)**2 + (y-44)**2)**0.5 < 1.5: v = 0
        if ((x-60)**2 + (y-48)**2)**0.5 < 1.5: v = 0
        # legs: flat, star-shaped toes
        if 30 <= x <= 40 and 42 <= y <= 50: v = 255
        if 80 <= x <= 90 and 42 <= y <= 50: v = 255
        # water line
        if 16 <= x <= 104 and 56 <= y <= 57: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm83.ximg","wb").write(header + comp)
open("rm83.raw","wb").write(raw)
print(f"made rm83.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
