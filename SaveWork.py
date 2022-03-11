import os

#set current dir to the directory of the script
os.chdir(os.path.dirname(os.path.realpath(__file__)))

# detect the running OS
# nt is the code name for the windows kernel
# windows = true, linux = false 
isWindowns = os.name == "nt"

# if the folder portal2_dlc3 exists
if os.path.exists("portal2_dlc3"):
    # linux
    if not isWindowns:
        # delete everything inside of MultiplayerModFiles/ModFiles/Portal 2/install_dlc
        os.system("rm -rf MultiplayerModFiles/ModFiles/Portal\ 2/install_dlc/*")

        # copy everything inside of portal2_dlc3/ to MultiplayerModFiles/ModFiles/Portal 2/install_dlc
        os.system("cp -r portal2_dlc3/* MultiplayerModFiles/ModFiles/Portal\ 2/install_dlc/")
    # windows
    else:
        # delete everything inside of MultiplayerModFiles/ModFiles/Portal 2/install_dlc
        os.system("rmdir /S /Q MultiplayerModFiles\\ModFiles\\Portal\ 2\\install_dlc")

        # copy everything inside of portal2_dlc3/ to MultiplayerModFiles/ModFiles/Portal 2/install_dlc
        os.system("xcopy /E /I /Y portal2_dlc3\\* \"MultiplayerModFiles\\ModFiles\\Portal 2\\install_dlc\"")

else:
    print("portal2_dlc3 folder not found")