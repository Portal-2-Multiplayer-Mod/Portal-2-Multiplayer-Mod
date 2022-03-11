import os

#set cur dir to the directory of the script
os.chdir(os.path.dirname(os.path.realpath(__file__)))

# detect if running on windows
isonwindows = False
isonlinux = False
if os.name == "nt":
    isonwindows = True
else:
    isonlinux = True

# if the folder portal2_dlc3 exists
if os.path.exists("portal2_dlc3"):
    if isonlinux:
        # delete everything inside of MultiplayerModFiles/ModFiles/Portal 2/install_dlc
        os.system("rm -rf MultiplayerModFiles/ModFiles/Portal\ 2/install_dlc/*")

        # copy everything inside of portal2_dlc3/ to MultiplayerModFiles/ModFiles/Portal 2/install_dlc
        os.system("cp -r portal2_dlc3/* MultiplayerModFiles/ModFiles/Portal\ 2/install_dlc/")

    if isonwindows:
        # delete everything inside of MultiplayerModFiles/ModFiles/Portal 2/install_dlc
        os.system("rmdir /S /Q MultiplayerModFiles\\ModFiles\\Portal\ 2\\install_dlc")

        # copy everything inside of portal2_dlc3/ to MultiplayerModFiles/ModFiles/Portal 2/install_dlc
        os.system("xcopy /E /I /Y portal2_dlc4\\* \"MultiplayerModFiles\\ModFiles\\Portal 2\\install_dlc\"")


else:
    print("portal2_dlc3 folder not found")