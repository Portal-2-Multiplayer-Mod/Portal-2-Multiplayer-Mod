import os
import shutil

#set current dir to the directory of the script
os.chdir(os.path.dirname(os.path.realpath(__file__)))

import Scripts.GlobalVariables as GVars
GVars.init()
GVars.LoadConfig()
gamepath = GVars.configsData["portal2path"]["value"]
print("gamepath: " + gamepath)

# detect the running OS
# nt is the code name for the windows kernel
# windows = true, linux = false
isWindowns = os.name == "nt"

ourfolder = "NONE"
# get every file/folder in the portal 2 directory
for folder in os.listdir(gamepath):
    print(folder)
    # if it starts with portal2_dlc
    if folder.startswith("portal2_dlc"):
        # make sure it's a folder
        if os.path.isdir(gamepath + "/" + folder):
            # if there is a file named 32playermod.identifier
            if os.path.isfile(gamepath + "/" + folder + "/32playermod.identifier"):
                print("Found DLC: " + folder)
                ourfolder = folder
                break

print("ourfolder: " + ourfolder)

# changedir 1 folder back
os.chdir("..")

# if the mod folder exists
if os.path.exists(gamepath + "/" + ourfolder):
    # linux
    if not isWindowns:
        # delete everything inside of src/ModFiles/Portal 2/install_dlc
        os.system("rm -rf src/ModFiles/Portal\ 2/install_dlc")

        # copy everything inside of portal2_dlcX/ to src/ModFiles/Portal 2/install_dlc
        shutil.copytree(gamepath + "/" + ourfolder, "src/ModFiles/Portal 2/install_dlc")
    # windows
    else:
        print(os.getcwd())
        # delete everything inside of src/ModFiles/Portal 2/install_dlc
        os.system( "rmdir /S /Q \"src\\ModFiles\\Portal 2\\install_dlc\"")

        # copy everything inside of portal2_dlcX/ to src/ModFiles/Portal 2/install_dlc
        shutil.copytree(gamepath + "\\" + ourfolder, "src\\ModFiles\\Portal 2\\install_dlc")
else:
    print("mod folder not found")