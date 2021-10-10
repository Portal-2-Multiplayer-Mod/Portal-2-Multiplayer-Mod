import os
import shutil
import subprocess
import mmap
import time
import psutil

#Is On Windows
iow = False

NumList = []
lastnumber = 0
owd = os.getcwd()

def checkIfProcessRunning(processName):
#Iterate over the all the running process
    for proc in psutil.process_iter():
        try:
            # Check if process name contains the given name string.
            if processName.lower() in proc.name().lower():
                return True
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass
    return False

if os.name == 'nt':
    print("(Probably Running Windows)")
    iow = True
else:
    print("(Probably On Linux)")

#get current directory
if (iow):
    os.chdir(owd.replace("\\MultiplayerModFiles", ""))
else:
    os.chdir(owd.replace("/MultiplayerModFiles", ""))
owd = os.getcwd()
print(os.getcwd())

#get a number list of all the dlcs
for filename in os.listdir():
    if filename[0 : 11] == "portal2_dlc":
        if filename[11 : ].isnumeric():
            NumList.append(int(filename[11 : ]))

#sort the dlcs
Number = len(NumList)
for i in range (Number):
    for j in range(i + 1, Number):
        if(NumList[i] > NumList[j]):
            temp = NumList[i]
            NumList[i] = NumList[j]
            NumList[j] = temp

#find the highest numbered used dlc
for number in NumList:
            if number-1 == lastnumber:
                lastnumber = number
                #set the new temp dlc name
                if (iow):
                    dlcname = "\portal2_dlc" + str(number + 1)
                else:
                    dlcname = "/portal2_dlc" + str(number + 1)



#undo the patch dll renames so we can patch the server.dll again
try:
    if (iow):
        try:
            os.rename(owd + "\portal2\\bin\disabledserver.dll", owd + "\portal2\\bin\server.dll")
            print("found disabledserver.so just renamed to server.so (python probably crashed last session)")
        except:
            print()
        try:
            os.rename(owd + "\\bin\disabledengine.dll", owd + "\\bin\engine.dll")
            print("found engine.dll just renamed to engine.dll (python probably crashed last session)")
        except:
            print()
    else:
        try:
            os.rename(owd + "/portal2/bin/disabledserver.dll", owd + "/portal2/bin/server.dll")
            print("found disabledserver.dll just renamed to server.dll (python probably crashed last session)")
        except:
            print()
        try:
            os.rename(owd + "/portal2/bin/linux32/disabledserver.so", owd + "/portal2/bin/linux32/server.so")
            print("found disabledserver.so just renamed to server.so (python probably crashed last session)")
        except:
            print()
except:
    print("Error Trys Gave Exeption (odd)")



##################################
#        START OF PATCHING       #
##################################

#server.dll patch
try:
    #open server.dll into binary
    if (iow):
        f = open(owd + "\portal2\\bin\server.dll", 'rb')
    else:
        f = open(owd + "/portal2/bin/server.dll", 'rb')
    data = f.read()
    f.close()

    #33 player cap edit
    data = data.replace(b'\x8bM\x08\xc7\x00\x01\x00\x00\x00\xc7\x01\x01\x00\x00\x00\xff\x15(2X\x10', b'\x8bM\x08\xc7\x00\x1f\x00\x00\x00\xc7\x01\x1f\x00\x00\x00\xff\x15(2X\x10')
    data = data.replace(b'\xf7\xd8\x1b\xc0\xf7\xd8\x83\xc0\x02\x89\x01]', b'\xf7\xd8\x1b\xc0\xf7\xd8\x83\xc0 \x89\x01]')
    data = data.replace(b'\xff\xd0\x85\xc0t\x05\xbe\x03\x00\x00\x00\x8b}\x08V', b'\xff\xd0\x85\xc0t\x05\xbe!\x00\x00\x00\x8b}\x08V')
    data = data.replace(b'\xff\xd0\x85\xc0\x0f\x85\xaf\x05\x00\x00\xb0\x01_^', b'\xff\xd0\x85\xc0\x0f\x85\xaf\x05\x00\x00\xb0\x1f_^')

    #partner disconnect edit
    data = data.replace(b'disconnect "Partner disconnected"', b'script_execute playerdisconnected')

    #command patch edit
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

    #write changes into a new toplevel server.dll
    f2 = open("server.dll", 'wb')
    f2.write(data)
    f2.close()
except:
    print("Failed To Patch server.dll")

#server.so patch
if (iow):
    print("Running Windows Skipping server.so Patch")
else:
    try:
        #open server.so into binary
        f = open(owd + "/portal2/bin/linux32/server.so", 'rb')
        data = f.read()
        f.close()

        #33 player cap edit
        data = data.replace(b'\x01\x00\x00\x00\x8bD$\x14\xc7\x00\x01', b'\x1f\x00\x00\x00\x8bD$\x14\xc7\x00\x1f')
        data = data.replace(b'\xc0\x0f\xb6\xc0\x83\xc0\x02\x89\x02\x83\xc4', b'\xc0\x0f\xb6\xc0\x83\xc0 \x89\x02\x83\xc4')
        data = data.replace(b'\x0f\xb6\xc0\x83\xc0\x02\x83\xec\x04\x89\xf3', b'\x0f\xb6\xc0\x83\xc0 \x83\xec\x04\x89\xf3')
        data = data.replace(b'K\x8de\xf4\xb8\x01\x00\x00\x00[^', b'K\x8de\xf4\xb8\x1f\x00\x00\x00[^')

        #partner disconnect edit
        data = data.replace(b'disconnect "Partner disconnected"', b'script_execute playerdisconnected')

        #command patch edit
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

        #write changes into a new toplevel server.so
        f2 = open("server.so", 'wb')
        f2.write(data)
        f2.close()
    except:
        print("Failed To Patch server.so")

