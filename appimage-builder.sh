#!/bin/bash

# Steps to make P2MM AppImage:
# 1. Clean up of previous build run and setup new build run
# 2. Make a appimagebuild folder for the AppImage if one doesn't exist to compile the AppImage
# 3. Download Python 1.10.13 AppImage
# 4. Extract the downloaded 1.10.13 Python AppImage
# 5. Use the preexisting install of Python in the AppImage to install the required dependences # Might not be working properly #
# 6. Copy src into squashfs so all the files for P2MM are avaliable
# 7. Set AppRun to target and run MainWindow.py instead of Python
# 8. Copy the P2MM Launchers icon to be used for the AppImage
# 9. Edit the .desktop to contain info on P2MM, as well as setting the icon
# 10. Remove and cleanup unessisary files that won't be packed into the AppImage # NEEDS TO BE DONE #
# 11. Convert back into AppImage # NEEDS FIXING #
# 12. Rename then run the AppImage to check that it works # NEED TO FINISH #


# Clean up previous build files
echo "Cleaning up previous build run..."
if [ -e "appimagebuild" ]; then
    rm -rf "appimagebuild"
fi

# Make appimagebuild if it doesn't exist
if [ ! -d "appimagebuild" ]; then
    mkdir "appimagebuild"
    echo "Folder 'appimagebuild' created!"
fi

echo -e "\nWhat verison of the launcher is this? (Example: 2.2.0)"
read -r VERSION

echo -e "\nMaking P2MMLauncher.AppImage..."

# Download an AppImage of Python 3.10.13, remove any preexisting verisons if any exist
echo -e "\nDownloading Python 3.10.13 AppImage..."
wget -P "appimagebuild" https://github.com/niess/python-appimage/releases/download/python3.10/python3.10.13-cp310-cp310-manylinux2014_x86_64.AppImage

# Extract the Python AppImage
echo -e "\nExtracting Python 3.10.13 AppImage..."
chmod +x "appimagebuild/python3.10.13-cp310-cp310-manylinux2014_x86_64.AppImage"
./appimagebuild/python3.10.13-cp310-cp310-manylinux2014_x86_64.AppImage --appimage-extract
mv "./squashfs-root" "./appimagebuild"

# Install required dependencies into the extracted AppImage
# This might not be working as intended and might be installing to the environments python installation
echo -e "\nInstalling required dependencies into AppImage..."
./appimagebuild/squashfs-root/AppRun -m pip install python-appimage
./appimagebuild/squashfs-root/AppRun -m pip install -r "$HOME/Desktop/Portal-2-Multiplayer-Mod/requirements.txt"

# Copy over the src folder into the Appimage
echo -e "\nCopying over the src folder into squashfs-root..."
cp -r "$HOME/Desktop/Portal-2-Multiplayer-Mod/src" "./appimagebuild/squashfs-root"

# Change AppRun so that it launches MainWindow.py
echo -e "\nChanging execution target of the AppImage..."
sed -i 's|./appimagebuild/squashfs-root/AppRun|./appimagebuild/squashfs-root/src/MainWindow.py|' "./appimagebuild/squashfs-root/AppRun"

# Copy over the P2MM Launcher icon for the .desktop file to use
cp "appimagebuild/squashfs-root/src/GUI/images/p2mm64.ico" "appimagebuild/squashfs-root"

# Edit the desktop file to contain P2MM's information
echo -e "\nFixing up the .desktop file with P2MM's information..."
mv "./appimagebuild/squashfs-root/usr/share/applications/python3.10.13.desktop" "./appimagebuild/squashfs-root/usr/share/applications/P2MMLauncher.desktop"
echo -e '[Desktop Entry]\nType=Application\nName=P2MM Launcher\nExec=python src/MainWindow.py\nComment=The official launcher for the Portal 2: Multiplayer Mod\nIcon=p2mm64.ico\nCategories=Game;\nTerminal=false' > "./appimagebuild/squashfs-root/usr/share/applications/*.desktop"

rm ./appimagebuild/squashfs-root/*.desktop
cp "./appimagebuild/squashfs-root/usr/share/applications/*.desktop" "./appimagebuild/squashfs-root/"
mv "./appimagebuild/squashfs-root/*.desktop" "./appimagebuild/squashfs-root/P2MMLauncher.desktop"

# Remove unnesissary files to not get packed into the AppImage
# NEEDS TO BE DONE

echo -e "\nBuilding the P2MM Launcher AppImage..."
# This is failing because it can't find the icon file in relation to the .desktop file. No clue why this is happening as it is in the right place.
python -m python-appimage build app "./appimagebuild/squashfs-root"

# Rename and test the created AppImage
# mv "./appimagebuild/squashfs-root" "./appimagebuild/squashfs-root" # Need to sort renaming
#./P2MMLauncher-$(VERSION)-x86_64.AppImage

echo -e "\nFinished! :D"