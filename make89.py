import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: Woodhouse's toad, large
        b = ((x-60.0)**2)/(27.0*27.0) + ((y-38.0)**2)/(16.0*16.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-28)**2)**0.5 < 16: v = 255
        # eyes
        if ((x-49)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-49)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-71)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-71)**2 + (y-22)**2)**0.5 < 2: v = 0
        # mouth
        if 44 <= x <= 76 and 32 <= y <= 33: v = 0
        # LIGHT STRIPE: Woodhouse's signature - light stripe down back
        if 58 <= x <= 62 and 16 <= y <= 52: v = 0
        # warts: dark, many
        if ((x-48)**2 + (y-42)**2)**0.5 < 1.5: v = 0
        if ((x-72)**2 + (y-42)**2)**0.5 < 1.5: v = 0
        if ((x-52)**2 + (y-46)**2)**0.5 < 1.5: v = 0
        if ((x-68)**2 + (y-46)**2)**0.5 < 1.5: v = 0
        # parotoid glands: large, oval
        if ((x-36)**2 + (y-30)**2)**0.5 < 4: v = 255
        if ((x-84)**2 + (y-30)**2)**0.5 < 4: v = 255
        # legs
        if 36 <= x <= 44 and 46 <= y <= 56: v = 255
        if 76 <= x <= 84 and 46 <= y <= 56: v = 255
        # ground
        if 24 <= x <= 96 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm89.ximg","wb").write(header + comp)
open("rm89.raw","wb").write(raw)
print(f"made rm89.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
