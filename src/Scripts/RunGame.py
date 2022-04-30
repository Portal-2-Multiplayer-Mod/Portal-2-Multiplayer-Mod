# █ █▀▄▀█ █▀█ █▀█ █▀█ ▀█▀ █▀   ▄█▄   █░█ ▄▀█ █▀█ █ █▄▄ █░░ █▀▀ █▀
# █ █░▀░█ █▀▀ █▄█ █▀▄ ░█░ ▄█   ░▀░   ▀▄▀ █▀█ █▀▄ █ █▄█ █▄▄ ██▄ ▄█

import os
from secrets import choice
import subprocess
from Scripts.BasicLogger import Log
import Scripts.GlobalVariables as GVars
import Scripts.EncryptCVars as EncryptCVars
import Scripts.BasicFunctions as BF
import random
import __main__
import shutil

CommandReplacements = [
    ['restart_level', 'portal2mprslv', 'portal2mprslv'],
    ['mp_restart_level', 'portal2mpmprslev', 'portal2mpmprslev'],
    ['mp_earn_taunt', 'portal2mpmper', 'portal2mpmper'],
    ['pre_go_to_calibration', 'portal2multiplayrpgtc', 'portal2multiplayrpgtc'],
    ['erase_mp_progress', 'portal2multiemppg', 'portal2multiemppg'],
    ['mp_mark_all_maps_complete', 'portal2multiplayermpmamcp', 'portal2multiplayermpmamcp'],
    ['mp_mark_all_maps_incomplete', 'portal2multiplayermodmpmami', 'portal2multiplayermodmpmami'],
    ['pre_go_to_hub', 'portal2mppgth', 'portal2mppgth'],
    ['transition_map', 'portal2mptrmap', 'portal2mptrmap'],
    ['select_map', 'p2mpselmap', 'p2mpselmap'],
    ['mp_select_level', 'portal2mpmpsell', 'portal2mpmpsell'],
    ['mp_mark_course_complete', 'portal2multiplayermpmcc', 'portal2multiplayermpmcc'],
    ['script_execute', 'script_execute', 'script_execute'],
]


# █▀▀ █ █░░ █▀▀   █▀▄▀█ █▀█ █░█ █▄░█ ▀█▀ █▀▀ █▀█
# █▀░ █ █▄▄ ██▄   █░▀░█ █▄█ █▄█ █░▀█ ░█░ ██▄ █▀▄

def SetNewEncryptions():
    # set the new encryptions
    Log("Setting new encryptions...")
    Log("")
    minlen = 3
    for cmdrep in CommandReplacements:
        Log("===========")
        Log("Original CVAR: " + cmdrep[1])
        cmdrep[2] = cmdrep[1][:len(cmdrep[1]) - int(len(cmdrep[1]) / minlen)] + ''.join(random.choice("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") for i in range(int(len(cmdrep[1]) / minlen)))
        Log("New CVAR:      " + cmdrep[2])
        Log("===========")

def UnEncryptEncryptions():
    Log("UnEncrypting Encryptions...")
    for cmdrep in CommandReplacements:
        cmdrep[2] = cmdrep[1]
    Log("Finished UnEncrypting Encryptions")
        
def MountMod(gamepath, encrypt = True):
    Log("")
    Log("            __________Mounting Mod Start_________")
    Log("Gathering DLC folder data...")
    
    modFilesPath = GVars.modPath + GVars.nf + "ModFiles" + GVars.nf + "Portal 2" + GVars.nf + "install_dlc"
    
    # find a place to mount the dlc
    dlcmountpoint = FindAvailableDLC(gamepath)
    
    destination = shutil.copytree(modFilesPath + GVars.nf+".", gamepath + GVars.nf + dlcmountpoint)
    Log("Successfully copied the mod files to "+ destination)

    #### ENCRYPT THE CVARS #####
    Log("____ENCRYPTING CVARS____")
    if encrypt:
        SetNewEncryptions()
    else:
        UnEncryptEncryptions()
    path = gamepath + GVars.nf + dlcmountpoint

    for cmdrep in CommandReplacements:
        EncryptCVars.Encrypt(BF.ConvertPath(path), cmdrep[1], cmdrep[2])

    Log("__ENCRYPTING CVARS END__")

    # patch the binaries
    Log("            ___________Moving Files End__________")
    UnpatchBinaries(gamepath)

    PatchBinaries(gamepath)
    Log("            ___________Mounting Mod End__________")
    return True

