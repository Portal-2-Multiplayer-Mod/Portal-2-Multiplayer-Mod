#!/bin/bash

# Alternate script method I'm testing, might be easier in the long run
# to just build a .sh file then pack that into a AppImage.

# Steps to make P2MM AppImage from a .sh file:
# 1. Remove any old AppImage.
# 2. Make the appimagebuild and appimagesrc folders if the don't exist.
# 3. Get version of P2MM build.
# 4. Check for required tools, appimage-builder, and pyinstaller.
# 5. Run pyinstaller on Linux to make the .sh file.
# 6. Move the .sh file from dist to the appimagesrc folder.
# 7. Make the .desktop file for the AppImage to use and set its attributes.
# 8. Copy the icon for the AppImage to use.
# 9. Use appimage-builder build the AppImage.

echo -e "\nStarting operations to build AppImage from .sh..."

# Remove any old AppImage
echo -e "\nRemoving any old AppImages..."
if [ -e "appimagebuild/*.AppImage" ]; then
    rm -rf "appimagebuild/*.AppImage"
    echo -e "\nRemoved old Appimage(s)..."
fi

# Make appimagebuild and appimagesrc if it doesn't exist
if [ ! -d "appimagebuild" ] && [ ! -d "appimagebuild/appimagesrc" ]; then
    mkdir "appimagebuild/appimagesrc"
    echo "Folder 'appimagebuild' and 'appimagesrc' created!"
fi

# Get build version of the launcher being compiled
echo -e "\nWhat verison of the launcher is this? (Example: 2.2.0)"
read -r VERSION

echo -e "\nChecking for required tools..."
if [ ! -d "/usr/local/bin/appimage-builder" ]; then
    echo -e "appimage-builder was not found! Installing, needs sudo to move appimage-builder's AppImage"
    wget -O appimage-builder-x86_64.AppImage https://github.com/AppImageCrafters/appimage-builder/releases/download/v1.1.0/appimage-builder-1.1.0-x86_64.AppImage
    chmod +x appimage-builder-x86_64.AppImage

fi

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
#! This might not be working as intended and might be installing to the environments python installation
echo -e "\nInstalling required dependencies into AppImage..."
./appimagebuild/squashfs-root/AppRun -m pip install python-appimage
./appimagebuild/squashfs-root/AppRun -m pip install -r "requirements.txt"

# Copy over the src folder into the Appimage
echo -e "\nCopying over the src folder into squashfs-root..."
cp -r "src" "./appimagebuild/squashfs-root"

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
#! NEEDS TO BE DONE

echo -e "\nBuilding the P2MM Launcher AppImage..."
#! This is failing because it can't find the icon file in relation to the .desktop file. No clue why this is happening as it is in the right place.
python -m python-appimage build app "./appimagebuild/squashfs-root"

# Rename and test the created AppImage
# mv "./appimagebuild/squashfs-root" "./appimagebuild/squashfs-root" #! Need to sort out renaming
#./P2MMLauncher-$(VERSION)-x86_64.AppImage

echo -e "\nFinished! :D"