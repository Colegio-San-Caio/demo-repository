import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: Great Plains toad, big + flat
        b = ((x-60.0)**2)/(28.0*28.0) + ((y-38.0)**2)/(15.0*15.0)
        if b < 1: v = 255
        # head: wide, flat
        if ((x-60)**2 + (y-28)**2)**0.5 < 17: v = 255
        # eyes
        if ((x-48)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-48)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-72)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-72)**2 + (y-22)**2)**0.5 < 2: v = 0
        # mouth: wide
        if 42 <= x <= 78 and 32 <= y <= 33: v = 0
        # LIGHT STRIPE: Great Plains signature
        if 58 <= x <= 62 and 14 <= y <= 52: v = 0
        # warts: large, in dark blotches
        if ((x-46)**2 + (y-42)**2)**0.5 < 2: v = 0
        if ((x-74)**2 + (y-42)**2)**0.5 < 2: v = 0
        if ((x-60)**2 + (y-46)**2)**0.5 < 2: v = 0
        # parotoid glands: huge, kidney-shaped
        if ((x-34)**2 + (y-30)**2)**0.5 < 5: v = 255
        if ((x-86)**2 + (y-30)**2)**0.5 < 5: v = 255
        # legs: short, for burrowing
        if 36 <= x <= 44 and 46 <= y <= 54: v = 255
        if 76 <= x <= 84 and 46 <= y <= 54: v = 255
        # ground: prairie
        if 22 <= x <= 98 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm91.ximg","wb").write(header + comp)
open("rm91.raw","wb").write(raw)
print(f"made rm91.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
