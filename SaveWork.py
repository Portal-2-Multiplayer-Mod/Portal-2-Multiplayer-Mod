import os

#set current dir to the directory of the script
os.chdir(os.path.dirname(os.path.realpath(__file__)))

# detect the running OS
# nt is the code name for the windows kernel
# windows = true, linux = false
isWindowns = os.name == "nt"

ourfolder = "NONE"
# get every file/folder in the portal 2 directory
for folder in os.listdir(os.getcwd()):
    # if it starts with portal2_dlc
    if folder.startswith("portal2_dlc"):
        # make sure it's a folder
        if os.path.isdir(folder):
            # if there is a file named 32playermod.identifier
            if os.path.isfile(folder + "/32playermod.identifier"):
                print("Found DLC: " + folder)
                ourfolder = folder
                break

# if the mod folder exists
if os.path.exists(ourfolder):
    # linux
    if not isWindowns:
        # delete everything inside of MultiplayerModFiles/ModFiles/Portal 2/install_dlc
        os.system("rm -rf MultiplayerModFiles/ModFiles/Portal\ 2/install_dlc/*")

        # copy everything inside of portal2_dlcX/ to MultiplayerModFiles/ModFiles/Portal 2/install_dlc
        os.system("cp -r " + ourfolder + "/* MultiplayerModFiles/ModFiles/Portal\ 2/install_dlc/")
    # windows
    else:
        # delete everything inside of MultiplayerModFiles/ModFiles/Portal 2/install_dlc
        os.system( "rmdir /S /Q MultiplayerModFiles\\ModFiles\\Portal\ 2\\install_dlc")

        # copy everything inside of portal2_dlcX/ to MultiplayerModFiles/ModFiles/Portal 2/install_dlc
        os.system("xcopy /E /I /Y " + ourfolder + "\\* \"MultiplayerModFiles\\ModFiles\\Portal 2\\install_dlc\"")
else:
    print("mod folder not found")