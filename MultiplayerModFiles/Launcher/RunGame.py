# █ █▀▄▀█ █▀█ █▀█ █▀█ ▀█▀ █▀   ▄█▄   █░█ ▄▀█ █▀█ █ █▄▄ █░░ █▀▀ █▀
# █ █░▀░█ █▀▀ █▄█ █▀▄ ░█░ ▄█   ░▀░   ▀▄▀ █▀█ █▀▄ █ █▄█ █▄▄ ██▄ ▄█

from http.client import LineTooLong
import os
import subprocess


#/////////////////////////////////////////////////////////////////#
#//# detect if we are on windows (by default, we are on Linux) #//#
#/////////////////////////////////////////////////////////////////#

# iow = Is On Windows
iow = False

# nt is the windows os
if os.name == 'nt':
    print("")
    print("(P2:MM) Windows OS detected!")
    nf = "\\"
    iow = True
else:
    nf = "/"
    print("")
    print("(P2:MM) Linux OS detected!")



#///////////////////////////////#
#//# get the local user path #//#
#///////////////////////////////#

if (iow):
    homefolder = os.environ['USERPROFILE']
else:
    homefolder = os.path.expanduser("~")

print("(P2:MM) Home Folder: " + homefolder)

print("")

#////////////////////////////////////////////////////////////#
#//# ask the user if they want to mount or unmout the mod #//#
#////////////////////////////////////////////////////////////#

validinput = False
WillMount = True
while (not validinput):
    ShouldMount = input("(===) Do you want to mount or unmount the mod? (mount/unmount): ")
    if (ShouldMount == "mount" or ShouldMount == "unmount"):
        validinput = True
    if (ShouldMount == "unmount"):
        WillMount = False
    
print("")
print("(P2:MM) " + ShouldMount + "ing the mod...")

# █▀█ ▄▀█ ▀█▀ █░█   █▀▄ █▀▀ ▀█▀ █▀▀ █▀▀ ▀█▀ █▀█ █▀█
# █▀▀ █▀█ ░█░ █▀█   █▄▀ ██▄ ░█░ ██▄ █▄▄ ░█░ █▄█ █▀▄



# █▀▀ █ █░░ █▀▀   █▀▄▀█ █▀█ █░█ █▄░█ ▀█▀ █▀▀ █▀█
# █▀░ █ █▄▄ ██▄   █░▀░█ █▄█ █▄█ █░▀█ ░█░ ██▄ █▀▄

def MountMod(gamepath):
    print("")
    print("(P2:MM) Mounting Mod...")
    # find a place to mount the dlc
    dlcmountpoint = FindAvalibleDLC(gamepath)
    # detect if we have a MultiplayModFiles folder
    if "MultiplayerModFiles" in os.listdir(gamepath):
        print("(P2:MM) MultiplayerModFiles folder found!")
    else:
        print("(P2:MM) MultiplayerModFiles folder not found!")
        print("(P2:MM) Creating MultiplayerModFiles folder...")
        os.mkdir(gamepath + nf + "MultiplayerModFiles")
        print("(P2:MM) MultiplayerModFiles folder created!")
    
    # copy MultiplayerModFiles/ModFiles/Portal 2 to the gamepath
    print("(P2:MM) Copying ModFiles folder to " + gamepath + nf + "MultiplayerModFiles" + nf + "ModFiles" + nf + "portal2...")
    # if on windows, use the command line to copy the folder
    if (iow):
        command = "xcopy /E /I /Y \"" + gamepath + nf + "MultiplayerModFiles" + nf + "ModFiles" + nf + "Portal 2\" \"" + gamepath + "\""
        print("(P2:MM) Command: " + command)
        os.system(command)
    else:
        command = "cp -r \"" + gamepath + nf + "MultiplayerModFiles" + nf + "ModFiles" + nf + "Portal 2\" \"" + gamepath.replace("Portal 2", "") + "\""
        print("(P2:MM) Command: " + command)
        # if on linux, use the command line
        os.system(command)
    

    # after we are done copying, we need to rename the install_dlc folder
    print("(P2:MM) Renaming install_dlc folder to " + dlcmountpoint + "...")
    # windows command
    if (iow):
        command = "move \"" + gamepath + nf + "install_dlc\" \"" + gamepath + nf + dlcmountpoint + "\""
        print("(P2:MM) Command: " + command)
        os.system(command)
    # linux command
    else:
        command = "mv \"" + gamepath + nf + "install_dlc\" \"" + gamepath + nf + dlcmountpoint + "\""
        print("(P2:MM) Command: " + command)
        os.system(command)

