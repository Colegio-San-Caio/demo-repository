import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: Red-spotted toad, flat + small
        b = ((x-60.0)**2)/(22.0*22.0) + ((y-38.0)**2)/(13.0*13.0)
        if b < 1: v = 255
        # head: very flat
        if ((x-60)**2 + (y-28)**2)**0.5 < 13: v = 255
        # eyes
        if ((x-51)**2 + (y-22)**2)**0.5 < 4: v = 255
        if ((x-51)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-69)**2 + (y-22)**2)**0.5 < 4: v = 255
        if ((x-69)**2 + (y-22)**2)**0.5 < 2: v = 0
        # mouth
        if 50 <= x <= 70 and 32 <= y <= 33: v = 0
        # RED SPOTS: red-spotted signature - red dots on back!
        if ((x-50)**2 + (y-40)**2)**0.5 < 1.2: v = 0
        if ((x-70)**2 + (y-40)**2)**0.5 < 1.2: v = 0
        if ((x-60)**2 + (y-44)**2)**0.5 < 1.2: v = 0
        if ((x-55)**2 + (y-46)**2)**0.5 < 1.2: v = 0
        if ((x-65)**2 + (y-46)**2)**0.5 < 1.2: v = 0
        # parotoid glands: round, small
        if ((x-40)**2 + (y-30)**2)**0.5 < 3: v = 255
        if ((x-80)**2 + (y-30)**2)**0.5 < 3: v = 255
        # legs: for climbing rocks
        if 40 <= x <= 46 and 44 <= y <= 52: v = 255
        if 74 <= x <= 80 and 44 <= y <= 52: v = 255
        # ground: rocky
        if 28 <= x <= 92 and 58 <= y <= 60: v = 255
        if 30 <= x <= 34 and 56 <= y <= 58: v = 255
        if 86 <= x <= 90 and 56 <= y <= 58: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm92.ximg","wb").write(header + comp)
open("rm92.raw","wb").write(raw)
print(f"made rm92.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
