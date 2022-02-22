import os

#set cur dir to the directory of the script
os.chdir(os.path.dirname(os.path.realpath(__file__)))

# delete everything inside of MultiplayerModFiles/ModFiles/Portal 2/install_dlc
os.system("rm -rf MultiplayerModFiles/ModFiles/Portal\ 2/install_dlc/*")
# copy everything inside of portal2_dlc3/ to MultiplayerModFiles/ModFiles/Portal 2/install_dlc
os.system("cp -r portal2_dlc3/* MultiplayerModFiles/ModFiles/Portal\ 2/install_dlc/")