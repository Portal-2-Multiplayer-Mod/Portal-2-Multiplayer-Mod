# "Cause life is better in color" - crappy apple event on 4/20
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# list of all files required for the mod, could've skipped the cfg's instead of making it an if statement later on but like this i can keep it the same as the installer
MODFILES="bin/server.so cfg/collisionfix.cfg cfg/multiplayermod.cfg media/coop_bluebot_load.bik media/coop_orangebot_load.bik scripts/vscripts/mapspawn.nut"

color () { printf $1; }

# yank the path of our script and by extension portal2.sh
SCRIPT=`realpath "$0"`
SCRIPTPATH=`dirname "$SCRIPT"`

if [ ! -f "$SCRIPTPATH/portal2_linux" ]; then
	color $RED
	echo "ERROR! Couldn't find the game executable in current directory, please install the mod first, then run it with the command created by the installer!";
	color $NC
	exit 1
fi

# replace current files with modded files
color $BLUE
for f in $MODFILES; do
	if [[ ! $f =~ "cfg" ]]; then
		cp -vf "$SCRIPTPATH/portal2/$f.modded" "$SCRIPTPATH/portal2/$f"
	fi
done

color $GREEN
read -p "Run in windowed mode? (y/n): " WINDOWED
if [[ $WINDOWED =~ ^[Yy]$ ]]; then WINDOWED="-window -w 1280 -h 720"; else WINDOWED=""; fi

if command -v upnpc &> /dev/null; then
	read -p "It looks like you have upnpc installed, would you like to automatically try to forward port 27015 UDP? (y/n)" FORWARD
	if [[ $FORWARD =~ ^[Yy]$ ]]; then
		upnpc -a `ip -4 addr show $(ip route | grep '^default' | grep 'src' | awk '{print $5}') | grep -oP '(?<=inet\s)\d+(\.\d+){3}'` 27015 27015 UDP
	fi
fi

# run game script (NOT portal2_linux, it errors out since the lib loader is fucked on leenok)
color $NC
"$SCRIPTPATH/portal2.sh" $WINDOWED -game portal2 -novid -allowspectators +exec multiplayermod.cfg +sv_lan 0 +mp_wait_for_other_player_notconnecting_timeout 240 +mp_wait_for_other_player_timeout 240 +map mp_coop_lobby_3 -nosixense

# restore og files
color $BLUE
for f in $MODFILES; do
	if [[ ! $f =~ "cfg" ]]; then
		cp -vf "$SCRIPTPATH/portal2/$f.orig" "$SCRIPTPATH/portal2/$f"
	fi
done

color $NC