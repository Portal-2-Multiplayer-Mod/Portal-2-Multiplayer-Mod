# █ █▀▄▀█ █▀█ █▀█ █▀█ ▀█▀ █▀   ▄█▄   █░█ ▄▀█ █▀█ █ █▄▄ █░░ █▀▀ █▀
# █ █░▀░█ █▀▀ █▄█ █▀▄ ░█░ ▄█   ░▀░   ▀▄▀ █▀█ █▀▄ █ █▄█ █▄▄ ██▄ ▄█

import os
import threading

from Scripts.BasicLogger import Log
import Scripts.GlobalVariables as GVars
import Scripts.Configs as CFG
import subprocess
import Scripts.BasicFunctions as BF
import random
import time

CommandReplacements = [
    ['pre_go_to_hub', 'p2mm_tran_hub', 'p2mm_tran_hub'],
    ['pre_go_to_calibration', 'p2mm_tran_calibration', 'p2mm_tran_calibration'],

    ['go_to_hub', 'p2mm__gth', 'p2mm__gth'], # (We are able to patch this through mapsupport for cali, c2, c3, and c4 ending maps)
    ['go_to_calibration', 'p2mm_go_to_calibr', 'p2mm_go_to_calibr'],

    ['restart_level', 'p2mm__restart', 'p2mm__restart'],
    ['mp_restart_level', 'p2mm__mp_restart', 'p2mm__mp_restart'],

    ['transition_map', 'p2mm_next_maps', 'p2mm_next_maps'],

    ['select_map', 'p2mmselmap', 'p2mmselmap'],
    ['mp_select_level', 'p2mm_goto_level', 'p2mm_goto_level'],

    ['erase_mp_progress', 'p2mm_cut_progress', 'p2mm_cut_progress'],
    ['mp_earn_taunt', 'p2mm_earn_tnt', 'p2mm_earn_tnt'],
    ['mp_mark_all_maps_complete', 'p2mm_label_coop_completed', 'p2mm_label_coop_completed'],
    ['mp_mark_all_maps_incomplete', 'p2mm_label_coop_incompleted', 'p2mm_label_coop_incompleted'],
    ['mp_mark_course_complete', 'p2mm_course_#_completed', 'p2mm_course_#_completed'],
]


# █▀▀ █ █░░ █▀▀   █▀▄▀█ █▀█ █░█ █▄░█ ▀█▀ █▀▀ █▀█
# █▀░ █ █▄▄ ██▄   █░▀░█ █▄█ █▄█ █░▀█ ░█░ ██▄ █▀▄

def Encrypt(path: str, search: str, replace: str) -> None:
    if os.path.isdir(path):
        for root, dirs, files in os.walk(path):
            for file in files:
                try:
                    file_path = os.path.join(root, file)

                    with open(file_path, 'r', encoding="utf-8") as f:
                        data = f.read()

                    data = data.replace(search, replace)

                    with open(file_path, 'w', encoding="utf-8") as f:
                        f.write(data)

                    Log("Encrypted file: " + file_path)
                except Exception as e:
                    Log("Error occurred while encrypting file: " + file_path)
                    Log("Error message: " + str(e))

    elif os.path.isfile(path):
        try:
            Log("Encrypting file: " + path + " With encoding: " + "utf-8")

            with open(path, 'r', encoding="utf-8") as f:
                data = f.read()

            data = data.replace(search, replace)

            with open(path, 'w', encoding="utf-8") as f:
                f.write(data)

            Log("Encrypted file: " + path)
        except Exception as e:
            Log("Error occurred while encrypting file: " + path)
            Log("Error message: " + str(e))

def SetNewEncryptions() -> None:
    # set the new encryptions
    Log("Setting new encryptions...")
    minlen = 3
    for cmdrep in CommandReplacements:
        Log("===========")
        Log("Original CVAR: " + cmdrep[1])
        cmdrep[2] = cmdrep[1][:len(cmdrep[1]) - int(len(cmdrep[1]) / minlen)] + ''.join(random.choice("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") for i in range(int(len(cmdrep[1]) / minlen)))
        Log("New CVAR:      " + cmdrep[2])
        Log("===========")

