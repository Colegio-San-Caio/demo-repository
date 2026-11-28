import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: Arizona toad, medium
        b = ((x-60.0)**2)/(25.0*25.0) + ((y-38.0)**2)/(15.0*15.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-28)**2)**0.5 < 15: v = 255
        # eyes
        if ((x-50)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-50)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-70)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-70)**2 + (y-22)**2)**0.5 < 2: v = 0
        # mouth
        if 46 <= x <= 74 and 32 <= y <= 33: v = 0
        # LIGHT STRIPE: Arizona signature
        if 58 <= x <= 62 and 15 <= y <= 50: v = 0
        # warts: small, many, in dark spots
        if ((x-47)**2 + (y-41)**2)**0.5 < 1.3: v = 0
        if ((x-73)**2 + (y-41)**2)**0.5 < 1.3: v = 0
        if ((x-54)**2 + (y-45)**2)**0.5 < 1.3: v = 0
        if ((x-66)**2 + (y-45)**2)**0.5 < 1.3: v = 0
        # parotoid glands: oval, separated
        if ((x-37)**2 + (y-30)**2)**0.5 < 4: v = 255
        if ((x-83)**2 + (y-30)**2)**0.5 < 4: v = 255
        # legs
        if 37 <= x <= 44 and 45 <= y <= 54: v = 255
        if 76 <= x <= 83 and 45 <= y <= 54: v = 255
        # ground: desert stream
        if 25 <= x <= 95 and 58 <= y <= 60: v = 255
        if 30 <= x <= 90 and 56 <= y <= 57: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm93.ximg","wb").write(header + comp)
open("rm93.raw","wb").write(raw)
print(f"made rm93.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
