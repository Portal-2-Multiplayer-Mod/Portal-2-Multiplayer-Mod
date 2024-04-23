# █ █▀▄▀█ █▀█ █▀█ █▀█ ▀█▀ █▀   ▄█▄   █░█ ▄▀█ █▀█ █ █▄▄ █░░ █▀▀ █▀
# █ █░▀░█ █▀▀ █▄█ █▀▄ ░█░ ▄█   ░▀░   ▀▄▀ █▀█ █▀▄ █ █▄█ █▄▄ ██▄ ▄█

import os
import threading
import subprocess

from Scripts.BasicLogger import Log
import Scripts.GlobalVariables as GVars
import Scripts.Configs as CFG
import Scripts.BasicFunctions as BF
import time

# █▀▀ █ █░░ █▀▀   █▀▄▀█ █▀█ █░█ █▄░█ ▀█▀ █▀▀ █▀█
# █▀░ █ █▄▄ ██▄   █░▀░█ █▄█ █▄█ █░▀█ ░█░ ██▄ █▀▄

def SetVScriptConfigFile(vsconfigfile: str) -> None:
    Log("====================================================")
    Log("Setting VScript config file: " + vsconfigfile)
    p2cfgs = CFG.GetConfigList("menu", "portal2")

    lines = open(vsconfigfile, "r", encoding="utf-8").readlines()

    indx = -1
    for line in lines:
        indx += 1
        # remove all spaces
        line = line.strip().replace(" ", "")

        # if the line contains a // remove it
        if (line.find("//") != -1):
            line = line.split("//")[0]
        # if the line is empty skip it
        if (line == ""):
            continue
        # if the line doesnt contain a = or <- skip it
        if (line.find("=") == -1 and line.find("<-") == -1):
            continue

        key = ""

        # if the line has a <-
        if (line.find("<-") != -1):
            # split the <-
            key = line.split("<-")[0]

        # if the line has a =
        if (line.find("=") != -1):
            # split the =
            key = line.split("=")[0]

        for p2cfg in p2cfgs:
            if (key == p2cfg):
                val = GVars.configData[p2cfg]["value"]
                Log("Setting " + p2cfg + " To " + val)
                line = key + " <- " + val
                Log(line)
                lines[indx] = line + "\n"

    ################## ADMINS
    # convert the lines to a string with newlines
    lines = ''.join(lines)
    Log(lines) # Made this be logged for debugging and helping solve issues wih users

    # find the admins section
    admins = lines.find("Admins <-")
    # find the next [ after the admins section
    nextObrack = lines.find("[", admins)
    # add the player line after the admins section
    for player in GVars.configData["Players"]["value"]:
        name = player["name"]
        level = player["adminLevel"]
        steamid = player["steamid"]
        Log("Adding " + name + " to Admins")

        lines = lines[:nextObrack + 1] + '\n"[' + level + "]" + steamid + '", // ' + name + lines[nextObrack + 1:]

    open(vsconfigfile, "w", encoding="utf-8").write(lines)

    Log("====================================================")

def MountMod(gamepath: str) -> bool:
    Log("            __________Mounting Mod Start_________")
    Log("Gathering DLC folder data...")

    modFilesPath = GVars.modFilesPath + os.sep + "Portal 2" + os.sep + "install_dlc"

    # find a place to mount the dlc
    dlcmountpoint = FindAvailableDLC(gamepath)

    destination = BF.CopyFolder(modFilesPath + os.sep+".", gamepath + os.sep + dlcmountpoint)
    Log(f"Successfully copied the ModFiles to {destination}")

    nutConfigFile = gamepath + os.sep + dlcmountpoint + os.sep + "scripts" + os.sep + "vscripts" + os.sep + "multiplayermod" + os.sep + "config.nut"
    if os.path.exists(nutConfigFile):
        SetVScriptConfigFile(nutConfigFile)

    Log("            ___________Mounting Mod End__________")
    return True

# Using the identifier file in P2MM's DLC folder, it can be determined
# which DLC that is mounted to Portal 2 is in fact P2MM's DLC folder
def findP2MMDLCFolder(gamepath: str) -> str:
    for file in os.listdir(gamepath):
        # find all the folders that start with "portal2_dlc"
        if file.startswith("portal2_dlc") and os.path.isdir(gamepath + os.sep + file):

            # find and return where the identifier file is
            if ("p2mm.identifier" in os.listdir(gamepath + os.sep + file)):
                p2mmDLCFolder = gamepath + os.sep + file
                Log("Found P2MM's DLC folder: " + p2mmDLCFolder)
                return p2mmDLCFolder
    Log("P2MM's DLC folder was not found!")
    Log("It's most likely not been mounted to Portal 2 yet, already been unmounted, or the gamepath is incorrect...")
    return False

