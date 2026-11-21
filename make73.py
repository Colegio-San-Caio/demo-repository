import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: huge round Pac-Man shape
        b = ((x-60.0)**2)/(30.0*30.0) + ((y-38.0)**2)/(18.0*18.0)
        if b < 1: v = 255
        # head merged with body
        if ((x-60)**2 + (y-28)**2)**0.5 < 18: v = 255
        # PAC-MAN MOUTH: giant wedge cut out - wide open
        if 60 <= x <= 90 and 28 <= y <= 44:
            if abs(y-36) < (x-60)*0.5: v = 0
        # eyes: on top of head, looking up
        if ((x-50)**2 + (y-18)**2)**0.5 < 4: v = 255
        if ((x-50)**2 + (y-18)**2)**0.5 < 1.5: v = 0
        if ((x-70)**2 + (y-18)**2)**0.5 < 4: v = 255
        if ((x-70)**2 + (y-18)**2)**0.5 < 1.5: v = 0
        # stubby legs
        if 38 <= x <= 46 and 50 <= y <= 56: v = 255
        if 74 <= x <= 82 and 50 <= y <= 56: v = 255
        # ground
        if 28 <= x <= 92 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm73.ximg","wb").write(header + comp)
open("rm73.raw","wb").write(raw)
print(f"made rm73.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