def UnpatchBinaries(gamepath):
    binarys = [
        "bin" + GVars.nf + "linux32" + GVars.nf + "engine.so",
        "bin" + GVars.nf + "engine.dll",
        "portal2" + GVars.nf + "bin" + GVars.nf + "linux32" + GVars.nf + "server.so",
        "portal2" + GVars.nf + "bin" + GVars.nf + "server.dll",
    ]

    Log("")
    Log("             __________Binary Restoration_________")
    Log("Unpatching binaries...")
    for binary in binarys:
        # get the filename
        filename = binary.rsplit(GVars.nf, 1)[1]
        # delete the file from the gamepath if it exitsts
        if (os.path.isfile(gamepath + GVars.nf + filename)):
            Log("Deleting " + gamepath + GVars.nf + filename + "...")
            os.remove(gamepath + GVars.nf + filename)

    # unrename the binaries so we can move them
    UnRenameBinaries(gamepath, binarys)

def PatchBinaries(gamepath):
    Log("")
    Log("Patching binaries...")

    # move the binaries to the game directory
    Log("Moving the patched binaries to " + gamepath + "...")
    Log("")

    binarys = [
        "bin" + GVars.nf + "engine.dll",
        "portal2" + GVars.nf + "bin" + GVars.nf + "server.dll",
        "bin" + GVars.nf + "linux32" + GVars.nf + "engine.so",
        "portal2" + GVars.nf + "bin" + GVars.nf + "linux32" + GVars.nf + "server.so",
    ]

    Log("")
    Log("             _________Binary Moving Start________")
    for binary in binarys:
        Log("Moving " + binary + " to " + gamepath + "...")
        # Get the filename
        filename = binary.rsplit(GVars.nf, 1)[1]

        # If the file already exists, it will be replaced. There's no need to delete it manually.
        try:
            # copy the binary to the gamepath
            shutil.copyfile(gamepath + GVars.nf + binary,gamepath + GVars.nf + filename)
            Log("Copied " + binary+" to " + gamepath + GVars.nf + filename)
        except:
            # On Windows there is no "linux32" folder, so we avoid an error.
            Log("Unable to copy "+ binary+", since it doesn't exist!" )
    Log("             __________Binary Moving End_________")


    # patch the binaries
    ###/// ENGINE.DLL ///###
    if (os.path.isfile(gamepath + GVars.nf + "engine.dll")):
        Log("")
        Log("Patching engine.dll...")
        
        data = open(gamepath + GVars.nf + "engine.dll", "rb").read()
        
        # Delete the file
        os.remove(gamepath + GVars.nf + "engine.dll")
        # replace the data
        data = data.replace(bytes.fromhex("84 c0 74 1f 8b 16 8b 82 cc 00 00 00 68 98 b0 37 10 53 56 ff d0 83 c4 0c 5b 5f 33 c0 5e 8b e5 5d c2 2c 00 8b 16 8b 42 6c 8b ce ff d0 84 c0 75 78 8b 16 8b 42 70 8b ce ff d0 84 c0 75 6b 8b 45 14 8b 16 8b 92 d0 00 00 00 50 53 8b ce ff d2 84 c0 75 0c 8b"), bytes.fromhex("84 d8 74 1f 8b 16 8b 82 cc 00 00 00 68 98 b0 37 10 53 56 ff d0 83 c4 0c 5b 5f 33 c0 5e 8b e5 5d c2 2c 00 8b 16 8b 42 6c 8b ce ff d0 84 c0 75 78 8b 16 8b 42 70 8b ce ff d0 84 c0 75 6b 8b 45 14 8b 16 8b 92 d0 00 00 00 50 53 8b ce ff d2 84 c0 75 0c 8b"))

        data = data.replace(bytes.fromhex("83 f8 03 0f 85 dd 00 00 00 8b 4d 08 33 c0 8d 55 f8 52 89 45 f8 89 45 fc e8 10 27 f2 ff 8b 5d 1c 8d 43 ff 3d fe 07 00 00 0f 87 90 00 00 00 8b 75 10 8b 0e 8b 56 04 8b 46 08 89 4d ec 8b ce 89 55 f0 89 45 f4 e8 c4 3b 14 00 83 f8 01 74 0b 8b ce e8 48 3b 14 00 84 c0 74 13 b9 ac e0 6a 10 e8 ca 3b 14 00 50 8d 4d ec e8 01 3d 14 00 8b 4d 18 8b 45 0c 53 51 8b 4d 08 8d 55 ec 52 50 51 e8 ab a2 ff ff 8b c8 e8 d4"), bytes.fromhex("83 f8 69 0f 85 dd 00 00 00 8b 4d 08 33 c0 8d 55 f8 52 89 45 f8 89 45 fc e8 10 27 f2 ff 8b 5d 1c 8d 43 ff 3d fe 07 00 00 0f 87 90 00 00 00 8b 75 10 8b 0e 8b 56 04 8b 46 08 89 4d ec 8b ce 89 55 f0 89 45 f4 e8 c4 3b 14 00 83 f8 01 74 0b 8b ce e8 48 3b 14 00 84 c0 74 13 b9 ac e0 6a 10 e8 ca 3b 14 00 50 8d 4d ec e8 01 3d 14 00 8b 4d 18 8b 45 0c 53 51 8b 4d 08 8d 55 ec 52 50 51 e8 ab a2 ff ff 8b c8 e8 d4"))
        # write the data back to the file
        open(gamepath + GVars.nf + "engine.dll", "wb").write(data)

    ###/// SERVER.DLL ///###
    if (os.path.isfile(gamepath + GVars.nf + "server.dll")):
        Log("Patching server.dll...")
        
        data = open(gamepath + GVars.nf + "server.dll", "rb").read()
        
        # Delete the file
        os.remove(gamepath + GVars.nf + "server.dll")
        # replace the data
        # 33 player cap edit
        data = data.replace(b'\x8bM\x08\xc7\x00\x01\x00\x00\x00\xc7\x01\x01\x00\x00\x00\xff\x15', b'\x8bM\x08\xc7\x00\x20\x00\x00\x00\xc7\x01\x20\x00\x00\x00\xff\x15')
        data = data.replace(b'\xf7\xd8\x1b\xc0\xf7\xd8\x83\xc0\x02\x89\x01]', b'\xf7\xd8\x1b\xc0\xf7\xd8\x83\xc0 \x89\x01]')
        data = data.replace(b'\xff\xd0\x85\xc0t\x05\xbe\x03\x00\x00\x00\x8b', b'\xff\xd0\x85\xc0t\x05\xbe\x21\x00\x00\x00\x8b')
        data = data.replace(b'\xff\xd0\x85\xc0\x0f\x85\xaf\x05\x00\x00\xb0\x01_^', b'\xff\xd0\x85\xc0\x0f\x85\xaf\x05\x00\x00\xb0\x20_^')

        # Partner disconnect edit
        data = data.replace(b'disconnect "Partner disconnected"', b'script EntFire("pdcm", "display")')

        # Command patch edit
        Log("===Patching commands===")
        for cmdrep in CommandReplacements:
            Log("Replacing " + cmdrep[0] + " with " + cmdrep[2])
            data = data.replace(bytes(cmdrep[0], 'utf-8'), bytes(cmdrep[2], 'utf-8'))
        Log("==========Done=========")
        # data = data.replace(b'restart_level', b'portal2mprslv')
        # data = data.replace(b'mp_restart_level', b'portal2mpmprslev')
        # data = data.replace(b'mp_earn_taunt', b'portal2mpmper')
        # data = data.replace(b'pre_go_to_calibration', b'portal2multiplayrpgtc')
        # data = data.replace(b'erase_mp_progress', b'portal2multiemppg')
        # data = data.replace(b'mp_mark_all_maps_complete', b'portal2multiplayermpmamcp')
        # data = data.replace(b'mp_mark_all_maps_incomplete', b'portal2multiplayermodmpmami')
        # data = data.replace(b'pre_go_to_hub', b'portal2mppgth')
        # data = data.replace(b'transition_map', b'portal2mptrmap')
        # data = data.replace(b'select_map', b'p2mpselmap')
        # data = data.replace(b'mp_select_level', b'portal2mpmpsell')
        # data = data.replace(b'mp_mark_course_complete', b'portal2multiplayermpmcc')

        # write the data back to the file
        open(gamepath + GVars.nf + "server.dll", "wb").write(data)
        Log("")
        
    # we don't need to patch the other files since they don't exist on windows
    if GVars.iow:
        # rename the files so the new files are used
        Log("Renaming binaries...")
        RenameBinaries(gamepath, binarys)
        return

    ###/// ENGINE.SO ///###
    if (os.path.isfile(gamepath + GVars.nf + "engine.so")):
        Log("")
        Log("Patching engine.so...")
        
        data = open(gamepath + GVars.nf + "engine.so", "rb").read()
        
        # remove the file
        os.remove(gamepath + GVars.nf + "engine.so")
        # replace the data
        # commentary fix (i think)
        data = data.replace(bytes.fromhex("84 c0 0f 84 f5 fc ff ff 8b 06 8d 93 ee 96 d5 ff 83 ec 04 e9 6b ff ff ff 83 ec 0c ff b4 24 80 00 00 00 e8 31 76 2a 00 89 c7 89 34 24 e8 47 c1 ff ff 83 c4 10 84 c0 8b 06 0f 84 99 fc ff ff 8b 96 6c 01 00 00 0b 96 70 01 00 00 0f 85 87 fc ff ff 89 f9 84 c9 0f 85 7d fc ff ff 83 ec 08 8b b8 d0 00 00 00 6a 00 ff b4 24 80 00 00 00 e8 b7 74 2a 00 5a ff b4 24 88 00 00 00 50 8d 83 44 a0 d5 ff 50 ff b4 24 8c 00 00 00 56 ff d7 83 c4 20 31 ff e9 ff fe ff ff 8d"), bytes.fromhex("84 d8 0f 84 f5 fc ff ff 8b 06 8d 93 ee 96 d5 ff 83 ec 04 e9 6b ff ff ff 83 ec 0c ff b4 24 80 00 00 00 e8 31 76 2a 00 89 c7 89 34 24 e8 47 c1 ff ff 83 c4 10 84 c0 8b 06 0f 84 99 fc ff ff 8b 96 6c 01 00 00 0b 96 70 01 00 00 0f 85 87 fc ff ff 89 f9 84 c9 0f 85 7d fc ff ff 83 ec 08 8b b8 d0 00 00 00 6a 00 ff b4 24 80 00 00 00 e8 b7 74 2a 00 5a ff b4 24 88 00 00 00 50 8d 83 44 a0 d5 ff 50 ff b4 24 8c 00 00 00 56 ff d7 83 c4 20 31 ff e9 ff fe ff ff 8d"))
        # steam validation removal
        data = data.replace(bytes.fromhex("83 f8 03 74 6c e8 a7 7d 24 00 83 ec 08 ff 74 24 4c 50 e8 ca 93 24 00 83 c4 10 84 c0 75 20 8b 16 88 44 24 0f 8d 8b 56 94 d5 ff 83 ec 04 51 57 56 ff 92 d0 00 00 00 0f b6 44 24 1f 83 c4 10 83 c4 2c 5b 5e 5f 5d c3 8d 76 00 8b 06 8d 93 26 94 d5 ff"), bytes.fromhex("83 f8 69 74 6c e8 a7 7d 24 00 83 ec 08 ff 74 24 4c 50 e8 ca 93 24 00 83 c4 10 84 c0 75 20 8b 16 88 44 24 0f 8d 8b 56 94 d5 ff 83 ec 04 51 57 56 ff 92 d0 00 00 00 0f b6 44 24 1f 83 c4 10 83 c4 2c 5b 5e 5f 5d c3 8d 76 00 8b 06 8d 93 26 94 d5 ff"))
        # write the data back to the file
        open(gamepath + GVars.nf + "engine.so", "wb").write(data)

    ###/// SERVER.SO ///###
    if (os.path.isfile(gamepath + GVars.nf + "server.so")):
        Log("Patching server.so...")
        
        data = open(gamepath + GVars.nf + "server.so", "rb").read()
        
        # remove the file
        os.remove(gamepath + GVars.nf + "server.so")
        # replace the data
        # 33 player cap edit
        data = data.replace(b'\x01\x00\x00\x00\x8bD$\x14\xc7\x00\x01', b'\x1f\x00\x00\x00\x8bD$\x14\xc7\x00\x1f')
        data = data.replace(b'\xc0\x0f\xb6\xc0\x83\xc0\x02\x89\x02\x83\xc4', b'\xc0\x0f\xb6\xc0\x83\xc0 \x89\x02\x83\xc4')
        data = data.replace(b'\x0f\xb6\xc0\x83\xc0\x02\x83\xec\x04\x89\xf3', b'\x0f\xb6\xc0\x83\xc0 \x83\xec\x04\x89\xf3')
        data = data.replace(b'K\x8de\xf4\xb8\x01\x00\x00\x00[^', b'K\x8de\xf4\xb8\x1f\x00\x00\x00[^')

        # Partner disconnect edit
        data = data.replace(b'disconnect "Partner disconnected"', b'script EntFire("pdcm", "display")')

        # Command patch edit
        Log("===Patching commands===")
        for cmdrep in CommandReplacements:
            Log("Replacing " + cmdrep[0] + " with " + cmdrep[2])
            data = data.replace(bytes(cmdrep[0], 'utf-8'), bytes(cmdrep[2], 'utf-8'))
        Log("==========Done=========")
        # data = data.replace(b'restart_level', b'portal2mprslv')
        # data = data.replace(b'mp_restart_level', b'portal2mpmprslev')
        # data = data.replace(b'mp_earn_taunt', b'portal2mpmper')
        # data = data.replace(b'pre_go_to_calibration', b'portal2multiplayrpgtc')
        # data = data.replace(b'erase_mp_progress', b'portal2multiemppg')
        # data = data.replace(b'mp_mark_all_maps_complete', b'portal2multiplayermpmamcp')
        # data = data.replace(b'mp_mark_all_maps_incomplete', b'portal2multiplayermodmpmami')
        # data = data.replace(b'pre_go_to_hub', b'portal2mppgth')
        # data = data.replace(b'transition_map', b'portal2mptrmap')
        # data = data.replace(b'select_map', b'p2mpselmap')
        # data = data.replace(b'mp_select_level', b'portal2mpmpsell')
        # data = data.replace(b'mp_mark_course_complete', b'portal2multiplayermpmcc')

        # write the data back to the file
        open(gamepath + GVars.nf + "server.so", "wb").write(data)
        Log("")

    # rename the files so the new files are used
    Log("Renaming binaries...")
    RenameBinaries(gamepath, binarys)

