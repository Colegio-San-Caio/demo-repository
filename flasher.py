import os
import shutil
import subprocess

# Local layout configuration
SOURCE_DIR = "/storage/emulated/0/Download"
DEST_DIR = "/storage/emulated/0/Download/oeneyeOS_Outputs"
REPO_DIR = "/data/data/com.termux/files/home/tmp"

print("🚀 Starting flasher split-repository distribution script...")

# 1. Handle workspace directories
if not os.path.exists(DEST_DIR):
    os.makedirs(DEST_DIR)

if os.path.exists(SOURCE_DIR):
    files = os.listdir(SOURCE_DIR)
    processed_count = 0
    
    for file in files:
        if file == "oeneyeOS_Outputs":
            continue
            
        if file.lower().endswith(('.img', '.bin')):
            src_file = os.path.join(SOURCE_DIR, file)
            base_name, _ = os.path.splitext(file)
            
            dest_raw = os.path.join(DEST_DIR, file)
            dest_qcow2 = os.path.join(DEST_DIR, f"{base_name}.qcow2")
            
            print(f"📦 Copying raw file: {file}...")
            shutil.copy2(src_file, dest_raw)
            
            print(f"⚡ Converting layer to compressed .qcow2 format...")
            try:
                subprocess.run([
                    "qemu-img", "convert", 
                    "-f", "raw", 
                    "-O", "qcow2", 
                    "-c", 
                    src_file, dest_qcow2
                ], check=True)
                print(f"✅ Generated: {base_name}.qcow2")
                
                # Copy the resulting virtual disk asset directly into local git repo
                shutil.copy2(dest_qcow2, os.path.join(REPO_DIR, f"{base_name}.qcow2"))
            except Exception as e:
                print(f"❌ QCow2 converter fallback alert: {e}")
                
            processed_count += 1
            
    if processed_count > 0:
        print(f"\n🎉 File compression operations complete.")
        
        # 2. Automated Git push routine
        print("\n🌐 Distributing commits to master remotes simultaneously...")
        try:
            os.chdir(REPO_DIR)
            
            # Clean untracked changes, add, and build manifest
            subprocess.run(["git", "add", "-A"], check=True)
            
            commit_msg = "🔄 Auto-sync: Updated compiled virtual layout layers"
            subprocess.run(["git", "commit", "-m", commit_msg], check=False)
            
            print("📤 Pushing payloads to demo-repository & LLMM branches...")
            # Pushes to all configured push destinations at once
            subprocess.run(["git", "push", "origin", "main"], check=True)
            print("✨ Multi-repository update deployment complete!")
            
        except Exception as git_error:
            print(f"⚠️ Git multi-push tracking encountered an alert: {git_error}")
    else:
        print("\n⚠️ No system files found in your local Download folder to process.")
else:
    print(f"\n❌ Error: Root directory {SOURCE_DIR} was not accessed.")