# Make sure the dlc folders that come with Portal 2 exist
# They are required since they include stuff for multiplayer and fixes for other things Portal 2 related
# portal2_dlc1 is required for multiplayer to work since it includes mp_coop_lobby_3 and the stuff for the DLC course Art Therapy
# portal2_dlc2 is also required, while its mainly for PeTi, it also includes a bunch of other assets and fixes for Portal 2 that Valve had done
# If either of these folders are not detected P2MM won't start or be mounted
def CheckForRequiredDLC(gamepath: str) -> bool:
    Log("Checking for DLC folders portal2_dlc1 and portal2_dlc2...")

    if (not (os.path.exists(gamepath + os.sep + "portal2_dlc1") or os.path.exists(gamepath + os.sep + "portal2_dlc2"))):
        Log("Either DLC folder portal2_dlc1 or portal2_dlc2 was not found!")
        Log("P2MM will not be mounted/started!")
        return False
    Log("DLC folders were found...")
    return True

# Find and delete P2MM's portal2_dlc folder
def DeleteUnusedDLCs(gamepath: str) -> None:
    Log("            _________Dealing with Folders________")

    if ((os.path.exists(gamepath)) != True):
        Log("Portal 2 game path not found!")
        return

    foundP2MMDLCFolder = findP2MMDLCFolder(gamepath)
    if foundP2MMDLCFolder != False:
        Log("Found old DLC: " + foundP2MMDLCFolder)
        # delete the folder even if it's not empty
        BF.DeleteFolder(foundP2MMDLCFolder)
        Log("Deleted old DLC: " + foundP2MMDLCFolder)

# Find what DLC folders exist for Portal 2 and create a incremented folder for P2MM
def FindAvailableDLC(gamepath: str) -> str:
    Log("Finding the next increment in DLC folders...")
    dlcs = []
    DeleteUnusedDLCs(gamepath)
    # go through each file in the gamepath
    for file in os.listdir(gamepath):
        # find all the folders that start with "portal2_dlc"
        if file.startswith("portal2_dlc") and os.path.isdir(gamepath + os.sep + file):
            # get everything after "portal2_dlc"
            try:
                dlcnumber = file.split("portal2_dlc")[1]
            except Exception as e:
                Log("Error getting DLC name! Probably a slice error. Moving on!")
                Log("Error: " + str(e))
                # move on to the next file
                continue

            # if dlcnumber contains any letters, it's not a number
            if any(char.isalpha() for char in dlcnumber):
                Log("DLC " + dlcnumber + " is not a number!")
            else:
                dlcs.append(str(dlcnumber))
                Log("Adding DLC: " + dlcnumber + " to our internal list to ignore...")

    # sort each dlc number lower to higher
    dlcs.sort(key=int)
    # return the folder where to mount the mod
    return "portal2_dlc" + str(int(dlcs[len(dlcs)-1]) + 1)

# █ █▄░█ █ ▀█▀
# █ █░▀█ █ ░█░

def LaunchGame(gamepath: str) -> None:
    Log("=============")
    Log("Running Game...")

    args = f"-novid -allowspectators -nosixense -conclearlog -condebug -usercon +developer 918612 +clear"

    # portal 2 uses the first argument provided, so this will override whatever the user has in the custom launch options
    # if GVars.configData["Start-From-Last-Map"]["value"] and len(GVars.configData["Last-Map"]["value"].strip()) > 0:
    #     args += " +map " + GVars.configData["Last-Map"]["value"]
    
    args += " " + GVars.configData['Custom-Launch-Options']['value']

    try:
        if (GVars.iow):
            # for hiding the cmd window on windows
            si = subprocess.STARTUPINFO()
            si.dwFlags |= subprocess.STARTF_USESHOWWINDOW

            # start portal 2 with the launch options and dont wait for it to finish
            def RunGame() -> None:
                # start portal 2 with the launch options and dont wait for it to finish
                Log("")
                Log(f'Starting Portal 2: "{gamepath + os.sep}portal2.exe" {args}')
                subprocess.call(f'"{gamepath + os.sep}portal2.exe" {args}', startupinfo=si)
                Log("Game exited successfully.")
                # Run The AfterFunction
                GVars.AfterFunction()
            # start the game in a new thread
            thread = threading.Thread(target=RunGame)
            thread.start()

        elif (GVars.iol or GVars.iosd): #launching for linux
            def RunGame():
                def RunSteam():
                    Log("")
                    Log(f'Starting Portal 2: steam -applaunch 620 {args}\n')
                    os.system(f'steam -applaunch 620 {args}')
                threading.Thread(target=RunSteam).start()

                def CheckForGame() -> None:
                    shouldcheck = True
                    latched = False
                    while shouldcheck:
                        gamerunning = str(os.system("pidof portal2_linux"))
                        if gamerunning == "256":
                            if latched == True:
                                GVars.AfterFunction()
                                shouldcheck = False
                        elif not latched:
                            latched = True
                        time.sleep(1)
                CheckForGame()
            thread = threading.Thread(target=RunGame)
            thread.start()

    except Exception as e:
        Log("Failed to launch Portal 2!")
        Log("Error: " + str(e))
        os._exit(1)
