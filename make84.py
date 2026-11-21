import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: round, plump
        b = ((x-60.0)**2)/(24.0*24.0) + ((y-38.0)**2)/(15.0*15.0)
        if b < 1: v = 255
        # head: round
        if ((x-60)**2 + (y-28)**2)**0.5 < 15: v = 255
        # eyes: VERTICAL pupils - cat-like! spadefoot signature
        if ((x-50)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-50)**2 + (y-22)**2)**0.5 < 1.5: v = 0
        if 49 <= x <= 51 and 18 <= y <= 26: v = 0
        if ((x-70)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-70)**2 + (y-22)**2)**0.5 < 1.5: v = 0
        if 69 <= x <= 71 and 18 <= y <= 26: v = 0
        # mouth
        if 48 <= x <= 72 and 32 <= y <= 33: v = 0
        # SPADES: digging spades on hind feet - the namesake!
        if 36 <= x <= 42 and 50 <= y <= 54: v = 255
        if 78 <= x <= 84 and 50 <= y <= 54: v = 255
        if ((x-39)**2 + (y-56)**2)**0.5 < 2: v = 255
        if ((x-81)**2 + (y-56)**2)**0.5 < 2: v = 255
        # legs
        if 38 <= x <= 46 and 44 <= y <= 52: v = 255
        if 74 <= x <= 82 and 44 <= y <= 52: v = 255
        # desert sand
        if 24 <= x <= 96 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm84.ximg","wb").write(header + comp)
open("rm84.raw","wb").write(raw)
print(f"made rm84.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
