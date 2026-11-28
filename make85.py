import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: small, toad-like
        b = ((x-60.0)**2)/(23.0*23.0) + ((y-38.0)**2)/(14.0*14.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-28)**2)**0.5 < 14: v = 255
        # eyes: with horizontal pupil
        if ((x-50)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-50)**2 + (y-22)**2)**0.5 < 2: v = 0
        if 46 <= x <= 54 and 21 <= y <= 23: v = 0
        if ((x-70)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-70)**2 + (y-22)**2)**0.5 < 2: v = 0
        if 66 <= x <= 74 and 21 <= y <= 23: v = 0
        # mouth
        if 48 <= x <= 72 and 32 <= y <= 33: v = 0
        # YELLOW STRIPE: natterjack signature - stripe down back!
        if 58 <= x <= 62 and 16 <= y <= 52: v = 0
        # warts
        if ((x-48)**2 + (y-42)**2)**0.5 < 1.5: v = 0
        if ((x-72)**2 + (y-42)**2)**0.5 < 1.5: v = 0
        # legs: RUNNING legs - natterjacks run, not hop!
        if 38 <= x <= 44 and 46 <= y <= 54: v = 255
        if 76 <= x <= 82 and 46 <= y <= 54: v = 255
        # ground
        if 26 <= x <= 94 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm85.ximg","wb").write(header + comp)
open("rm85.raw","wb").write(raw)
print(f"made rm85.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
