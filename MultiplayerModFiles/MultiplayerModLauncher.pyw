import os
import shutil
import subprocess
import mmap
NumList = []
lastnumber = 0
owd = os.getcwd()
#get current directory
os.chdir(owd.replace("\\MultiplayerModFiles", ""))
owd = os.getcwd()

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
                dlcname = "\portal2_dlc" + str(number + 1)



#undo the server.dll rename to disabledserver.dll so we can patch the server.dll again
try:
    os.chdir(owd + "\portal2\\bin")
    os.rename("disabledserver.dll", "server.dll")
    os.chdir(owd)
except:
    print("Couldn't Find Disabled server.dll Everything Is Probably Fine")

#open server.dll into binary
with open(owd + "\portal2\\bin\server.dll", 'rb') as f:
    data = f.read()

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
try:
    with open("server.dll", 'wb') as f:
        f.write(data)
except:
    print("Couldn't Patch server.dll (The Game Is Probably Running)")

#rename server.dll to disabledserver.dll so our newly patched server.dll runs
os.chdir(owd + "\portal2\\bin")
os.rename("server.dll", "disabledserver.dll")
os.chdir(owd)


try:
    #copy multiplayermod engine files into gamedir
    shutil.copytree(owd + "\MultiplayerModFiles\MainFiles\gamedir", owd, dirs_exist_ok=True)
    print("Copied \MultiplayerModFiles\MainFiles\gamedir\MultiplayerModFiles to \Portal 2")
except:
    print("\gamedir Copy Failed (The Game Is Probably Running)")

#copy the multiplayermod files into the new dlc using the dlc name
shutil.copytree(owd + "\MultiplayerModFiles\MainFiles\install_dlc", owd + dlcname)
print("Copied \MultiplayerModFiles to " + dlcname)

#start portal 2 with launch options
subprocess.run(["portal2.exe", "-novid", "-allowspectators", "+map mp_coop_lobby_3"])





#remove multiplayer mod files 
try:
    os.remove(owd + "\server.dll")
    print("Removed Modded \server.dll")
except:
    print("Removing Modded server.dll Failed")

try:
    shutil.rmtree(owd + dlcname)
    print("Removed " + dlcname)
except:
    print("Removing Multiplayer Mod DLCs Failed")

#rename main server.dll back to server.dll 
try:
    os.chdir(owd + "\portal2\\bin")
    os.rename("disabledserver.dll", "server.dll")
    os.chdir(owd)
    print("Renamed disabledserver.dll Back To server.dll")
except:
    print("Renaming Main disabledserver.dll To server.dll Failed")