def UnpatchBinaries(gamepath):
    binarys = [
        "bin" + nf + "linux32" + nf + "engine.so",
        "bin" + nf + "engine.dll",
        "portal2" + nf + "bin" + nf + "linux32" + nf + "server.so",
        "portal2" + nf + "bin" + nf + "server.dll",
    ]

    print("")
    print("(P2:MM) Unpatching Binarys...")
    for binary in binarys:
        # get the filename
        filename = binary.rsplit(nf, 1)[1]
        # delete the file from the gamepath if it exitsts
        if (os.path.isfile(gamepath + nf + filename)):
            print("(P2:MM) Deleting " + gamepath + nf + filename + "...")
            os.remove(gamepath + nf + filename)

    # unrename the binaries so we can move them
    UnRenameBinaries(gamepath, binarys)

def PatchBinaries(gamepath):
    print("")
    print("(P2:MM) Patching Binarys...")

    # move the binaries to the game path area
    print("")
    print("(P2:MM) Moving binaries to " + gamepath + "...")
    print("")

    binarys = [
        "bin" + nf + "linux32" + nf + "engine.so",
        "bin" + nf + "engine.dll",
        "portal2" + nf + "bin" + nf + "linux32" + nf + "server.so",
        "portal2" + nf + "bin" + nf + "server.dll",
    ]

    # unrename the binaries so we can move them
    UnRenameBinaries(gamepath, binarys)

    print("BINARY MOVING==========================================================")
    print("")
    for binary in binarys:
        print("(P2:MM) Moving " + binary + " to " + gamepath + "...")
        # get the filename
        filename = binary.rsplit(nf, 1)[1]
        # if the filename already exists, delete it
        if (os.path.isfile(gamepath + nf + filename)):
            print("(P2:MM) File already exists, deleting...")
            os.remove(gamepath + nf + filename)

        # copy the binary to the gamepath
        # windows command
        if (iow):
            command = "copy \"" + gamepath + nf + binary + "\" \"" + gamepath + nf + filename + "\""
            print("(P2:MM) Command: " + command)
            os.system(command)
        # linux command
        else:
            command = "cp \"" + gamepath + nf + binary + "\" \"" + gamepath + nf + filename + "\""
            print("(P2:MM) Command: " + command)
            os.system(command)
        
        print("")
    print("BINARY MOVING END======================================================")


    print("")
    print("BINARY PATCHING========================================================")
    print("")
    # patch the binaries
    ###/// ENGINE.DLL ///###
    if (os.path.isfile(gamepath + nf + "engine.dll")):
        print("(P2:MM) Patching engine.dll...")
        f = open(gamepath + nf + "engine.dll", "rb")
        data = f.read()
        f.close()
        # remove the file
        os.remove(gamepath + nf + "engine.dll")
        # replace the data
        data = data.replace(bytes.fromhex("84 c0 74 1f 8b 16 8b 82 cc 00 00 00 68 98 b0 37 10 53 56 ff d0 83 c4 0c 5b 5f 33 c0 5e 8b e5 5d c2 2c 00 8b 16 8b 42 6c 8b ce ff d0 84 c0 75 78 8b 16 8b 42 70 8b ce ff d0 84 c0 75 6b 8b 45 14 8b 16 8b 92 d0 00 00 00 50 53 8b ce ff d2 84 c0 75 0c 8b"), bytes.fromhex("84 d8 74 1f 8b 16 8b 82 cc 00 00 00 68 98 b0 37 10 53 56 ff d0 83 c4 0c 5b 5f 33 c0 5e 8b e5 5d c2 2c 00 8b 16 8b 42 6c 8b ce ff d0 84 c0 75 78 8b 16 8b 42 70 8b ce ff d0 84 c0 75 6b 8b 45 14 8b 16 8b 92 d0 00 00 00 50 53 8b ce ff d2 84 c0 75 0c 8b"))
        
        data = data.replace(bytes.fromhex("83 f8 03 0f 85 dd 00 00 00 8b 4d 08 33 c0 8d 55 f8 52 89 45 f8 89 45 fc e8 10 27 f2 ff 8b 5d 1c 8d 43 ff 3d fe 07 00 00 0f 87 90 00 00 00 8b 75 10 8b 0e 8b 56 04 8b 46 08 89 4d ec 8b ce 89 55 f0 89 45 f4 e8 c4 3b 14 00 83 f8 01 74 0b 8b ce e8 48 3b 14 00 84 c0 74 13 b9 ac e0 6a 10 e8 ca 3b 14 00 50 8d 4d ec e8 01 3d 14 00 8b 4d 18 8b 45 0c 53 51 8b 4d 08 8d 55 ec 52 50 51 e8 ab a2 ff ff 8b c8 e8 d4"), bytes.fromhex("83 f8 69 0f 85 dd 00 00 00 8b 4d 08 33 c0 8d 55 f8 52 89 45 f8 89 45 fc e8 10 27 f2 ff 8b 5d 1c 8d 43 ff 3d fe 07 00 00 0f 87 90 00 00 00 8b 75 10 8b 0e 8b 56 04 8b 46 08 89 4d ec 8b ce 89 55 f0 89 45 f4 e8 c4 3b 14 00 83 f8 01 74 0b 8b ce e8 48 3b 14 00 84 c0 74 13 b9 ac e0 6a 10 e8 ca 3b 14 00 50 8d 4d ec e8 01 3d 14 00 8b 4d 18 8b 45 0c 53 51 8b 4d 08 8d 55 ec 52 50 51 e8 ab a2 ff ff 8b c8 e8 d4"))
        # write the data back to the file
        f = open(gamepath + nf + "engine.dll", "wb")
        f.write(data)
        f.close()

    ###/// SERVER.DLL ///###
    if (os.path.isfile(gamepath + nf + "server.dll")):
        print("(P2:MM) Patching server.dll...")
        f = open(gamepath + nf + "server.dll", "rb")
        data = f.read()
        f.close()
        # remove the file
        os.remove(gamepath + nf + "server.dll")
        # replace the data
        # 33 player cap edit
        data = data.replace(b'\x8bM\x08\xc7\x00\x01\x00\x00\x00\xc7\x01\x01\x00\x00\x00\xff\x15', b'\x8bM\x08\xc7\x00\x20\x00\x00\x00\xc7\x01\x20\x00\x00\x00\xff\x15')
        data = data.replace(b'\xf7\xd8\x1b\xc0\xf7\xd8\x83\xc0\x02\x89\x01]', b'\xf7\xd8\x1b\xc0\xf7\xd8\x83\xc0 \x89\x01]')
        data = data.replace(b'\xff\xd0\x85\xc0t\x05\xbe\x03\x00\x00\x00\x8b', b'\xff\xd0\x85\xc0t\x05\xbe\x21\x00\x00\x00\x8b')
        data = data.replace(b'\xff\xd0\x85\xc0\x0f\x85\xaf\x05\x00\x00\xb0\x01_^', b'\xff\xd0\x85\xc0\x0f\x85\xaf\x05\x00\x00\xb0\x20_^')

        # Partner disconnect edit
        data = data.replace(b'disconnect "Partner disconnected"', b'script EntFire("pdcm", "display")')

        # Command patch edit
        data = data.replace(b'restart_level', b'portal2mprslv')
        data = data.replace(b'mp_restart_level', b'portal2mpmprslev')
        data = data.replace(b'mp_earn_taunt', b'portal2mpmper')
        data = data.replace(b'pre_go_to_calibration', b'portal2multiplayrpgtc')
        data = data.replace(b'erase_mp_progress', b'portal2multiemppg')
        data = data.replace(b'mp_mark_all_maps_complete', b'portal2multiplayermpmamcp')
        data = data.replace(b'mp_mark_all_maps_incomplete', b'portal2multiplayermodmpmami')
        data = data.replace(b'pre_go_to_hub', b'portal2mppgth')
        data = data.replace(b'transition_map', b'portal2mptrmap')
        data = data.replace(b'select_map', b'p2mpselmap')
        data = data.replace(b'mp_select_level', b'portal2mpmpsell')
        data = data.replace(b'mp_mark_course_complete', b'portal2multiplayermpmcc')

        # write the data back to the file
        f = open(gamepath + nf + "server.dll", "wb")
        f.write(data)
        f.close()

    ###/// ENGINE.SO ///###
    if (os.path.isfile(gamepath + nf + "engine.so")):
        print("(P2:MM) Patching engine.so...")
        f = open(gamepath + nf + "engine.so", "rb")
        data = f.read()
        f.close()
        # remove the file
        os.remove(gamepath + nf + "engine.so")
        # replace the data
        # commentary fix (i think)
        data = data.replace(bytes.fromhex("84 c0 0f 84 f5 fc ff ff 8b 06 8d 93 ee 96 d5 ff 83 ec 04 e9 6b ff ff ff 83 ec 0c ff b4 24 80 00 00 00 e8 31 76 2a 00 89 c7 89 34 24 e8 47 c1 ff ff 83 c4 10 84 c0 8b 06 0f 84 99 fc ff ff 8b 96 6c 01 00 00 0b 96 70 01 00 00 0f 85 87 fc ff ff 89 f9 84 c9 0f 85 7d fc ff ff 83 ec 08 8b b8 d0 00 00 00 6a 00 ff b4 24 80 00 00 00 e8 b7 74 2a 00 5a ff b4 24 88 00 00 00 50 8d 83 44 a0 d5 ff 50 ff b4 24 8c 00 00 00 56 ff d7 83 c4 20 31 ff e9 ff fe ff ff 8d"), bytes.fromhex("84 d8 0f 84 f5 fc ff ff 8b 06 8d 93 ee 96 d5 ff 83 ec 04 e9 6b ff ff ff 83 ec 0c ff b4 24 80 00 00 00 e8 31 76 2a 00 89 c7 89 34 24 e8 47 c1 ff ff 83 c4 10 84 c0 8b 06 0f 84 99 fc ff ff 8b 96 6c 01 00 00 0b 96 70 01 00 00 0f 85 87 fc ff ff 89 f9 84 c9 0f 85 7d fc ff ff 83 ec 08 8b b8 d0 00 00 00 6a 00 ff b4 24 80 00 00 00 e8 b7 74 2a 00 5a ff b4 24 88 00 00 00 50 8d 83 44 a0 d5 ff 50 ff b4 24 8c 00 00 00 56 ff d7 83 c4 20 31 ff e9 ff fe ff ff 8d"))
        # steam validation removal 
        data = data.replace(bytes.fromhex("83 f8 03 74 6c e8 a7 7d 24 00 83 ec 08 ff 74 24 4c 50 e8 ca 93 24 00 83 c4 10 84 c0 75 20 8b 16 88 44 24 0f 8d 8b 56 94 d5 ff 83 ec 04 51 57 56 ff 92 d0 00 00 00 0f b6 44 24 1f 83 c4 10 83 c4 2c 5b 5e 5f 5d c3 8d 76 00 8b 06 8d 93 26 94 d5 ff"), bytes.fromhex("83 f8 69 74 6c e8 a7 7d 24 00 83 ec 08 ff 74 24 4c 50 e8 ca 93 24 00 83 c4 10 84 c0 75 20 8b 16 88 44 24 0f 8d 8b 56 94 d5 ff 83 ec 04 51 57 56 ff 92 d0 00 00 00 0f b6 44 24 1f 83 c4 10 83 c4 2c 5b 5e 5f 5d c3 8d 76 00 8b 06 8d 93 26 94 d5 ff"))
        # write the data back to the file
        f = open(gamepath + nf + "engine.so", "wb")
        f.write(data)
        f.close()

    ###/// SERVER.SO ///###
    if (os.path.isfile(gamepath + nf + "server.so")):
        print("(P2:MM) Patching server.so...")
        f = open(gamepath + nf + "server.so", "rb")
        data = f.read()
        f.close()
        # remove the file
        os.remove(gamepath + nf + "server.so")
        # replace the data
        # 33 player cap edit
        data = data.replace(b'\x01\x00\x00\x00\x8bD$\x14\xc7\x00\x01', b'\x1f\x00\x00\x00\x8bD$\x14\xc7\x00\x1f')
        data = data.replace(b'\xc0\x0f\xb6\xc0\x83\xc0\x02\x89\x02\x83\xc4', b'\xc0\x0f\xb6\xc0\x83\xc0 \x89\x02\x83\xc4')
        data = data.replace(b'\x0f\xb6\xc0\x83\xc0\x02\x83\xec\x04\x89\xf3', b'\x0f\xb6\xc0\x83\xc0 \x83\xec\x04\x89\xf3')
        data = data.replace(b'K\x8de\xf4\xb8\x01\x00\x00\x00[^', b'K\x8de\xf4\xb8\x1f\x00\x00\x00[^')

        # Partner disconnect edit
        data = data.replace(b'disconnect "Partner disconnected"', b'script EntFire("pdcm", "display")')

        # Command patch edit
        data = data.replace(b'restart_level', b'portal2mprslv')
        data = data.replace(b'mp_restart_level', b'portal2mpmprslev')
        data = data.replace(b'mp_earn_taunt', b'portal2mpmper')
        data = data.replace(b'pre_go_to_calibration', b'portal2multiplayrpgtc')
        data = data.replace(b'erase_mp_progress', b'portal2multiemppg')
        data = data.replace(b'mp_mark_all_maps_complete', b'portal2multiplayermpmamcp')
        data = data.replace(b'mp_mark_all_maps_incomplete', b'portal2multiplayermodmpmami')
        data = data.replace(b'pre_go_to_hub', b'portal2mppgth')
        data = data.replace(b'transition_map', b'portal2mptrmap')
        data = data.replace(b'select_map', b'p2mpselmap')
        data = data.replace(b'mp_select_level', b'portal2mpmpsell')
        data = data.replace(b'mp_mark_course_complete', b'portal2multiplayermpmcc')

        # write the data back to the file
        f = open(gamepath + nf + "server.so", "wb")
        f.write(data)
        f.close()        

    print("")
    print("BINARY PATCHING END====================================================")
    print("")
    # rename the files so the new files are used
    print("(P2:MM) Renaming binaries...")
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
        if (os.path.isfile(gamepath + nf + binary)):
            # add a ".override" to the end of the binary
            os.rename(gamepath + nf + binary, gamepath + nf + binary + ".override") 
            print("(P2:MM) Renamed " + binary + " to " + binary + ".override")
 