def RenameBinaries(gamepath, binarys):
    # binarys = [
    #     "bin/linux32/engine.so",
    #     "bin/engine.dll",
    #     "portal2/bin/linux32/server.so",
    #     "portal2/bin/server.dll",
    # ]

    # go through the list of binaries
    for binary in binarys:
        # if the binary exists
        if (os.path.isfile(gamepath + GVars.nf + binary)):
            # add a ".p2mmoverride" to the end of the binary
            os.rename(gamepath + GVars.nf + binary, gamepath + GVars.nf + binary + ".p2mmoverride")
            Log("Renamed " + binary + " to " + binary + ".p2mmoverride")

def UnRenameBinaries(gamepath, binarys):
    # binarys = [
    #     "bin/linux32/engine.so",
    #     "bin/engine.dll",
    #     "portal2/bin/linux32/server.so",
    #     "portal2/bin/server.dll",
    # ]

    Log("")
    Log("Un-renaming binaries...")

    # Go through the list of binaries
    for binary in binarys:
        # Add a ".p2mmoverride" file extension to the end of the binary
        binary = binary + ".p2mmoverride"
        # If the binary exists,
        if (os.path.isfile(gamepath + GVars.nf + binary)):
            Log("Un-renaming " + binary + " to " + binary[:-13])
            # If a file with the name gamepath + GVars.nf + binary[:-13] exists
            if (os.path.isfile(gamepath + GVars.nf + binary[:-13])):
                # Remove it
                os.remove(gamepath + GVars.nf + binary)
            else:
                # Rename the binary back to the original
                os.rename(gamepath + GVars.nf + binary, gamepath + GVars.nf + binary[:-13])