def UnEncryptEncryptions() -> None:
    Log("UnEncrypting Encryptions...")
    for cmdrep in CommandReplacements:
        cmdrep[2] = cmdrep[1]
    Log("Finished UnEncrypting Encryptions")

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
    print(lines)

    # find the admins section
    admins = lines.find("Admins <-")
    # find the next [ after the admins section
    nextObrack = lines.find("[", admins)
    # add the player line after the admins section
    for player in GVars.configData["Players"]["value"]:
        name = player["name"]
        level = player["adminLevel"]
        steamid = player["steamid"]
        print("Adding " + name + " to admins")

        lines = lines[:nextObrack + 1] + '\n"[' + level + "]" + steamid + '", // ' + name + lines[nextObrack + 1:]

    open(vsconfigfile, "w", encoding="utf-8").write(lines)

    Log("====================================================")

def MountMod(gamepath: str, encrypt: bool = False) -> bool:
    Log("            __________Mounting Mod Start_________")
    Log("Gathering DLC folder data...")

    modFilesPath = GVars.modPath + os.sep + "ModFiles" + os.sep + "Portal 2" + os.sep + "install_dlc"

    # find a place to mount the dlc
    dlcmountpoint = FindAvailableDLC(gamepath)

    destination = BF.CopyFolder(modFilesPath + os.sep+".", gamepath + os.sep + dlcmountpoint)
    Log(f"Successfully copied the ModsFiles to {destination}")

    nutConfigFile = gamepath + os.sep + dlcmountpoint + os.sep + "scripts" + os.sep + "vscripts" + os.sep + "multiplayermod" + os.sep + "config.nut"
    if os.path.exists(nutConfigFile):
        SetVScriptConfigFile(nutConfigFile)

    #### ENCRYPT THE CVARS #####
    Log("____ENCRYPTING CVARS____")
    if encrypt:
        SetNewEncryptions()
    else:
        UnEncryptEncryptions()
    path = gamepath + os.sep + dlcmountpoint

    if encrypt:
        for cmdrep in CommandReplacements:
            Encrypt(BF.NormalizePath(path), cmdrep[1], cmdrep[2])

    Log("__ENCRYPTING CVARS END__")

    # patch the binaries
    Log("            ___________Moving Files End__________")
    UnPatchBinaries(gamepath)

    PatchBinaries(gamepath)
    Log("            ___________Mounting Mod End__________")
    return True

def UnPatchBinaries(gamepath: str) -> None:
    binaries = [
        "bin" + os.sep + "linux32" + os.sep + "engine.so",
        "bin" + os.sep + "engine.dll",
        "portal2" + os.sep + "bin" + os.sep + "linux32" + os.sep + "server.so",
        "portal2" + os.sep + "bin" + os.sep + "server.dll",
    ]

    Log("             __________Binary Restoration_________")
    Log("Unpatching binaries...")
    for binary in binaries:
        # get the filename
        filename = binary.rsplit(os.sep, 1)[1]
        # delete the file from the gamepath if it exitsts
        if (os.path.isfile(gamepath + os.sep + filename)):
            Log("Deleting " + gamepath + os.sep + filename + "...")
            os.remove(gamepath + os.sep + filename)

    # unrename the binaries so we can move them
    UnRenameBinaries(gamepath, binaries)