def UnRenameBinaries(gamepath, binarys):
    # binarys = [
    #     "bin/linux32/engine.so",
    #     "bin/engine.dll",
    #     "portal2/bin/linux32/server.so",
    #     "portal2/bin/server.dll",
    # ]
    
    print("")
    print("(P2:MM) Un-renaming binaries...")

    # go through the list of binaries
    for binary in binarys:
        # add a ".override" to the end of the binary
        binary = binary + ".override"
        # if the binary exists
        if (os.path.isfile(gamepath + nf + binary)):
            print("(P2:MM) Un-renaming " + binary + " to " + binary[:-9])
            # if a file with the name gamepath + nf + binary[:-9] exists
            if (os.path.isfile(gamepath + nf + binary[:-9])):
                # remove the file
                os.remove(gamepath + nf + binary)
            else:
                # rename the binary back to the original
                os.rename(gamepath + nf + binary, gamepath + nf + binary[:-9])

def FindAvalibleDLC(gamepath):
    shouldbe = 1
    print("")
    print("(P2:MM) Finding Avalible DLC...")
    print("")
    dlcs = []
    # go through each file in the gamepath
    for file in os.listdir(gamepath):
        # find all of them that start with "portal2_dlc"
        if file.startswith("portal2_dlc"):
            # make sure it's a folder
            if os.path.isdir(gamepath + nf + file):
                # if inside the folder there is a file called "32playermod.identifier" delete this folder
                keepgoin = True
                if "32playermod.identifier" in os.listdir(gamepath + nf + file):
                    print("(P2:MM) Found OLD DLC: " + file)
                    # delete the folder even if it's not empty
                    if (iow):
                        command = "rmdir /S /Q \"" + gamepath + nf + file + "\""
                        print("(P2:MM) Command: " + command)
                        os.system(command)
                    else:
                        command = "rm -r \"" + gamepath + nf + file + "\""
                        print("(P2:MM) Command: " + command)
                        # if on linux, use the command line
                        os.system(command)
                    keepgoin = False

                if keepgoin:
                    # get everything after "portal2_dlc"
                    try:
                        dlcnumber = file.split("portal2_dlc")[1]
                    except:
                        print("(P2:MM) Error getting DLC name (probably a slice error moving on)!")
                        # move on to the next file
                        continue
                    
                    # if dlcnumber contains any letters, it's not a number
                    if any(char.isalpha() for char in dlcnumber):
                        print("(P2:MM) DLC " + dlcnumber + " is not a number!")
                    else:
                        dlcs.append(str(dlcnumber))
                        print("(P2:MM) Adding DLC: " + dlcnumber + " to list...")

    # sort each dlc number lower to higher
    dlcs.sort(key=int)

    # final pass make sure there are no gaps or in the list
    for dlc in dlcs:
        # if the dlc is not the right number, remove it
        if int(dlc) != shouldbe:
            print("(P2:MM) DLC " + dlc + " removed from list!")
            dlcs.remove(dlc)
        else:
            print("(P2:MM) DLC " + dlc + " added to list!")
        shouldbe += 1
    
    # find the highest dlc number
    print("")
    print("(P2:MM) Used DLCs:")
    print("")
    highest = 0
    for dlc in dlcs:
        print("(P2:MM) " + dlc)
        # get the highest dlc
        if int(dlc) > highest:
            highest = int(dlc)
    
    # if the highest dlc + 1 does not exist then we found our mount point
    if "portal2_dlc" + str(highest + 1) not in os.listdir(gamepath):
        print("")
        print("(P2:MM) DLC Mount Point Found! " + gamepath + nf + "portal2_dlc" + str(highest + 1))
        # return the mount point
        return "portal2_dlc" + str(highest + 1)

        
                


# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
# █▄▄ █▄█ █░▀█ █▀░ █ █▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░

DefaultConfigFile = [
    "# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀",
    "# █▄▄ █▄█ █░▀█ █▀░ █ █▄█",
    "",
    "cfgvariant = 16 # DO NOT CHANGE THIS NUMBER WILL AUTO-UPDATE",
    "",
    "#// Launcher //#",
    "",
    "#-----------------------------------",
    "UseProton = off",
    "#-----------------------------------",
    "portal2path = undefined",
    "#-----------------------------------",
    "",
    "#// Portal 2 //#",
    "",
    "#-----------------------------------",
    "UsePlugin = false # Set to true if you want to use the plugin",
    "#-----------------------------------",
    "DedicatedServer = false # Set to true if you want to run the server as a dedicated server (INDEV)",
    "#-----------------------------------",
    "RandomTurretModels = false # Set to true if you want to randomize the turret models",
    "#-----------------------------------",
    "RandomPortalSize = false # Set to true if you want to randomize the portal size",
    "#-----------------------------------",
]

def FindConfigPath():
    print("(P2:MM) Finding Config Path...")
    # the config file should be in documents or .config
    if (iow):
        configpath = homefolder + "\\documents\\multiplayermod.conf"
    else:
        configpath = homefolder + "/.config/multiplayermod.conf"

    # if it doesn't exist, create it
    if not os.path.exists(configpath):
        print("(P2:MM) Config file not found, creating...")
        print("")
        # create the config file
        configfile = open(configpath, "w", encoding="utf-8")
        # write the default config file
        for line in DefaultConfigFile:
            configfile.write(line + "\n")
        # close the file
        configfile.close()
    
    # return the config path
    return configpath
        
