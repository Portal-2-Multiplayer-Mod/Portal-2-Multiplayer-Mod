import os
import shutil
import subprocess
import mmap
import time

# Is on Windows
iow = False

# Is on proton
IsOnProton = False

if os.name == 'nt':
    print("(Probably running Windows)")
    iow = True
else:
    print("(Probably running Linux)")

if (iow):
    print("skipping psutil")
else:
    import psutil

NumList = []
lastnumber = 0
owd = os.getcwd()

if (iow):
    print("Skipped psutil function")
else:
    def checkIfProcessRunning(processName):
    # Iterate over the all the running process
        for proc in psutil.process_iter():
            try:
                # Check if process name contains the given name string
                if processName.lower() in proc.name().lower():
                    return True
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass
        return False

# Get current directory
if (iow):
    os.chdir(owd.replace("\\MultiplayerModFiles", ""))
else:
    os.chdir(owd.replace("/MultiplayerModFiles", ""))
owd = os.getcwd()
print(os.getcwd())

# Get a number list of all the dlcs
for filename in os.listdir():
    if filename[0 : 11] == "portal2_dlc":
        if filename[11 : ].isnumeric():
            NumList.append(int(filename[11 : ]))

# Sort the dlcs
Number = len(NumList)
for i in range (Number):
    for j in range(i + 1, Number):
        if(NumList[i] > NumList[j]):
            temp = NumList[i]
            NumList[i] = NumList[j]
            NumList[j] = temp

# Find the highest numbered used dlc
for number in NumList:
            if number-1 == lastnumber:
                lastnumber = number
                # set the new temp dlc name
                if (iow):
                    dlcname = "\portal2_dlc" + str(number + 1)
                else:
                    dlcname = "/portal2_dlc" + str(number + 1)



# Undo the patch dll renames so we can patch the server.dll again
try:
    if (iow):
        try:
            os.rename(owd + "\portal2\\bin\disabledserver.dll", owd + "\portal2\\bin\server.dll")
            print("Found disabledserver.so just renamed to server.so (Python probably crashed last session)")
        except:
            pass
        try:
            os.rename(owd + "\\bin\disabledengine.dll", owd + "\\bin\engine.dll")
            print("Found engine.dll just renamed to engine.dll (Python probably crashed last session)")
        except:
            pass
    else:
        try:
            os.rename(owd + "/bin/linux32/disabledengine.so", owd + "/bin/linux32/engine.so")
            print("Enabled engine.so")
        except:
            pass
        try:
            os.rename(owd + "/bin/disabledengine.dll", owd + "/bin/engine.dll")
            print("Enabled engine.so")
        except:
            pass
        try:
            os.rename(owd + "/portal2/bin/disabledserver.dll", owd + "/portal2/bin/server.dll")
            print("Enabled server.dll")
        except:
            pass
        try:
            os.rename(owd + "/portal2/bin/linux32/disabledserver.so", owd + "/portal2/bin/linux32/server.so")
            print("Enabled server.so")
        except:
            pass
except:
    print("Error trys gave exeption (Odd)")



##################################
#        START OF PATCHING       #
##################################

# server.dll patch
try:
    # Open server.dll into binary
    if (iow):
        f = open(owd + "\portal2\\bin\server.dll", 'rb')
    else:
        f = open(owd + "/portal2/bin/server.dll", 'rb')
    data = f.read()
    f.close()

    # 33 player cap edit
    data = data.replace(b'\x8bM\x08\xc7\x00\x01\x00\x00\x00\xc7\x01\x01\x00\x00\x00\xff\x15(2X\x10', b'\x8bM\x08\xc7\x00\x20\x00\x00\x00\xc7\x01\x20\x00\x00\x00\xff\x15(2X\x10')
    data = data.replace(b'\xf7\xd8\x1b\xc0\xf7\xd8\x83\xc0\x02\x89\x01]', b'\xf7\xd8\x1b\xc0\xf7\xd8\x83\xc0 \x89\x01]')
    data = data.replace(b'\xff\xd0\x85\xc0t\x05\xbe\x03\x00\x00\x00\x8b}\x08V', b'\xff\xd0\x85\xc0t\x05\xbe!\x00\x00\x00\x8b}\x08V')
    data = data.replace(b'\xff\xd0\x85\xc0\x0f\x85\xaf\x05\x00\x00\xb0\x01_^', b'\xff\xd0\x85\xc0\x0f\x85\xaf\x05\x00\x00\xb0\x20_^')

    # Partner disconnect edit
    data = data.replace(b'disconnect "Partner disconnected"', b'script_execute playerdisconnected')

    # Command patch edit
    data = data.replace(b'rstart_level', b'portal2mprslv')
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

    # Write changes into a new toplevel server.dll
    f2 = open("server.dll", 'wb')
    f2.write(data)
    f2.close()
