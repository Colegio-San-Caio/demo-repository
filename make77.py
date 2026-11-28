import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: small, translucent outline
        b = ((x-60.0)**2)/(20.0*20.0) + ((y-36.0)**2)/(13.0*13.0)
        if b < 1: v = 255
        # head
        if ((x-60)**2 + (y-26)**2)**0.5 < 13: v = 255
        # eyes: forward-facing, big
        if ((x-51)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-51)**2 + (y-22)**2)**0.5 < 2: v = 0
        if ((x-69)**2 + (y-22)**2)**0.5 < 5: v = 255
        if ((x-69)**2 + (y-22)**2)**0.5 < 2: v = 0
        # mouth: tiny
        if 52 <= x <= 68 and 30 <= y <= 31: v = 0
        # SEE-THROUGH BELLY: organs visible - heart dot
        if ((x-60)**2 + (y-40)**2)**0.5 < 2: v = 0
        # belly outline: hollow
        if 50 <= x <= 70 and 44 <= y <= 46: v = 0
        # legs: thin, delicate
        if 38 <= x <= 44 and 40 <= y <= 52: v = 255
        if 76 <= x <= 82 and 40 <= y <= 52: v = 255
        # leaf: glass frogs sit on leaves
        if 26 <= x <= 94 and 56 <= y <= 58: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm77.ximg","wb").write(header + comp)
open("rm77.raw","wb").write(raw)
print(f"made rm77.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