#engine.dll patch
if (iow):
    # try:
        #open engine.dll into binary
    if (iow):
        f = open(owd + "\\bin\engine.dll", 'rb')
    data = f.read()
    f.close()

    #remove steam validation
    data = data.replace(b't}\x8b\x17\x8b\x82\xcc\x00\x00', b'\xeb}\x8b\x17\x8b\x82\xcc\x00\x00')

    #write changes into a new toplevel engine.dll
    f2 = open("engine.dll", 'wb')
    f2.write(data)
    f2.close()
    print("Patched engine.dll")
    # except:
    #     print("Failed To Patch engine.dll")
else:
    print("Running Linux Skipping engine.dll Patch")

##################################
#         END OF PATCHING        #
##################################


#copy the multiplayermod files into the new dlc using the dlc name
if (iow):
    shutil.copytree(owd + "\MultiplayerModFiles\MainFiles\install_dlc", owd + dlcname)
else:
    shutil.copytree(owd + "/MultiplayerModFiles/MainFiles/install_dlc", owd + dlcname)
print("Copied \MultiplayerModFiles to " + dlcname)

try:
    #copy multiplayermod engine files into gamedir
    if (iow):
        shutil.copytree(owd + "\MultiplayerModFiles\MainFiles\gamedir", owd, dirs_exist_ok=True)

    print("Copied \MultiplayerModFiles\MainFiles\gamedir\MultiplayerModFiles to \Portal 2")
except:
    print("\gamedir Copy Failed (The Game Is Probably Running)")

#rename server.dll to disabledserver.dll so our newly patched server.dll runs
if (iow):
    os.rename(owd + "\portal2\\bin\server.dll", owd + "\portal2\\bin\disabledserver.dll")
    os.rename(owd + "\\bin\engine.dll", owd + "\\bin\disabledengine.dll")
else:
    os.rename(owd + "/portal2/bin/server.dll", owd + "/portal2/bin/disabledserver.dll")
    os.rename(owd + "/portal2/bin/linux32/server.so", owd + "/portal2/bin/linux32/disabledserver.so")



#start portal 2 with launch options
print("=======Game Launch=======")
try:
    if (iow):
        subprocess.run(["portal2.exe", "-novid", "-allowspectators", "+map mp_coop_lobby_3"])
    else:
        os.system("steam -applaunch 620 -novid -allowspectators +map mp_coop_lobby_3")
        print("Ran Game")
except:
    print("Failed Running portal2")


#remove Game Files After Game Exits
def RemoveMultiplayerFiles():
    #remove multiplayer mod files 
    try:
        if(iow):
            os.remove(owd + "\server.dll")
            os.remove(owd + "\engine.dll")
        else:
            os.remove(owd + "/server.dll")
            os.remove(owd + "/server.so")
        print("Removed Modded server.so/server.dll")
    except:
        print("Removing Modded server.dll Failed")

    try:
        shutil.rmtree(owd + dlcname)
        print("Removed " + dlcname)
    except:
        print("Removing Multiplayer Mod DLCs Failed")

    #rename main server.dll back to server.dll 
    try:
        if (iow):
            try:
                os.rename(owd + "\portal2\\bin\disabledserver.dll", owd + "\portal2\\bin\server.dll")
                print("found disabledserver.so just renamed to server.so (python probably crashed last session)")
            except:
                print()
            try:
                os.rename(owd + "\\bin\disabledengine.dll", owd + "\\bin\engine.dll")
                print("found engine.dll just renamed to engine.dll (python probably crashed last session)")
            except:
                print()
        else:
            try:
                os.rename(owd + "/portal2/bin/disabledserver.dll", owd + "/portal2/bin/server.dll")
                print("found disabledserver.dll just renamed to server.dll (python probably crashed last session)")
            except:
                print()
            try:
                os.rename(owd + "/portal2/bin/linux32/disabledserver.so", owd + "/portal2/bin/linux32/server.so")
                print("found disabledserver.so just renamed to server.so (python probably crashed last session)")
            except:
                print()
    except:
        print("Failed To UnRename Nessasary Files")



#wait for game to close
print("WARNING: DO NOT CLOSE THIS PYTHON WINDOW!!! WAITING FOR PORTAL 2 TO CLOSE")
time.sleep(2)
while True:
    #check if any portal 2 process is running
    if checkIfProcessRunning('ortal'):
        print('Portal 2 Is Still Running')
    else:
        print('Portal 2 Not Found Closing')
        print("=======Game Closed=======")
        RemoveMultiplayerFiles()
        break
    time.sleep(1)


print("")
print("=========================")
print("     Exiting Program...")
print("=========================")