except:
    print("Failed to patch server.dll")

# server.so patch
if (iow):
    print("Running Windows skipping server.so patch")
else:
    try:
        # Open server.so into binary
        f = open(owd + "/portal2/bin/linux32/server.so", 'rb')
        data = f.read()
        f.close()

        # 33 player cap edit
        data = data.replace(b'\x01\x00\x00\x00\x8bD$\x14\xc7\x00\x01', b'\x1f\x00\x00\x00\x8bD$\x14\xc7\x00\x1f')
        data = data.replace(b'\xc0\x0f\xb6\xc0\x83\xc0\x02\x89\x02\x83\xc4', b'\xc0\x0f\xb6\xc0\x83\xc0 \x89\x02\x83\xc4')
        data = data.replace(b'\x0f\xb6\xc0\x83\xc0\x02\x83\xec\x04\x89\xf3', b'\x0f\xb6\xc0\x83\xc0 \x83\xec\x04\x89\xf3')
        data = data.replace(b'K\x8de\xf4\xb8\x01\x00\x00\x00[^', b'K\x8de\xf4\xb8\x1f\x00\x00\x00[^')

        # Partner disconnect edit
        data = data.replace(b'disconnect "Partner disconnected"', b'script_execute playerdisconnected')

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

        # Write changes into a new toplevel server.so
        f2 = open("server.so", 'wb')
        f2.write(data)
        f2.close()
    except:
        print("Failed to patch server.so")

# engine.dll patch
if (iow):
    # Try:
        # Open engine.dll into binary
    if (iow):
        f = open(owd + "\\bin\engine.dll", 'rb')
    data = f.read()
    f.close()

    # Remove Steam validation
    data = data.replace(b't}\x8b\x17\x8b\x82\xcc\x00\x00', b'\xeb}\x8b\x17\x8b\x82\xcc\x00\x00')
    data = data.replace(bytes.fromhex("84 C0 74 1f 8b 16 8b 82 cc 00 00 00 68 00 8f 37 10 53 56 ff d0 83 c4 0c 5b 5f 33 c0 5e 8b e5 5d c2 2c 00 8b 16 8b 42 6c 8b ce ff d0 84 c0 75 78 8b 16 8b 42 70 8b ce ff d0 84 c0 75 6b 8b 45 14 8b 16 8b 92 d0 00 00 00 50 53 8b ce ff d2 84 c0 75 0c 8b 06 68 e8 8e 37 10 e9 cf fe ff ff 8b 45 1c 8b 16 8b 92 f4 00 00 00 57 50 53 8b"), bytes.fromhex("a8 00 74 1f 8b 16 8b 82 cc 00 00 00 68 00 8f 37 10 53 56 ff d0 83 c4 0c 5b 5f 33 c0 5e 8b e5 5d c2 2c 00 8b 16 8b 42 6c 8b ce ff d0 84 c0 75 78 8b 16 8b 42 70 8b ce ff d0 84 c0 75 6b 8b 45 14 8b 16 8b 92 d0 00 00 00 50 53 8b ce ff d2 84 c0 75 0c 8b 06 68 e8 8e 37 10 e9 cf fe ff ff 8b 45 1c 8b 16 8b 92 f4 00 00 00 57 50 53 8b"))

    # Write changes into a new toplevel engine.dll
    f2 = open("engine.dll", 'wb')
    f2.write(data)
    f2.close()
    print("Patched engine.dll")
    # Except:
    #     print("Failed to patch engine.dll")
