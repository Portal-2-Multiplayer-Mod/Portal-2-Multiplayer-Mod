# # # # # # # # # # # # # # # # # #
#
# Purpose: Launch Portal 2: MM
#
# Methods: Rename existing server
# and engine binaries, and create
# new DLC mod directories to allow
# our content to override defaults
#
# # # # # # # # # # # # # # # # # #

# GLOBAL DEFINITIONS
import os
import shutil
import subprocess
import mmap
import time

# Is on Windows (By default, we are on Linux)
iow = False

if os.name == 'nt':
    print("(System should be running Windows)")
    iow = True
else:
    print("(System should be running Linux)")

owd = os.getcwd()

# Get current directory if on Windows
if (iow):
    os.chdir(owd.replace("\\MultiplayerModFiles", ""))
# Get current directory if on Linux
else:
    os.chdir(owd.replace("/MultiplayerModFiles", ""))
owd = os.getcwd()
print(os.getcwd())




# CONFIG FILE

# default config file
configdefaults = [
    "# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀",
    "# █▄▄ █▄█ █░▀█ █▀░ █ █▄█",
    "",
    "  cfgvariant = 4 # DO NOT CHANGE",
    "",
    "# DISCLAIMER : I recommend you edit this through the gui as this",
    "#              config file has some unstable / exparamental that",
    "#              will in all most likely break the game if edited!",
    "",
    "#-----------------------------------",
    "DevMode = false # Set to true if your a developer",
    "#-----------------------------------",
    "UsePlugin = false # Set to true if you want to use the plugin (LINUX ONLY)",
    "#-----------------------------------",
    "DedicatedServer = false # Set to true if you want to run the server as a dedicated server (INDEV)",
    "#-----------------------------------",
    "RandomTurretModels = false # Set to true if you want to randomize the turret models (INDEV)",
    "#-----------------------------------",
    "TickSpeed = 0.1 # Set to the tick speed of the server (DO NOT TOUCH UNLESS YOU KNOW WHAT YOUR DOING)(UNSTABLE - ONLY DO 0.02 TO 0.5) (lower numbers can cause lag on slow computers/connections)",
    "#-----------------------------------",
]

configdefaults = configdefaults

if (iow):
    configpath = "MultiplayerModFiles\\mpmod.cfg"
else:
    configpath = "MultiplayerModFiles/mpmod.cfg"

# create a config file if it doesn't exist

if not os.path.exists(configpath):
    # create a config file
    f = open(configpath, "w", encoding="utf-8")
    # write the default values
    for line in configdefaults:
        f.write(line + "\n")
    f.close()



# CONFIG FILE READ

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
# DISCLAIMER : make sure to put all of your config values                     #
# above all the other values that are set using that same name in mapspawn.nut#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#

# open file for reading
f = open(configpath, "r")
# read the file
lines = f.readlines()
# close the file
f.close()

# check if there is an update to the config file
for line in lines:
    if (line.find("cfgvariant") != -1):
        curconfigver = line.split(" = ")[1]
        # replace everything that isnt a number with a nothing
        curconfigver = curconfigver.replace("[^0-9]", "")
        # convert to int
        curconfigver = curconfigver[0 : 1]
        curconfigver = int(curconfigver)

        print("Current Config Version: " + str(curconfigver))

for line in configdefaults:
    if (line.find("cfgvariant") != -1):
        newconfigver = line.split(" = ")[1]
        # replace everything that isnt a number with a nothing
        newconfigver = newconfigver.replace("[^0-9]", "")
        # convert to int
        newconfigver = newconfigver[0 : 1]
        newconfigver = int(newconfigver)

        print("New Config Version: " + str(newconfigver))

# update config file if needed
# read old config data
f = open(configpath, "r", encoding="utf-8")
data = f.readlines()
f.close()
os.remove(configpath)

f = open(configpath, "w", encoding="utf-8")
for mainline in configdefaults:
    line = mainline.strip()
    line = line.replace(" ", "")
    if (line != ""):
        if (line.find("#") != -1):
            line = line[ : line.find("#")]
            if (line != ""):
                outputline = line
            else:
                # f.write(mainline + "\n")
                outputline = "DO NOT WRITE"
        else:
            outputline = line
    else:
        # skip blank lines
        # f.write(mainline + "\n")
        outputline = "DO NOT WRITE"

    for maindefline in data:
        line22 = maindefline.strip()
        line22 = line22.replace(" ", "")
        if (line22 != ""):
            if (line22.find("#") != -1):
                line22 = line22[ : line22.find("#")]
                if (line22 != ""):
                    defoutputline = line22
                else:
                    defoutputline = "DO NOT WRITE"
            else:
                defoutputline = line22
        else:
            defoutputline = "DO NOT WRITE"

        if (defoutputline != "DO NOT WRITE") & (outputline != "DO NOT WRITE"):
            if (outputline.find("cfgvariant") == -1) & (defoutputline.find("cfgvariant") == -1):
                print("defoutputline: " + defoutputline[ : defoutputline.find("=")] + " outputline: " + outputline[ : outputline.find("=")])
                if (outputline != defoutputline):
                    if (outputline[ : outputline.find("=")] == defoutputline[ : defoutputline.find("=")]):
                        if (outputline[outputline.find("=") : ] != defoutputline[defoutputline.find("=") : ]):
                            if (line != ""):
                                mainline = mainline.replace(outputline[outputline.find("=")+1 : ], defoutputline[defoutputline.find("=")+1 : ])
                                print("Replaced: " + outputline + " with " + defoutputline + " ENDED WITH :" + mainline + " FIND AND REPLACE" + outputline[outputline.find("=")+1 : ] + defoutputline[defoutputline.find("=")+1 : ])


    f.write(mainline + "\n")
    print(mainline)