def FindInConfig(cfg, search):
    # go through each line
    for line in cfg:
        # check if the line (left side of the =) is the one we want
        if line.split("=")[0].strip() == search:
            print("(P2:MM) Found " + search + " in config!")
            # return the right side of the line
            return line.split("=")[1].strip()
    # if we didn't find it, return undefined
    print("(P2:MM) " + search + " not found in config!")

def EditConfig(filepath, search, newvalue):
    # open the file
    cfg = open(filepath, "r", encoding="utf-8")
    # read the file
    cfgdata = cfg.readlines()
    # close the file
    cfg.close()
    # delete the file
    os.remove(filepath)
    # open the file
    cfg = open(filepath, "w", encoding="utf-8")

    
    # go through each line by index so we can see if there is a match
    for i in range(len(cfgdata)):
        line = cfgdata[i]
        # remove everything after the first #
        line = line.split("#")[0]
        # remove the newline
        line = line.replace("\n", "")
        
        # if the line stripped is not empty and has a =, continue
        if (line != "" and "=" in line):
            # get everything to the left of the =
            leftline = line.split("=")[0]
            # get everything to the right of the =
            rightline = line.split("=")[1]
            # remove every space and tab from the left side
            leftline = leftline.replace(" ", "")
            leftline = leftline.replace("\t", "")
            # remove every tab from the right side
            rightline = rightline.replace("\t", "")
            # strip left and right
            leftline = leftline.strip()
            rightline = rightline.strip()
            # if the left side is the search, replace the right side with the new value
            if (leftline == search):
                print("(P2:MM) Replacing " + rightline + " with " + newvalue + " in config...")
                cfgdata[i] = search + " = " + newvalue + "\n"

    # write the file
    for line in cfgdata:
        cfg.write(line)

    # close the file
    cfg.close()

