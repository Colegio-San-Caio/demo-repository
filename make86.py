import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: green toad, round
        b = ((x-60.0)**2)/(24.0*24.0) + ((y-38.0)**2)/(15.0*15.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-28)**2)**0.5 < 15: v = 255
        # eyes: golden, horizontal
        if ((x-50)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-50)**2 + (y-22)**2)**0.5 < 2: v = 0
        if 46 <= x <= 54 and 21 <= y <= 23: v = 0
        if ((x-70)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-70)**2 + (y-22)**2)**0.5 < 2: v = 0
        if 66 <= x <= 74 and 21 <= y <= 23: v = 0
        # mouth
        if 48 <= x <= 72 and 32 <= y <= 33: v = 0
        # GREEN SPOTS: dark green blotches - green toad signature
        if ((x-48)**2 + (y-40)**2)**0.5 < 3: v = 0
        if ((x-72)**2 + (y-40)**2)**0.5 < 3: v = 0
        if ((x-60)**2 + (y-46)**2)**0.5 < 3: v = 0
        # parotoid glands
        if ((x-38)**2 + (y-30)**2)**0.5 < 3: v = 255
        if ((x-82)**2 + (y-30)**2)**0.5 < 3: v = 255
        # legs
        if 38 <= x <= 46 and 44 <= y <= 54: v = 255
        if 74 <= x <= 82 and 44 <= y <= 54: v = 255
        # ground
        if 26 <= x <= 94 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm86.ximg","wb").write(header + comp)
open("rm86.raw","wb").write(raw)
print(f"made rm86.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
