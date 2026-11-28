import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: round, toad-like
        b = ((x-60.0)**2)/(26.0*26.0) + ((y-38.0)**2)/(15.0*15.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-28)**2)**0.5 < 16: v = 255
        # eyes: bumpy toad eyes
        if ((x-49)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-49)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-71)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-71)**2 + (y-22)**2)**0.5 < 2: v = 0
        # mouth: wide toad grin
        if 44 <= x <= 76 and 32 <= y <= 33: v = 0
        # WARTS: bumpy toad skin - dots
        if ((x-48)**2 + (y-40)**2)**0.5 < 1.5: v = 0
        if ((x-72)**2 + (y-40)**2)**0.5 < 1.5: v = 0
        if ((x-60)**2 + (y-44)**2)**0.5 < 1.5: v = 0
        if ((x-54)**2 + (y-46)**2)**0.5 < 1.5: v = 0
        if ((x-66)**2 + (y-46)**2)**0.5 < 1.5: v = 0
        # FIRE BELLY: bright belly pattern - zigzag
        if 46 <= x <= 74 and 48 <= y <= 50: v = 0
        if 50 <= x <= 70 and 50 <= y <= 52: v = 255
        # legs: stubby toad legs
        if 36 <= x <= 44 and 46 <= y <= 54: v = 255
        if 76 <= x <= 84 and 46 <= y <= 54: v = 255
        # ground
        if 26 <= x <= 94 and 58 <= y <= 60: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm80.ximg","wb").write(header + comp)
open("rm80.raw","wb").write(raw)
print(f"made rm80.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
