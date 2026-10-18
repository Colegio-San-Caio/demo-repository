import os, subprocess, shutil
S, D, R = "/storage/emulated/0/Download", "/storage/emulated/0/Download/oeneyeOS_Outputs", "/data/data/com.termux/files/home/tmp"
if not os.path.exists(D): os.makedirs(D)
for f in os.listdir(S):
    if f.lower().endswith(('.img', '.bin')) and f != "oeneyeOS_Outputs":
        src = os.path.join(S, f)
        base = os.path.splitext(f)[0]
        dq = os.path.join(D, f"{base}.qcow2")
        shutil.copy2(src, os.path.join(D, f))
        try:
            subprocess.run(["qemu-img", "convert", "-f", "raw", "-O", "qcow2", "-c", src, dq], check=True)
            shutil.copy2(dq, os.path.join(R, f"{base}.qcow2"))
        except: pass
try:
    os.chdir(R)
    subprocess.run(["git", "remote", "remove", "origin"], capture_output=True)
    subprocess.run(["git", "remote", "add", "origin", "https://github.com"], check=True)
    subprocess.run(["git", "remote", "set-url", "--add", "--push", "origin", "https://github.com"], check=True)
    subprocess.run(["git", "add", "-A"], check=True)
    subprocess.run(["git", "commit", "-m", "sync"], capture_output=True)
    subprocess.run(["git", "push", "origin", "main"], check=True)
    print("✨ Sync Complete")
except Exception as e: print(f"❌ Error: {e}")