f.close()

outputconfig = []
editedconfigdata = []

# get raw config data from file
for line in lines:
    line = line.strip()
    line = line.replace(" ", "")
    if (line != ""):
        if (line.find("#") != -1):
            line = line[ : line.find("#")]
            if (line != ""):
                outputconfig.append(line)
        else:
            outputconfig.append(line)

# edit config data for vscript
for line in outputconfig:
    line = line.replace("=", " <- ")
    if (line.find("cfgvariant") != -1):
        print("Config Version: " + line.split(" <- ")[1])
    else:
        editedconfigdata.append(line)

# LAUNCHER
def Launch():

    # Is on Proton (Linux running Windows applications)
    IsOnProton = False

    # Attempt to load psutil if on Linux
    if (iow):
        print("Skipping psutil because we are on Windows")
    else:
        import psutil

    NumList = []
    lastnumber = 0

    if (iow):
        print("Skipped pthe sutil function")
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
                    # Set the new temp dlc name
                    if (iow):
                        dlcname = "\portal2_dlc" + str(number + 1)
                    else:
                        dlcname = "/portal2_dlc" + str(number + 1)

    # Remove multiplayer mod files so we can repatch
    try:
        if(iow):
            try:
                os.remove(owd + "\server.dll")
                print("Did not fail to remove server.dll!")
            except:
                pass
            try:
                os.remove(owd + "\engine.dll")
                print("Did not fail to remove engine.dll!")
            except:
                pass
        else:
            try:
                os.remove(owd + "/engine.so")
            except:
                pass
            try:
                os.remove(owd + "/engine.dll")
            except:
                pass
            try:
                os.remove(owd + "/server.dll")
            except:
                pass
            try:
                os.remove(owd + "/server.so")
            except:
                pass
        print("Removed modded files (Game likely crashed last session!)")
    except:
        # We should never encounter this exception...
        print("Failed to remove modded files")

    # Undo the patch dll renames so we can patch the server.dll again
    # Rename main server.dll back to server.dll
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
            os.rename(owd + "/bin/disabledengine.dll", owd + "/bin/engine.dll")
            print("Enabled engine.dll")
        except:
            pass
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


    # # # # # # # # # # # # # # # # #
    #       START OF PATCHING       #
    # # # # # # # # # # # # # # # # #

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
        data = data.replace(b'\x8bM\x08\xc7\x00\x01\x00\x00\x00\xc7\x01\x01\x00\x00\x00\xff\x15', b'\x8bM\x08\xc7\x00\x20\x00\x00\x00\xc7\x01\x20\x00\x00\x00\xff\x15')
        data = data.replace(b'\xf7\xd8\x1b\xc0\xf7\xd8\x83\xc0\x02\x89\x01]', b'\xf7\xd8\x1b\xc0\xf7\xd8\x83\xc0 \x89\x01]')
        data = data.replace(b'\xff\xd0\x85\xc0t\x05\xbe\x03\x00\x00\x00\x8b', b'\xff\xd0\x85\xc0t\x05\xbe\x21\x00\x00\x00\x8b')
        data = data.replace(b'\xff\xd0\x85\xc0\x0f\x85\xaf\x05\x00\x00\xb0\x01_^', b'\xff\xd0\x85\xc0\x0f\x85\xaf\x05\x00\x00\xb0\x20_^')

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

    # # # # # # # # # # # # # # # # #
    #        END OF PATCHING        #
    # # # # # # # # # # # # # # # # #


    # Copy the multiplayermod files into the new dlc using the dlc name
    if (iow):
        shutil.copytree(owd + "\MultiplayerModFiles\MainFiles\install_dlc", owd + dlcname)
    else:
        shutil.copytree(owd + "/MultiplayerModFiles/MainFiles/install_dlc", owd + dlcname)
    print("Copied \MultiplayerModFiles to " + dlcname)

    # Edit mapspawn file in the new dlc
    if (iow):
        # If running windows
        f = open(owd + dlcname + "\\scripts\\vscripts\\mapspawn.nut", 'r', encoding="utf-8")
        data = f.readlines()
        f.close()
        os.remove(owd + dlcname + "\\scripts\\vscripts\\mapspawn.nut")

        # Edit mapspawn file
        f2 = open(owd + dlcname + "\\scripts\\vscripts\\mapspawn.nut", 'w', encoding="utf-8")

        # write config data
        for origline in data:
            for line in editedconfigdata:
                if (line.strip()[ : line.strip().find("<-")] == origline.strip()[ : origline.strip().find("<-")]):
                    outputline = line + origline[origline.find("<-") : ].replace("<- ", "<-").replace(" <-", "<-").replace("<- ", "<-")[origline[origline.find("<-") : ].replace("<- ", "<-").replace(" <-", "<-").replace("<- ", "<-").find(" ") : ]
                    break
                else:
                    outputline = origline
            f2.write(outputline)
        # Remove old mapspawn.nut file
        f2.close()
    else:
        # If running Linux
        f = open(owd + dlcname + "/scripts/vscripts/mapspawn.nut", 'r')
        data = f.readlines()
        f.close()
        os.remove(owd + dlcname + "/scripts/vscripts/mapspawn.nut")

        # Edit mapspawn file
        f2 = open(owd + dlcname + "/scripts/vscripts/mapspawn.nut", 'w')

        ReplacedLines = ["Raw Nothing Data",]

        # write config data
        for origline in data:
            for line in editedconfigdata:
                if (line.strip()[ : line.strip().find("<-")] == origline.strip()[ : origline.strip().find("<-")]):
                    tryOutputline = line + origline[origline.find("<-") : ].replace("<- ", "<-").replace(" <-", "<-").replace("<- ", "<-")[origline[origline.find("<-") : ].replace("<- ", "<-").replace(" <-", "<-").replace("<- ", "<-").find(" ") : ]
                    for line2 in ReplacedLines:
                        if (line2.strip() == line.strip()):
                            tryOutputline = "DO NOT WRITE THIS LINE"
                    if (tryOutputline != "DO NOT WRITE THIS LINE"):
                        ReplacedLines.append(line)
                        outputline = tryOutputline
                    else:
                        outputline = origline
                    break
                else:
                    outputline = origline
            f2.write(outputline)
        # Remove old mapspawn.nut file
        f2.close()

    # Rename server.dll to disabledserver.dll so our newly patched server.dll runs
    if (iow):
        try:
            os.rename(owd + "\\portal2\\bin\\server.dll", owd + "\\portal2\\bin\\disabledserver.dll")
        except:
            print("Failed to disable server.dll!")
        try:
            os.rename(owd + "\\bin\\engine.dll", owd + "\\bin\\disabledengine.dll")
        except:
            print("Failed to disable engine.dll!")
    else:
        try:
            os.rename(owd + "/bin/linux32/engine.so", owd + "/bin/linux32/disabledengine.so")
        except:
            print("Failed to rename engine.so trying to rename engine.dll")
        try:
            os.rename(owd + "/bin/engine.dll", owd + "/bin/disabledengine.dll")
        except:
            print("Failed to rename engine.dll")
        try:
            os.rename(owd + "/portal2/bin/server.dll", owd + "/portal2/bin/disabledserver.dll")
        except:
            print("Failed to rename server.dll")
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
            print("Running game")
    except:
        print("Failed to launch Portal 2")


    # Remove game files after game exits
    def RemoveMultiplayerFiles():
        # Remove multiplayer mod files
        try:
            if(iow):
                try:
                    os.remove(owd + "\server.dll")
                except:
                    pass
                try:
                    os.remove(owd + "\engine.dll")
                except:
                    pass
            else:
                try:
                    os.remove(owd + "/engine.so")
                except:
                    pass
                try:
                    os.remove(owd + "/engine.dll")
                except:
                    pass
                try:
                    os.remove(owd + "/server.dll")
                except:
                    pass
                try:
                    os.remove(owd + "/server.so")
                except:
                    pass
            print("Removed modded files")
        except:
            print("Failed to remove modded files (somehow?????)")

        try:
            shutil.rmtree(owd + dlcname)
            print("Removed " + dlcname)
        except:
            print("Failed to remove Multiplayer Mod DLCs")

        # Rename main files back to original
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
                    os.rename(owd + "/bin/disabledengine.dll", owd + "/bin/engine.dll")
                    print("Enabled engine.dll")
                except:
                    pass
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









# GUI
# make a gui with a start button
import tkinter as tk
from requests import get

ip = get('https://api.ipify.org').text

# make a window
window = tk.Tk()
window.title("Portal 2 Multiplayer Mod Launcher")
window.geometry("400x200")

# put a button on the window
button = tk.Button(window, text="Start", command=Launch)
button.pack()

# make selectable text that says "Select a mod"
text = tk.Text(window, height=30, width=60)
text.insert(tk.END, "Generated HyperLink:" + "\n" + "steam://run/620//+connect%20" + ip)
text.pack()

# show the window
window.mainloop()