def DeleteUnusedDlcs(gamepath):
    Log("")
    Log("            _________Dealing with Folders________")
    
    if ((os.path.exists(gamepath)) != True) or (os.path.exists(gamepath + GVars.nf + "portal2_dlc2") != True):
        Log("Portal 2 game path not found!")
        return "undefined"
    
    # go through each file in the gamepath
    for file in os.listdir(gamepath):
        # find all the folders that start with "portal2_dlc"
        if file.startswith("portal2_dlc") and os.path.isdir(gamepath + GVars.nf + file):
            # if inside the folder there is a file called "32playermod.identifier" delete this folder
            if "32playermod.identifier" in os.listdir(gamepath + GVars.nf + file):
                Log("Found old DLC: " + file)
                # delete the folder even if it's not empty
                shutil.rmtree(gamepath + GVars.nf + file)
                Log("Deleted old DLC: " + file)
    
    return True

def FindAvailableDLC(gamepath):
    Log("Finding the next increment in DLC folders...")
    dlcs = []
    DeleteUnusedDlcs(gamepath)
    # go through each file in the gamepath
    for file in os.listdir(gamepath):
        # find all the folders that start with "portal2_dlc"
        if file.startswith("portal2_dlc") and os.path.isdir(gamepath + GVars.nf + file):
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

def LaunchGame(gamepath):
    Log("")
    Log("Running Game...")
    
    # LAUNCH OPTIONS: -applaunch 620 -novid -allowspectators -nosixense +map mp_coop_lobby_3 +developer 918612 -conclearlog -condebug -console
    try:
        if (GVars.iow):
            # start portal 2 with the launch options and dont wait for it to finish
            subprocess.run([gamepath + GVars.nf + "portal2.exe", "-novid", "-allowspectators", "-nosixense", "+map mp_coop_lobby_3", "+developer 918612", "+clear", "-conclearlog", "-condebug", "-console"])
            Log("Game exited successfully.")
        else:
            os.system("steam -applaunch 620 -novid -allowspectators -nosixense +map mp_coop_lobby_3 +developer 918612 +clear -conclearlog -condebug -console")
            Log("Game launch successful!")

    except Exception as e:
        Log("Failed to launch Portal 2!")
        Log("Error: " + str(e))
        quit()