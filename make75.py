import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: slim, climbing
        b = ((x-60.0)**2)/(22.0*22.0) + ((y-36.0)**2)/(14.0*14.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-26)**2)**0.5 < 14: v = 255
        # eyes: big, sideways
        if ((x-50)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-50)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-70)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-70)**2 + (y-22)**2)**0.5 < 2: v = 0
        # mouth: smile
        if 50 <= x <= 70 and 30 <= y <= 31: v = 0
        # STRIPE: tree frogs have a side stripe
        if 40 <= x <= 80 and 38 <= y <= 39: v = 0
        # legs: gripping branch, spread wide
        if 30 <= x <= 38 and 38 <= y <= 50: v = 255
        if 82 <= x <= 90 and 38 <= y <= 50: v = 255
        # toe pads: round discs
        if ((x-32)**2 + (y-52)**2)**0.5 < 3: v = 255
        if ((x-88)**2 + (y-52)**2)**0.5 < 3: v = 255
        # vertical branch
        if 58 <= x <= 62 and 8 <= y <= 58: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm75.ximg","wb").write(header + comp)
open("rm75.raw","wb").write(raw)
print(f"made rm75.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