def ImportConfig():
    print("(P2:MM) Importing Config...")

    # get the config file and open it
    configpath = FindConfigPath()
    configfile = open(configpath, "r", encoding="utf-8")
    config = configfile.readlines()
    configfile.close()


    # process the config file into useable data
    print("(P2:MM) Processing Config...")
    print("")
    print("Config Data========================")
    processedconfig = []
    for line in config:
        # remove everything after the first #
        line = line.split("#")[0]
        # remove the newline
        line = line.replace("\n", "")
        
        # if the line stripped is not empty and has a =, continue
        if (line != "" and "=" in line):
            # get everything to the left of the =
            leftline = line.split("=")[0]
            # get everything to the right of the =
            rightline = line.split("=")[1]
            # remove every space and tab from the left side
            leftline = leftline.replace(" ", "")
            leftline = leftline.replace("\t", "")
            # remove every tab from the right side
            rightline = rightline.replace("\t", "")
            # strip left and right
            leftline = leftline.strip()
            rightline = rightline.strip()
            # recombine the two sides with a =
            line = leftline + "=" + rightline

            # if the line is not empty, add it to the processed config
            if (line != ""):
                processedconfig.append(line)
                print("Line:" + line)

    print("Config Data End====================")
    print("")
    print("(P2:MM) Config Imported!")
    return processedconfig
    


