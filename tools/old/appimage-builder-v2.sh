#!/bin/bash

p2mmPath=$(pwd)

cacheFolder=~/.cache

# i just like clearinf the cache folder, you can remove this line if you want
rm -rf ${cacheFolder:?}/*

mkdir -p ${cacheFolder:?}/AppDir/usr/src
mkdir -p ${cacheFolder:?}/AppDir/usr/share/images

cp -a "$p2mmPath"/src/. ${cacheFolder:?}/AppDir/usr/src
ffmpeg -i "$p2mmPath"/src/GUI/images/p2mm64.png -vf scale=256x256 $cacheFolder/AppDir/usr/share/images/p2mm-icon.png

cd $cacheFolder/AppDir/usr/src || exit
python -m venv env
source env/bin/activate
pip install -r "$p2mmPath"/requirements.txt

cp -a env/lib64/python3.11/site-packages/. .
rm -rf env

python MainWindow.py

# apt install software-properties-common