else:
    try:
        f = open(owd + "/bin/linux32/engine.so", 'rb')
        data = f.read()
        f.close()

        # Remove valve_reject_hidden_game commentary check
        data = data.replace(bytes.fromhex("84 C0 0f 84 f5 fc ff ff 8b 06 8d 93 ae 66 d5 ff 83 ec 04 e9 6b ff ff ff 83 ec 0c ff b4 24 80 00 00 00 e8 11 5e 2a 00 89 c7 89 34 24 e8 47 c1 ff ff 83 c4 10 84 c0 8b 06 0f 84 99 fc ff ff 8b 96 6c 01 00 00 0b 96 70 01 00 00 0f 85 87 fc ff ff 89 f9 84 c9 0f 85 7d fc ff ff 83 ec 08 8b b8 d0 00 00 00 6a 00 ff b4 24 80 00 00 00 e8 97 5c 2a 00 5a ff b4 24"), bytes.fromhex("a8 00 0f 84 f5 fc ff ff 8b 06 8d 93 ae 66 d5 ff 83 ec 04 e9 6b ff ff ff 83 ec 0c ff b4 24 80 00 00 00 e8 11 5e 2a 00 89 c7 89 34 24 e8 47 c1 ff ff 83 c4 10 84 c0 8b 06 0f 84 99 fc ff ff 8b 96 6c 01 00 00 0b 96 70 01 00 00 0f 85 87 fc ff ff 89 f9 84 c9 0f 85 7d fc ff ff 83 ec 08 8b b8 d0 00 00 00 6a 00 ff b4 24 80 00 00 00 e8 97 5c 2a 00 5a ff b4 24"))

        # Write changes into a new toplevel engine.dll
        f2 = open("engine.so", 'wb')
        f2.write(data)
        f2.close()
        print("Patched engine.so")
    except:
        try:
            IsOnProton = True
            print("Failed to open engine.so trying to patch server.dll")
            # Open engine.dll into binary
            f = open(owd + "/bin/engine.dll", 'rb')
            data = f.read()
            f.close()

            # Remove Steam validation
            data = data.replace(b't}\x8b\x17\x8b\x82\xcc\x00\x00', b'\xeb}\x8b\x17\x8b\x82\xcc\x00\x00')
            data = data.replace(bytes.fromhex("84 C0 74 1f 8b 16 8b 82 cc 00 00 00 68 00 8f 37 10 53 56 ff d0 83 c4 0c 5b 5f 33 c0 5e 8b e5 5d c2 2c 00 8b 16 8b 42 6c 8b ce ff d0 84 c0 75 78 8b 16 8b 42 70 8b ce ff d0 84 c0 75 6b 8b 45 14 8b 16 8b 92 d0 00 00 00 50 53 8b ce ff d2 84 c0 75 0c 8b 06 68 e8 8e 37 10 e9 cf fe ff ff 8b 45 1c 8b 16 8b 92 f4 00 00 00 57 50 53 8b"), bytes.fromhex("a8 00 74 1f 8b 16 8b 82 cc 00 00 00 68 00 8f 37 10 53 56 ff d0 83 c4 0c 5b 5f 33 c0 5e 8b e5 5d c2 2c 00 8b 16 8b 42 6c 8b ce ff d0 84 c0 75 78 8b 16 8b 42 70 8b ce ff d0 84 c0 75 6b 8b 45 14 8b 16 8b 92 d0 00 00 00 50 53 8b ce ff d2 84 c0 75 0c 8b 06 68 e8 8e 37 10 e9 cf fe ff ff 8b 45 1c 8b 16 8b 92 f4 00 00 00 57 50 53 8b"))

            # Write changes into a new toplevel engine.dll
            f2 = open("engine.dll", 'wb')
            f2.write(data)
            f2.close()
            print("Patched engine.dll")
        except:
            print("Failed to patch engine.dll")
            IsOnProton = False

##################################
#         END OF PATCHING        #
##################################


# Copy the multiplayermod files into the new dlc using the dlc name
if (iow):
    shutil.copytree(owd + "\MultiplayerModFiles\MainFiles\install_dlc", owd + dlcname)
else:
    shutil.copytree(owd + "/MultiplayerModFiles/MainFiles/install_dlc", owd + dlcname)
print("Copied \MultiplayerModFiles to " + dlcname)

# Edit mapspawn file in the new dlc
if (iow):
    print("Skipped map spawn editing")
#     # If on Windows
#     f = open(owd + dlcname + "\scripts\\vscripts\mapspawn.nut", 'r')
#     data = f.read()
#     f.close()

#     # Edit mapspawn.nut file
#         # Change UsePlugin <- true to false if on Windows
#     data = data.replace("UsePlugin <- true", "UsePlugin <- false")

