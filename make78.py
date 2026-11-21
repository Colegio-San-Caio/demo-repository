import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: wide, flat
        b = ((x-60.0)**2)/(28.0*28.0) + ((y-40.0)**2)/(15.0*15.0)
        if b < 1: v = 255
        # head: very wide
        if ((x-60)**2 + (y-30)**2)**0.5 < 19: v = 255
        # HORNS: pointy eyelid horns - the signature
        if 42 <= x <= 50 and 8 <= y <= 18: v = 255
        if 70 <= x <= 78 and 8 <= y <= 18: v = 255
        if ((x-46)**2 + (y-14)**2)**0.5 < 3: v = 255
        if ((x-74)**2 + (y-14)**2)**0.5 < 3: v = 255
        # eyes: under horns
        if ((x-48)**2 + (y-22)**2)**0.5 < 4: v = 255
        if ((x-48)**2 + (y-22)**2)**0.5 < 1.5: v = 0
        if ((x-72)**2 + (y-22)**2)**0.5 < 4: v = 255
        if ((x-72)**2 + (y-22)**2)**0.5 < 1.5: v = 0
        # mouth: enormous - horned frogs eat everything
        if 38 <= x <= 82 and 34 <= y <= 36: v = 0
        # legs: short
        if 36 <= x <= 44 and 50 <= y <= 56: v = 255
        if 76 <= x <= 84 and 50 <= y <= 56: v = 255
        # ground
        if 24 <= x <= 96 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm78.ximg","wb").write(header + comp)
open("rm78.raw","wb").write(raw)
print(f"made rm78.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
