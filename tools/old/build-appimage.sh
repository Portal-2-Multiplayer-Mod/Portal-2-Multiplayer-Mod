#!/bin/bash

# prepare folder
mkdir -p ./AppDir/usr/bin ./AppDir/usr/share/icons
cp -a ./src/. ./AppDir/usr/bin/.
cp ./src/GUI/images/p2mm-icon.ico ./AppDir/usr/share/icons/p2mm-icon.png # ICON MUST BE A PNG HENCE THE WEIRD COPY

# install all the requirements next to the source code
python3 --version
python --version
exit 0
python3 -m venv env
ls
./env/bin/pip3 install -r ./requirements.txt
ls
ls ./env
ls ./env/lib64
ls ./env/lib64/python3.10
ls ./env/lib64/python3.10/site-packages
cp -a ./env/lib64/python3.10/site-packages/. ./AppDir/usr/bin/.

curl -L 'https://github.com/cabiste69/appimage-builder/releases/download/1.2.0/appimage-builder-v1.2.0-x86_64.AppImage' -o appimage-builder.AppImage

chmod +x ./appimage-builder.AppImage
./appimage-builder.AppImage

mkdir dist

cp p2mm-* dist/