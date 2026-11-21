import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: small, sleek
        b = ((x-60.0)**2)/(24.0*24.0) + ((y-38.0)**2)/(14.0*14.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-28)**2)**0.5 < 15: v = 255
        # eyes: big, shiny
        if ((x-51)**2 + (y-23)**2)**0.5 < 5: v = 255
        if ((x-51)**2 + (y-23)**2)**0.5 < 2: v = 0
        if ((x-69)**2 + (y-23)**2)**0.5 < 5: v = 255
        if ((x-69)**2 + (y-23)**2)**0.5 < 2: v = 0
        # mouth: tiny smile
        if 50 <= x <= 70 and 32 <= y <= 33: v = 0
        # SPOTS: poison dart pattern - dots on back
        if ((x-52)**2 + (y-38)**2)**0.5 < 2: v = 0
        if ((x-68)**2 + (y-38)**2)**0.5 < 2: v = 0
        if ((x-60)**2 + (y-44)**2)**0.5 < 2: v = 0
        # legs: long, thin - ready to jump
        if 36 <= x <= 42 and 42 <= y <= 54: v = 255
        if 78 <= x <= 84 and 42 <= y <= 54: v = 255
        # leaf
        if 28 <= x <= 92 and 56 <= y <= 58: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm72.ximg","wb").write(header + comp)
open("rm72.raw","wb").write(raw)
print(f"made rm72.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
