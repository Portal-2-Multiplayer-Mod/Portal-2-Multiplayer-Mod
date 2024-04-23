import os, shutil

#? Purpose:
#* If a modification is needed to be made to the pak01_dir vpk
#* that goes with the ModFiles, a new VPK needs to be packaged.
#* This script does that and replaces the current one in ModFiles.
#! vpk.exe can cause issues on Linux unless you find a way to get it to work.

#? User Process:
#* 1- Run script from the root directory. `python tools\updateModFilesVPK.py`
#* 2- After this script finishes, run the script that updates the p2mm/ModFiles with the src/ModFiles.
#*    Run it from the root directory. `python tools\updateModFilesIndex.py`
#* 3- Check if the new VPK works by launching the mod.

# Define paths
vpkWorkPath = f"{os.getcwd() + os.sep}src{os.sep}ModFilesVPK"
modFilesVPKPath = f"src{os.sep}ModFiles{os.sep}Portal 2{os.sep}install_dlc{os.sep}pak01_dir.vpk"

# Remove the old pak01_dir.vpk so a new one can be made
print("Removing old pak01_dir.vpk...")
os.remove(f"{vpkWorkPath + os.sep}pak01_dir.vpk")

# Make the new pak01_dir.vpk
print("Running \"vpk.exe\" to make new pak01_dir.vpk...")
os.system(f"{vpkWorkPath + os.sep}vpk.exe {vpkWorkPath + os.sep}pak01_dir") 

# Check if a vpk was even made
if not os.path.exists(f"{vpkWorkPath + os.sep}pak01_dir.vpk"):
    print("pak01_dir.vpk not found, this means that the pak01_dir folder doesn't exist! Exiting...")
    exit(1)

if os.path.exists(modFilesVPKPath):
    print("Removing old pak01_dir.vpk file...")
    os.remove(modFilesVPKPath)

print("Copying over pak01_dir.vpk from src/ModFilesVPK to the src/ModFiles/Portal 2/install_dlc folder...")
shutil.copyfile(f"{vpkWorkPath + os.sep}pak01_dir.vpk", modFilesVPKPath)

print("New pak01_dir.vpk created and copied over! :D")
exit(0)

