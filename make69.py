import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: small, see-through
        b = ((x-60.0)**2)/(26.0*26.0) + ((y-38.0)**2)/(15.0*15.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-28)**2)**0.5 < 16: v = 255
        # big eyes: glass frog eyes look forward
        if ((x-50)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-50)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-70)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-70)**2 + (y-22)**2)**0.5 < 2: v = 0
        # mouth: small smile
        if 48 <= x <= 72 and 32 <= y <= 33: v = 0
        # SEE-THROUGH BELLY: clear window - you see inside
        if 48 <= x <= 72 and 38 <= y <= 48: v = 0
        # heart: tiny dot in belly - visible through glass
        if ((x-60)**2 + (y-43)**2)**0.5 < 2: v = 255
        # legs: thin, spread out
        if 34 <= x <= 40 and 44 <= y <= 54: v = 255
        if 80 <= x <= 86 and 44 <= y <= 54: v = 255
        # leaf: frog sits on leaf
        if 28 <= x <= 92 and 54 <= y <= 56: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm69.ximg","wb").write(header + comp)
open("rm69.raw","wb").write(raw)
print(f"made rm69.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