#     # Remove old mapspawn.nut file
#     os.remove(owd + dlcname + "\scripts\\vscripts\mapspawn.nut")
#     f2 = open(owd + dlcname + "\scripts\\vscripts\mapspawn.nut", 'w')
#     f2.write(data)
#     f2.close()
else:
    # If running Linux
    f = open(owd + dlcname + "/scripts/vscripts/mapspawn.nut", 'r')
    data = f.read()
    f.close()

    # Edit mapspawn file
        # Change UsePlugin <- false to true if running Linux
    if (IsOnProton == False):
        data = data.replace("UsePlugin <- false", "UsePlugin <- true")

    # Remove old mapspawn.nut file
    os.remove(owd + dlcname + "/scripts/vscripts/mapspawn.nut")
    f2 = open(owd + dlcname + "/scripts/vscripts/mapspawn.nut", 'w')
    f2.write(data)
    f2.close()

# Rename server.dll to disabledserver.dll so our newly patched server.dll runs
if (iow):
    os.rename(owd + "\portal2\\bin\server.dll", owd + "\portal2\\bin\disabledserver.dll")
    os.rename(owd + "\\bin\engine.dll", owd + "\\bin\disabledengine.dll")
else:
    try:
        os.rename(owd + "/bin/linux32/engine.so", owd + "\\bin\linux32\disabledengine.so")
    except:
        print("Failed to rename engine.so trying to rename engine.dll")
        os.rename(owd + "/bin/engine.dll", owd + "/bin/disabledengine.dll")
    os.rename(owd + "/portal2/bin/server.dll", owd + "/portal2/bin/disabledserver.dll")
    try:
        os.rename(owd + "/portal2/bin/linux32/server.so", owd + "/portal2/bin/linux32/disabledserver.so")
    except:
        print("Failed to rename server.so")



# Start Portal 2 with launch options
print("=======Game Launch=======")
try:
    if (iow):
        subprocess.run(["portal2.exe", "-novid", "-allowspectators", "-nosixense", "+map mp_coop_lobby_3"])
    else:
        os.system("steam -applaunch 620 -novid -allowspectators -nosixense +map mp_coop_lobby_3")
        print("Ran game")
except:
    print("Failed to launch Portal 2")


# Remove game files after game exits
def RemoveMultiplayerFiles():
    # Remove multiplayer mod files
    try:
        if(iow):
            os.remove(owd + "\server.dll")
            os.remove(owd + "\engine.dll")
        else:
            os.remove(owd + "/engine.so")
            os.remove(owd + "/server.dll")
            os.remove(owd + "/server.so")
        print("Removed modded server.so/server.dll")
    except:
        print("Failed to remove modded server.dll")

    try:
        shutil.rmtree(owd + dlcname)
        print("Removed " + dlcname)
    except:
        print("Failed to remove Multiplayer Mod DLCs")

    # Rename main server.dll back to server.dll
    try:
        if (iow):
            try:
                os.rename(owd + "\portal2\\bin\disabledserver.dll", owd + "\portal2\\bin\server.dll")
                print("Enabled disabledserver.dll")
            except:
                pass
            try:
                os.rename(owd + "\\bin\disabledengine.dll", owd + "\\bin\engine.dll")
                print("Enabled engine.dll")
            except:
                pass
        else:
            try:
                os.rename(owd + "/bin/linux32/disabledengine.so", owd + "/bin/linux32/engine.so")
                print("Enabled engine.so")
            except:
                pass
            try:
                os.rename(owd + "/bin/disabledengine.dll", owd + "/bin/engine.dll")
                print("Enabled engine.so")
            except:
                pass
            try:
                os.rename(owd + "/portal2/bin/disabledserver.dll", owd + "/portal2/bin/server.dll")
                print("Enabled server.dll")
            except:
                pass
            try:
                os.rename(owd + "/portal2/bin/linux32/disabledserver.so", owd + "/portal2/bin/linux32/server.so")
                print("Enabled server.so")
            except:
                pass
    except:
        print("Failed to unrename nessasary files (Somehow???)")



# Wait for game to close
print("=========================================================================")
print("WARNING: DO NOT CLOSE THIS PYTHON WINDOW!!! WAITING FOR PORTAL 2 TO CLOSE")
print("=========================================================================")
if (iow):
    # Wait for portal2.exe to close
    RemoveMultiplayerFiles()
else:
    time.sleep(2)
    if (IsOnProton==True):
        time.sleep(12)
    while True:
        # Check if any Portal 2 process is running
        if checkIfProcessRunning('ortal'):
            pass
        else:
            print('Portal 2 not found closing')
            print("=======Game Closed=======")
            RemoveMultiplayerFiles()
            break
        time.sleep(1)


print("")
print("=========================")
print("     Exiting Program...")
print("=========================")