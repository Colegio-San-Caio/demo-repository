import os
import shutil
import subprocess

# Define directory structures
SOURCE_DIR = "/storage/emulated/0/Download"
DEST_DIR = "/storage/emulated/0/Download/oeneyeOS_Outputs"
REPO_DIR = "/data/data/com.termux/files/home/tmp"

print("🚀 Starting flasher image exporter, converter, & git automation...")

# Ensure destination folder exists
if not os.path.exists(DEST_DIR):
    os.makedirs(DEST_DIR)
    print(f"📁 Created folder: {DEST_DIR}")

# Check if source directory exists
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
            
            # Copy local storage copies
            print(f"📦 Copying raw layer: {file}...")
            shutil.copy2(src_file, dest_raw)
            
            # Convert and compress to QCOW2 format
            print(f"⚡ Converting {file} to compressed .qcow2...")
            try:
                subprocess.run([
                    "qemu-img", "convert", 
                    "-f", "raw", 
                    "-O", "qcow2", 
                    "-c", 
                    src_file, dest_qcow2
                ], check=True)
                print(f"✅ Created: {base_name}.qcow2")
                
                # Copy the final qcow2 into git repository path to track
                shutil.copy2(dest_qcow2, os.path.join(REPO_DIR, f"{base_name}.qcow2"))
            except Exception as e:
                print(f"❌ Failed QCOW2 processing for {file}: {e}")
                
            processed_count += 1
            
    if processed_count > 0:
        print(f"\n🎉 Build compilation completed successfully.")
        
        # --- GITHUB AUTOMATION BLOCK ---
        print("\n🌐 Initiating GitHub synchronization sequence...")
        try:
            os.chdir(REPO_DIR)
            
            # Stage all untracked changes
            subprocess.run(["git", "add", "-A"], check=True)
            
            # Commit changes with a clean automated timestamp tracker
            commit_message = "🔄 Auto-uploading updated virtual disk layers"
            subprocess.run(["git", "commit", "-m", commit_message], check=False)
            
            # Push upstream to your master/main branch
            print("📤 Pushing chunks directly to repository...")
            subprocess.run(["git", "push", "origin", "main"], check=True)
            print("✨ Successfully uploaded assets to GitHub!")
            
        except Exception as git_error:
            print(f"⚠️ Git synchronization encountered an alert: {git_error}")
            
    else:
        print("\n⚠️ No .img or .bin files found in /Download/ to process.")
else:
    print(f"\n❌ Error: Source directory {SOURCE_DIR} not found.")

