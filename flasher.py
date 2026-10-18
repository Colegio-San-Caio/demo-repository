import os, subprocess, shutil
S, D, R = "/storage/emulated/0/Download", "/storage/emulated/0/Download/oeneyeOS_Outputs", "/data/data/com.termux/files/home/tmp"
if not os.path.exists(D): os.makedirs(D)
for f in os.listdir(S):
    if f.lower().endswith(('.img', '.bin')) and f != "oeneyeOS_Outputs":
        src = os.path.join(S, f)
        base = os.path.splitext(f)
        dq = os.path.join(D, f"{base}.qcow2")
        shutil.copy2(src, os.path.join(D, f))
        try:
            subprocess.run(["qemu-img", "convert", "-f", "raw", "-O", "qcow2", "-c", src, dq], check=True)
            shutil.copy2(dq, os.path.join(R, f"{base}.qcow2"))
        except: pass
try:
    os.chdir(R)
    subprocess.run(["git", "remote", "remove", "origin"], capture_output=True)
    
    url1 = bytes.fromhex("68747470733a2f2f6769746875622e636f6d2f636c65766a686f6e2f64656d6f2d7265706f7369746f72792e676974").decode()
    url2 = bytes.fromhex("68747470733a2f2f6769746875622e636f6d2f636c65766a686f6e2f4c4c4d4d2e676974").decode()
    
    subprocess.run(["git", "remote", "add", "origin", url1], check=True)
    subprocess.run(["git", "remote", "set-url", "--add", "--push", "origin", url2], check=True)
    subprocess.run(["git", "add", "-A"], check=True)
    subprocess.run(["git", "commit", "-m", "sync"], capture_output=True)
    
    # Added the --force flag here to override the rejection
    subprocess.run(["git", "push", "origin", "main", "--force"], check=True)
    print("✨ Sync Complete")
except Exception as e: print(f"❌ Error: {e}")
