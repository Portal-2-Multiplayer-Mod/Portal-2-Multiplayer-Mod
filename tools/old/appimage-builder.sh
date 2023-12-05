#!/bin/bash

echo "---------- Creating app image ----------"

# define the folders we gonna use
appImagesFolder="appImages"
buildFolder+=$appImagesFolder/"$(date '+%Y-%m-%d_%H-%M-%S')"
artifactsFolder+=$buildFolder"/artifacts"

# create them all using the deepest folder
mkdir -p "$artifactsFolder"

# https://unix.stackexchange.com/a/146752
# verison= grep -oP 'currentVersion = "\K[^"]+' src/Scripts/Updater.py

# download appImageTool only id it doesn't already exist
if [ ! -f "$appImagesFolder/appimagetool.AppImage" ]
then
    echo -e "---------- Downloading app image tool ----------"
    curl -L https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-x86_64.AppImage -o $appImagesFolder/appimagetool.AppImage
fi

# copy the template files and chmod them
cp -a tools/appImage-templates/. "$artifactsFolder"
chmod +x "$artifactsFolder" -R

# compile the python code using pyinstaller (these are the best args for now) (-s doesn't work on windows)
pyinstaller "src/MainWindow.py" -n "p2mm" -y -s --clean --distpath "$artifactsFolder"/usr/bin --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/Languages:Languages"

# compile for "x86_64", there's also "i686" (idk for what) and "aarch64" (for arm cpu)
echo "---------- Compiling app image ----------"
ARCH=x86_64 "$appImagesFolder"/appimagetool.AppImage "$artifactsFolder" --comp xz

# move the final product to the build folder
mv p2mm-x86_64.AppImage "$buildFolder"

echo "---------- App image compiled in $buildFolder ---------- "