def PatchBinaries(gamepath: str) -> None:
    Log("=============")
    Log("Patching binaries...")

    # move the binaries to the game directory
    Log("Moving the patched binaries to " + gamepath + "...")

    binaries = [
        "bin" + os.sep + "engine.dll",
        "portal2" + os.sep + "bin" + os.sep + "server.dll",
        "bin" + os.sep + "linux32" + os.sep + "engine.so",
        "portal2" + os.sep + "bin" + os.sep + "linux32" + os.sep + "server.so",
    ]

    Log("             _________Binary Moving Start________")
    for binary in binaries:
        Log("Moving " + binary + " to " + gamepath + "...")
        # Get the filename
        filename = binary.rsplit(os.sep, 1)[1]

        # If the file already exists, it will be replaced. There's no need to delete it manually.
        try:
            # copy the binary to the gamepath
            BF.CopyFile(gamepath + os.sep + binary, gamepath + os.sep + filename)
            Log("Copied " + binary +" to " + gamepath + os.sep + filename)
        except:
            # On Windows there is no "linux32" folder, so it just is logged that it doesn't exist
            Log("Unable to copy " + binary + ", since it doesn't exist!" )
    Log("             __________Binary Moving End_________")


    # patch the binaries
    ###/// ENGINE.DLL ///###
    if (os.path.isfile(gamepath + os.sep + "engine.dll")):
        Log("Patching engine.dll...")

        data = open(gamepath + os.sep + "engine.dll", "rb").read()

        # Delete the file
        os.remove(gamepath + os.sep + "engine.dll")

        # replace the data with our patches
        data = data.replace(b'\x84\xc0\x74\x1f\x8b\x16', b'\x84\xc0\xeb\x1f\x8b\x16')	      # Reject_Single_Player, commentary fix (i think)
        data = data.replace(b'\x74\x7d\x8b\x17', b'\xeb\x7d\x8b\x17')			              # Validation
        data = data.replace(b"\x0F\x95\xC1\x51\x8D\x4D\xE8", b"\x03\xC9\x90\x51\x8D\x4D\xE8") # Server Password Fix
        data = data.replace(b"\x85\xC0\x78\x13\x8B\x17", b"\x31\xC0\x04\x21\x8B\x17")		  # SetMaxClients always to 33

        # write the data back to the file
        open(gamepath + os.sep + "engine.dll", "wb").write(data)

    ###/// SERVER.DLL ///###
    if (os.path.isfile(gamepath + os.sep + "server.dll")):
        Log("Patching server.dll...")

        data = open(gamepath + os.sep + "server.dll", "rb").read()

        # Delete the file
        os.remove(gamepath + os.sep + "server.dll")
        

        data = data.replace(b'\x0F\xB6\x87\x04\x05\x00\x00', b'\xEB\x14\x87\x04\x05\x00\x00')  # CPortal_Player::NotifySystemEvent - Linked portal doors player_portaled event
        data = data.replace(b'\x83\xC0\x02\x89\x01', b'\x83\xC0\x20\x89\x01')				  # GetPlayerLimits patch

        # Replace the data
        # Player cap edit
        data = data.replace(b'\x8bM\x08\xc7\x00\x01\x00\x00\x00\xc7\x01\x01\x00\x00\x00\xff\x15', b'\x8bM\x08\xc7\x00\x20\x00\x00\x00\xc7\x01\x20\x00\x00\x00\xff\x15')
        data = data.replace(b'\xf7\xd8\x1b\xc0\xf7\xd8\x83\xc0\x02\x89\x01]', b'\xf7\xd8\x1b\xc0\xf7\xd8\x83\xc0 \x89\x01]')
        data = data.replace(b'\xff\xd0\x85\xc0t\x05\xbe\x03\x00\x00\x00\x8b', b'\xff\xd0\x85\xc0t\x05\xbe\x21\x00\x00\x00\x8b')
        data = data.replace(b'\xff\xd0\x85\xc0\x0f\x85\xaf\x05\x00\x00\xb0\x01_^', b'\xff\xd0\x85\xc0\x0f\x85\xaf\x05\x00\x00\xb0\x20_^')

        # Rename the server game description to "P2MM"
        data = data.replace(b'\x50\x6f\x72\x74\x61\x6c\x20\x32\x20\x43\x6f\x6f\x70', b'\x50\x6f\x72\x74\x61\x6c\x20\x32\x20\x3a\x20\x4d\x4d')

        # Partner disconnect edit
        data = data.replace(b'disconnect "Partner disconnected"', b'script Plyr_Disconnect_Function()')

        # Command patch edit
        Log("===Patching commands===")
        for cmdrep in CommandReplacements:
            Log("Replacing " + cmdrep[0] + " with " + cmdrep[2])
            data = data.replace(bytes(cmdrep[0], 'utf-8'), bytes(cmdrep[2], 'utf-8'))
        Log("==========Done=========")

        # write the data back to the file
        open(gamepath + os.sep + "server.dll", "wb").write(data)

    # The other files don't need to be patched since they don't exist on windows
    if GVars.iow:
        # rename the files so the new files are used
        Log("Renaming binaries...")
        RenameBinaries(gamepath, binaries)
        return

    ###/// ENGINE.SO ///###
    if (os.path.isfile(gamepath + os.sep + "engine.so")):
        Log("Patching engine.so...")

        data = open(gamepath + os.sep + "engine.so", "rb").read()

        # remove the file
        os.remove(gamepath + os.sep + "engine.so")
        
        # replace the data

        # commentary fix (i think)
        # Reject_Single_Player
        data = data.replace(b'\x84\xc0\x0f\x84\xf5\xfc', b'\x84\xc0\x90\xe9\xf5\xfc')

        # Validation
        data = data.replace(b'\x74\xc5\x8b\x06\x8d\x93', b'\xeb\xc5\x8b\x06\x8d\x93')

        # Server Password Fix
        data = data.replace(b'\x0F\x95\xC1\x51\x8D\x4D\xE8', b'\x03\xC9\x90\x51\x8D\x4D\xE8')

        # write the data back to the file
        open(gamepath + os.sep + "engine.so", "wb").write(data)

    ###/// SERVER.SO ///###
    if (os.path.isfile(gamepath + os.sep + "server.so")):
        Log("Patching server.so...")

        data = open(gamepath + os.sep + "server.so", "rb").read()

        # Remove the file
        os.remove(gamepath + os.sep + "server.so")

        # Replace the data
        # Player cap edit
        data = data.replace(b'\x01\x00\x00\x00\x8bD$\x14\xc7\x00\x01', b'\x1f\x00\x00\x00\x8bD$\x14\xc7\x00\x1f')
        data = data.replace(b'\xc0\x0f\xb6\xc0\x83\xc0\x02\x89\x02\x83\xc4', b'\xc0\x0f\xb6\xc0\x83\xc0 \x89\x02\x83\xc4')
        data = data.replace(b'\x0f\xb6\xc0\x83\xc0\x02\x83\xec\x04\x89\xf3', b'\x0f\xb6\xc0\x83\xc0 \x83\xec\x04\x89\xf3')
        data = data.replace(b'K\x8de\xf4\xb8\x01\x00\x00\x00[^', b'K\x8de\xf4\xb8\x1f\x00\x00\x00[^')

        # Rename the server game description to our mod
        data = data.replace(b'\x50\x6f\x72\x74\x61\x6c\x20\x32\x20\x43\x6f\x6f\x70', b'\x50\x6f\x72\x74\x61\x6c\x20\x32\x20\x3a\x20\x4d\x4d')

        # Partner disconnect edit
        data = data.replace(b'disconnect "Partner disconnected"', b'script Plyr_Disconnect_Function()')

        # Command patch edit
        Log("===Patching commands===")
        for cmdrep in CommandReplacements:
            Log("Replacing " + cmdrep[0] + " with " + cmdrep[2])
            data = data.replace(bytes(cmdrep[0], 'utf-8'), bytes(cmdrep[2], 'utf-8'))
        Log("==========Done=========")

        # write the data back to the file
        open(gamepath + os.sep + "server.so", "wb").write(data)

    # rename the files so the new files are used
    Log("Renaming binaries...")
    RenameBinaries(gamepath, binaries)

