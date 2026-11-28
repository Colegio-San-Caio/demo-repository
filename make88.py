import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: Fowler's toad, slender
        b = ((x-60.0)**2)/(24.0*24.0) + ((y-38.0)**2)/(14.0*14.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-28)**2)**0.5 < 14: v = 255
        # eyes
        if ((x-50)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-50)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-70)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-70)**2 + (y-22)**2)**0.5 < 2: v = 0
        # mouth
        if 48 <= x <= 72 and 32 <= y <= 33: v = 0
        # WARTS: 3+ warts per spot - Fowler's signature vs American's 1-2
        if ((x-46)**2 + (y-40)**2)**0.5 < 1.2: v = 0
        if ((x-50)**2 + (y-42)**2)**0.5 < 1.2: v = 0
        if ((x-48)**2 + (y-44)**2)**0.5 < 1.2: v = 0
        if ((x-70)**2 + (y-40)**2)**0.5 < 1.2: v = 0
        if ((x-74)**2 + (y-42)**2)**0.5 < 1.2: v = 0
        if ((x-72)**2 + (y-44)**2)**0.5 < 1.2: v = 0
        if ((x-60)**2 + (y-46)**2)**0.5 < 1.2: v = 0
        # parotoid glands: touch cranial crest
        if ((x-38)**2 + (y-30)**2)**0.5 < 3: v = 255
        if ((x-82)**2 + (y-30)**2)**0.5 < 3: v = 255
        # legs: long, for hopping
        if 36 <= x <= 44 and 44 <= y <= 54: v = 255
        if 76 <= x <= 84 and 44 <= y <= 54: v = 255
        # ground
        if 24 <= x <= 96 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm88.ximg","wb").write(header + comp)
open("rm88.raw","wb").write(raw)
print(f"made rm88.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
