import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: small, compact
        b = ((x-60.0)**2)/(22.0*22.0) + ((y-38.0)**2)/(13.0*13.0)
        if b < 1: v = 255
        # head: round
        if ((x-60)**2 + (y-28)**2)**0.5 < 14: v = 255
        # eyes: big, golden
        if ((x-50)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-50)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-70)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-70)**2 + (y-22)**2)**0.5 < 2: v = 0
        # mouth: small
        if 50 <= x <= 70 and 32 <= y <= 33: v = 0
        # EGGS: male carries eggs on back - dots on back legs!
        if ((x-36)**2 + (y-46)**2)**0.5 < 2: v = 0
        if ((x-36)**2 + (y-46)**2)**0.5 < 3: v = 255
        if ((x-84)**2 + (y-46)**2)**0.5 < 2: v = 0
        if ((x-84)**2 + (y-46)**2)**0.5 < 3: v = 255
        if ((x-42)**2 + (y-52)**2)**0.5 < 2: v = 0
        if ((x-42)**2 + (y-52)**2)**0.5 < 3: v = 255
        if ((x-78)**2 + (y-52)**2)**0.5 < 2: v = 0
        if ((x-78)**2 + (y-52)**2)**0.5 < 3: v = 255
        # legs
        if 38 <= x <= 46 and 44 <= y <= 54: v = 255
        if 74 <= x <= 82 and 44 <= y <= 54: v = 255
        # ground
        if 28 <= x <= 92 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm82.ximg","wb").write(header + comp)
open("rm82.raw","wb").write(raw)
print(f"made rm82.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
