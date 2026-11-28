import zlib, struct
w, h = 120, 64
raw = bytearray()
for y in range(h):
    for x in range(w):
        v = 0
        # body: tiny, underwater
        b = ((x-60.0)**2)/(18.0*18.0) + ((y-36.0)**2)/(11.0*11.0)
        if b < 1: v = 255
        # head: small, pointed
        if ((x-60)**2 + (y-28)**2)**0.5 < 11: v = 255
        # eyes: on top of head, tiny
        if ((x-53)**2 + (y-22)**2)**0.5 < 3: v = 255
        if ((x-53)**2 + (y-22)**2)**0.5 < 1: v = 0
        if ((x-67)**2 + (y-22)**2)**0.5 < 3: v = 255
        if ((x-67)**2 + (y-22)**2)**0.5 < 1: v = 0
        # mouth: tiny
        if 54 <= x <= 66 and 30 <= y <= 31: v = 0
        # WEBBED FEET: dwarf frogs have webbed feet - spread toes
        if 40 <= x <= 48 and 42 <= y <= 50: v = 255
        if 72 <= x <= 80 and 42 <= y <= 50: v = 255
        # bubbles: underwater!
        if ((x-30)**2 + (y-14)**2)**0.5 < 2: v = 0
        if ((x-30)**2 + (y-14)**2)**0.5 < 3: v = 255
        if ((x-90)**2 + (y-18)**2)**0.5 < 2: v = 0
        if ((x-90)**2 + (y-18)**2)**0.5 < 3: v = 255
        if ((x-84)**2 + (y-10)**2)**0.5 < 1: v = 0
        if ((x-84)**2 + (y-10)**2)**0.5 < 2: v = 255
        # water surface line
        if 16 <= x <= 104 and 8 <= y <= 9: v = 255
        # tank floor
        if 20 <= x <= 100 and 56 <= y <= 58: v = 255
        raw.append(v)
header = b"XIMG" + bytes([1,1]) + struct.pack("<ii", w, h)
comp = zlib.compress(bytes(raw))
open("rm79.ximg","wb").write(header + comp)
open("rm79.raw","wb").write(raw)
print(f"made rm79.ximg {len(header+comp)} bytes, raw {len(raw)} bytes")