# █ █▄░█ █ ▀█▀
# █ █░▀█ █ ░█░

def Init():
    print("(P2:MM) Initializing...")
    print("")

#//# import the config #//#
    configdata = ImportConfig()
    configpath = FindConfigPath()
    print("")

#//# get the portal 2 path #//#
    # setup a name for the default dlc2 (so we can make sure we get the right path later)

    print("(P2:MM) Checking for Portal 2 Path...")
    portal2path = FindInConfig(configdata, "portal2path")
    
    # if we don't have a path, find it
    if (portal2path == "undefined") or ((os.path.exists(portal2path)) != True) or (os.path.exists(portal2path + nf + "portal2_dlc2") != True):
        print("(P2:MM) Portal 2 Path not predefined!")
        # loop until the path is found or the user aborts
        hasfoundcorrectpath = False
        while hasfoundcorrectpath == False:
            print("")
            portal2path = input(
                "Enter the path to your Portal 2 installation or type 'exit' to abort: ")

            # if the user types "exit" exit the app
            if (portal2path == "exit"):
                print("(P2:MM) Exiting")
                exit()

            # check if the given path is valid
            if (os.path.exists(portal2path) and os.path.exists(portal2path + nf + "portal2_dlc2")):
                # if it does stop the loop
                print("(P2:MM) Portal 2 Path found!")
                hasfoundcorrectpath = True
            else:
                print("(P2:MM) Invalid Path!")
                print("(P2:MM) Please try again!")
                hasfoundcorrectpath = False

        # write the path to the config
        print("(P2:MM) Writing Portal 2 Path to Config...")
        EditConfig(configpath, "portal2path", portal2path)

#//# mount the multiplayer mod #//#
    if (WillMount):
        MountMod(portal2path)
        # patch the binaries
        PatchBinaries(portal2path)

        print("(P2:MM) Running Game...")
        try:
            if (iow):
                subprocess.run([portal2path+nf+"portal2.exe", "-novid", "-allowspectators", "-nosixense", "+map mp_coop_lobby_3"])
                print("Game launch successful!")
            else:
                from subprocess import Popen
                subprocess.Popen(["steam", "-applaunch", "620", "-novid", "-allowspectators", "-nosixense", "+map", "mp_coop_lobby_3"])
                print("Game launch successful!")
        except:
            print("Failed to launch Portal 2!")
    else:
        # this will delete any in use dlcs
        print("(P2:MM) Deleting In Use DLCs...")
        print("")
        FindAvalibleDLC(portal2path)
        # unpatch the binaries
        UnpatchBinaries(portal2path)
        
# RUN INIT
Init()