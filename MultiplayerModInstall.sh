#!/bin/bash

# i swear to god, i won't comment this, this was too much painal to get to work for a simple ass bash script

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

MODFILEPATH=$PWD/MultiplayerModFiles
MODFILES="bin/server.so cfg/collisionfix.cfg cfg/multiplayermod.cfg media/coop_bluebot_load.bik media/coop_orangebot_load.bik scripts/vscripts/mapspawn.nut"

color () { printf $1; }

askForPath () {
	color $GREEN
	read -p "Please enter the path of your steam library which contains the game (NOT the game folder): " GAMEPATH
	GAMEPATH="$GAMEPATH/steamapps/common/Portal 2"
	if [ ! -d "$GAMEPATH" ]; then echo -e "$RED Invalid path!"; askForPath; fi
}

color $GREEN
echo "Checking for default game installation folder.."
GAMEPATH="/home/$USER/.local/share/Steam/steamapps/common/Portal 2"
if [ ! -d "$GAMEPATH" ]; then
	color $RED
    echo "It doesn't look like you're using the default path for Portal 2, please specify your game install directory"
	echo "(this may be related to using a custom steam library folder)"
	askForPath
	echo "Found game in $GAMEPATH, continuing..."
else
	echo "Found game in default directory, continuing..."
fi

RUNPATH="$GAMEPATH/MultiplayerModRun.sh"
cmp -s "$MODFILEPATH/bin/server.so" "$GAMEPATH/portal2/bin/server.so"
if [ "$?" -eq "1" ] && [ -f $GAMEPATH/portal2/bin/server.so ]; then
	color $GREEN
	echo "Files already installed!"
else
	echo "Mod files not found, performing clean install..."	
	color $BLUE
	for f in $MODFILES; do
		if [[ ! $f =~ "cfg" ]]; then 
			cp -vf "$MODFILEPATH/$f" "$GAMEPATH/portal2/$f.modded"
			cp -vf "$GAMEPATH/portal2/$f" "$GAMEPATH/portal2/$f.orig"
		else
			cp -vf "$MODFILEPATH/$f" "$GAMEPATH/portal2/$f"
		fi
	done
	cp -vf "$PWD/MultiplayerModRun.sh" "$RUNPATH"
fi

color $GREEN
echo -e "All done, you can now run the mod by executing \e[1m${RUNPATH// /\\ }\e[21m"

color $NC