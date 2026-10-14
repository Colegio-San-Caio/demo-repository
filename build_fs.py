import struct

files = {
  b"hello.txt": b"hello world\n",
  b"about.txt": b"oeneyeOS Aurum FS\n",
}

# Build directory
data_offset = 1  # file count byte
dir_size = len(files) * (12 + 4 + 4)  # 20 per file
data_offset += dir_size

payload = bytearray()
payload.append(len(files))

blob = bytearray()
for name, content in files.items():
    name_padded = name.ljust(12, b'\x00')[:12]
    payload.extend(name_padded)
    payload.extend(struct.pack("<I", data_offset))
    payload.extend(struct.pack("<I", len(content)))
    blob.extend(content)
    data_offset += len(content)

payload.extend(blob)

# pad to 512 boundary
while len(payload) % 512 != 0:
    payload.append(0)

open("payload.bin","wb").write(payload)
print(f"AURUM payload.bin {len(payload)} bytes, {len(files)} files")
for n in files: print(" -", n.decode())
