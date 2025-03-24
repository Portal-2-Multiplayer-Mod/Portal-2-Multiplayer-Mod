import os, shutil, subprocess

#? Purpose:
#* If a modification is needed to be made to the pak01_dir_portal2 vpk
#* that goes with the ModFiles, a new VPK needs to be packaged.
#* This script does that and replaces the current one in ModFiles.
#! Designed for Windows, sorry about that...

#? User Process:
#* 1- Run script from the root directory. `python tools\UpdateModFilesVPK.py`
#* 2- After this script finishes, run the script that updates the p2mm/ModFiles with the src/ModFiles.
#*    Run it from the root directory. `python tools\UpdateModFilesIndex.py`
#* 3- Check if the new VPK works by launching the mod.

# Get Portal 2 path and define other paths
vpkedit = False
p2VPKPath = ""
if os.path.exists(f"C:{os.sep}Program Files{os.sep}VPKEdit"):
    p2VPKPath = f"C:{os.sep}Program Files{os.sep}VPKEdit"
    p2VPKPath = p2VPKPath + f"{os.sep}vpkeditcli.exe"
    vpkedit = True
else:
    p2VPKPath = input("Input your Portal 2 installation path: ").strip()
    p2VPKPath = p2VPKPath + f"{os.sep}bin{os.sep}vpk.exe"
vpkWorkPath = f"{os.getcwd() + os.sep}src{os.sep}ModFilesVPK"
modFilesVPKPath = f"src{os.sep}ModFiles{os.sep}pak01_dir_portal2.vpk"

# vpkeditcli.exe  + os.sep + "pak01_dir_portal2" -s -o "C:\Users\Orsell\Desktop\Programming\Portal\Portal-2-Multiplayer-Mod\src\ModFilesVPK\pak01_dir_portal2.vpk"

# Remove the old pak01_dir_portal2.vpk so a new one can be made
print("Removing old pak01_dir_portal2.vpk...")
if os.path.exists(f"{vpkWorkPath + os.sep}pak01_dir_portal2.vpk"):
    os.remove(f"{vpkWorkPath + os.sep}pak01_dir_portal2.vpk")

# Make the new pak01_dir_portal2.vpk
if (vpkedit):
    print(f'"{p2VPKPath}" -s -o "{vpkWorkPath + os.sep}pak01_dir_portal2.vpk" "{vpkWorkPath + os.sep}pak01_dir_portal2"')
    subprocess.call(f'"{p2VPKPath}" -s -o "{vpkWorkPath + os.sep}pak01_dir_portal2.vpk" "{vpkWorkPath + os.sep}pak01_dir_portal2"')
else:
    subprocess.call(f'"{p2VPKPath}" "{vpkWorkPath + os.sep}pak01_dir_portal2"')

# Check if a vpk was even made
if not os.path.exists(f"{vpkWorkPath + os.sep}pak01_dir_portal2.vpk"):
    print("pak01_dir_portal2.vpk not found, this means that the pak01_dir folder doesn't exist! Exiting...")
    exit(1)

if os.path.exists(modFilesVPKPath):
    print("Removing old pak01_dir_portal2.vpk file...")
    os.remove(modFilesVPKPath)

print("Copying over pak01_dir_portal2.vpk from src/ModFilesVPK to the src/ModFiles folder...")
shutil.copyfile(f"{vpkWorkPath + os.sep}pak01_dir_portal2.vpk", modFilesVPKPath)

print("New pak01_dir_portal2.vpk created and copied over! :D")
exit(0)

