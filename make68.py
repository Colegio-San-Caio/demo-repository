import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body
        b = ((x-60.0)**2)/(28.0*28.0) + ((y-40.0)**2)/(16.0*16.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-30)**2)**0.5 < 18: v = 255
        # horns
        if 46 <= x <= 50 and 10 <= y <= 18: v = 255
        if 48 <= x <= 50 and 12 <= y <= 18: v = 255
        if 70 <= x <= 74 and 10 <= y <= 18: v = 255
        if 70 <= x <= 72 and 12 <= y <= 18: v = 255
        # eyes
        if ((x-48)**2 + (y-20)**2)**0.5 < 4: v = 255
        if ((x-48)**2 + (y-20)**2)**0.5 < 1.5: v = 0
        if ((x-72)**2 + (y-20)**2)**0.5 < 4: v = 255
        if ((x-72)**2 + (y-20)**2)**0.5 < 1.5: v = 0
        # huge mouth
        if 40 <= x <= 80 and 32 <= y <= 34: v = 0
        # belly
        if 44 <= x <= 76 and 48 <= y <= 50: v = 0
        # front legs
        if 44 <= x <= 48 and 50 <= y <= 56: v = 255
        if 72 <= x <= 76 and 50 <= y <= 56: v = 255
        # ground
        if 30 <= x <= 90 and 56 <= y <= 58: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm68.ximg","wb").write(header + comp)
open("rm68.raw","wb").write(raw)
print(f"made rm68.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
