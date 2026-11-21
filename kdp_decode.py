# kdp_decode.py - XIMG -> PNG, 120x64, pure Python, no extra lib except Pillow
# Usage: python3 kdp_decode.py
# Output: kdp.png
import zlib
try:
    from PIL import Image
except:
    print("Install Pillow: pip install Pillow")
    raise SystemExit

data = open('kdp.ximg','rb').read()
print('File:', len(data), 'Magic:', data[0:4])
w = data[6] | (data[7] << 8)  # 120
# Height is in decompressed size / width
raw = zlib.decompress(data[14:])
h = len(raw) // w
print(f'Decompressed: {len(raw)} = {w} x {h}')
img = Image.frombytes('L', (w, h), raw)
img = img.resize((w*4, h*4), Image.NEAREST)
img.save('kdp.png')
print('Saved kdp.png -', w*4, 'x', h*4)

