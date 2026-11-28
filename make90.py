import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: Oak toad, SMALLEST toad in North America - tiny!
        b = ((x-60.0)**2)/(18.0*18.0) + ((y-38.0)**2)/(11.0*11.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-28)**2)**0.5 < 11: v = 255
        # eyes: big for tiny body
        if ((x-52)**2 + (y-22)**2)**0.5 < 4: v = 255
        if ((x-52)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-68)**2 + (y-22)**2)**0.5 < 4: v = 255
        if ((x-68)**2 + (y-22)**2)**0.5 < 2: v = 0
        # mouth: tiny
        if 52 <= x <= 68 and 31 <= y <= 32: v = 0
        # LIGHT STRIPE: oak toad signature - white/yellow stripe
        if 58 <= x <= 62 and 18 <= y <= 48: v = 0
        # warts: tiny
        if ((x-50)**2 + (y-40)**2)**0.5 < 1: v = 0
        if ((x-70)**2 + (y-40)**2)**0.5 < 1: v = 0
        # legs: tiny
        if 44 <= x <= 48 and 44 <= y <= 50: v = 255
        if 72 <= x <= 76 and 44 <= y <= 50: v = 255
        # ground
        if 32 <= x <= 88 and 56 <= y <= 58: v = 255
        # 90 marker: 9-0
        if 10 <= x <= 14 and 6 <= y <= 12: v = 255
        if 18 <= x <= 22 and 6 <= y <= 12: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm90.ximg","wb").write(header + comp)
open("rm90.raw","wb").write(raw)
print(f"made rm90.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
