import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: BIG, chunky cane toad
        b = ((x-60.0)**2)/(30.0*30.0) + ((y-40.0)**2)/(17.0*17.0)
        if b < 1: v = 255
        # head: wide
        if ((x-60)**2 + (y-30)**2)**0.5 < 19: v = 255
        # eyes: with bony brow ridge
        if ((x-48)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-48)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-72)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-72)**2 + (y-22)**2)**0.5 < 2: v = 0
        # brow ridge
        if 40 <= x <= 56 and 16 <= y <= 18: v = 255
        if 64 <= x <= 80 and 16 <= y <= 18: v = 255
        # PAROTOID GLANDS: big poison glands behind eyes - cane toad signature
        if ((x-38)**2 + (y-30)**2)**0.5 < 4: v = 255
        if ((x-82)**2 + (y-30)**2)**0.5 < 4: v = 255
        # mouth: straight
        if 38 <= x <= 82 and 34 <= y <= 35: v = 0
        # warts
        if ((x-52)**2 + (y-42)**2)**0.5 < 1.5: v = 0
        if ((x-68)**2 + (y-42)**2)**0.5 < 1.5: v = 0
        # legs: short, sturdy
        if 34 <= x <= 42 and 46 <= y <= 56: v = 255
        if 78 <= x <= 86 and 46 <= y <= 56: v = 255
        # ground
        if 22 <= x <= 98 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm81.ximg","wb").write(header + comp)
open("rm81.raw","wb").write(raw)
print(f"made rm81.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