def RenameBinaries(gamepath: str, binaries: list[str]) -> None:
    # go through the list of binaries
    for binary in binaries:
        filename = binary.rsplit(os.sep, 1)[1]
        # if the binary exists
        extra = "Portal2" + os.sep + "bin" + os.sep
        if (os.path.isfile(gamepath + os.sep + binary)):
            # add a ".p2mmoverride" to the end of the binary
            os.rename(gamepath + os.sep + binary, gamepath + os.sep + binary + ".p2mmoverride")
            Log("Renamed " + binary + " to " + binary + ".p2mmoverride")

            if filename.startswith("engine"):
                extra = "bin" + os.sep
            # copy the binary to the gamepath
            BF.MoveFile(gamepath + os.sep + filename,
                        gamepath + os.sep + extra + filename)

def UnRenameBinaries(gamepath: str, binaries: list[str]) -> None:
    # binaries = [
    #     "bin/linux32/engine.so",
    #     "bin/engine.dll",
    #     "portal2/bin/linux32/server.so",
    #     "portal2/bin/server.dll",
    # ]

    Log("Un-renaming binaries...")

    # Go through the list of binaries
    for Og_binary in binaries:
        # Add a ".p2mmoverride" file extension to the end of the binary's name
        binary = Og_binary + ".p2mmoverride"
        # If the binary exists
        if (os.path.isfile(gamepath + os.sep + binary)):
            Log("Un-renaming " + binary + " to " + Og_binary)

            # If a file with the original binary's name exist delete it
            if (os.path.isfile(gamepath + os.sep + Og_binary)):
                os.remove(gamepath + os.sep + Og_binary)

            # Rename the binary back to it's original name
            os.rename(gamepath + os.sep + binary, gamepath + os.sep + Og_binary)

# Using the identifier file in P2MM's DLC folder, it can be determined 
# which DLC that is mounted to Portal 2 is in fact P2MM's DLC folder
def findP2MMDLCFolder(gamepath: str) -> str:
    for file in os.listdir(gamepath):
        # find all the folders that start with "portal2_dlc"
        if file.startswith("portal2_dlc") and os.path.isdir(gamepath + os.sep + file):

            # find and return where the identifier file is
            #! REMEMBER TO CHANGE THIS BACK BEFORE 2.2 RELEASE!!!
            if "p2mm.identifier" in os.listdir(gamepath + os.sep + file):
            #if "32playermod.identifier" in os.listdir(gamepath + os.sep + file):
                p2mmdlcfolder = gamepath + os.sep + file
                Log("Found P2MM's DLC folder: " + p2mmdlcfolder)
                return p2mmdlcfolder
    Log("P2MM's DLC folder was not found...")
    Log("It's most likely not been mounted to Portal 2 yet or the gamepath is incorrect...")
    return False

# Make sure the dlc folders that come with Portal 2 exist
# They are required since they include stuff for multiplayer and fixes for other things Portal 2 related
# portal2_dlc1 is required for multiplayer to work since it includes mp_coop_lobby_3 and the stuff for the DLC course Art Therapy
# portal2_dlc2 is also required, while its mainly for PeTi, it also includes a bunch of other assets and fixes for Portal 2 that Valve had done
# If either of these folders are not detected P2MM won't start or be mounted
def CheckForRequiredDLC(gamepath: str) -> bool:
    Log("Checking for DLC folders portal2_dlc1 and portal2_dlc2...")

    if (not os.path.exists(gamepath + os.sep + "portal2_dlc1")) or (not os.path.exists(gamepath + os.sep + "portal2_dlc2")):
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

    foundp2mmdlcfolder = findP2MMDLCFolder(gamepath)
    if foundp2mmdlcfolder != False:
        Log("Found old DLC: " + foundp2mmdlcfolder)
        # delete the folder even if it's not empty
        BF.DeleteFolder(foundp2mmdlcfolder)
        Log("Deleted old DLC: " + foundp2mmdlcfolder)

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

    # LAUNCH OPTIONS: -applaunch 620 -novid -allowspectators -nosixense +developer 918612 +clear -conclearlog -usercon (Custom-Launch-Options)
    try:
        if (GVars.iow): #launching for windows
            # start portal 2 with the launch options and dont wait for it to finish
            def RunGame() -> None:
                # start portal 2 with the launch options and dont wait for it to finish
                subprocess.run([gamepath + os.sep + "portal2.exe", "-novid", "-allowspectators", "-nosixense", "+developer 918612", "+clear", "-conclearlog", "-usercon", GVars.configData["Custom-Launch-Options"]["value"]])
                Log("Game exited successfully.")
                # Run The AfterFunction
                GVars.AfterFunction()
            # start the game in a new thread
            thread = threading.Thread(target=RunGame)
            thread.start()
        elif (GVars.iol or GVars.iosd): #launching for linux
            def RunGame():
                def RunSteam():
                    os.system("steam -applaunch 620 -novid -allowspectators -nosixense +developer 918612 +clear -conclearlog -usercon" + GVars.configData["Custom-Launch-Options"]["value"])
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