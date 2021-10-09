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
with open("server.dll", 'wb') as f:
    f.write(data)



#copy multiplayermod engine files into gamedir
shutil.copytree(owd + "\MultiplayerModFiles\MainFiles\gamedir", owd, dirs_exist_ok=True)
print("copied \MultiplayerModFiles\MainFiles\gamedir\MultiplayerModFiles to \Portal 2")

#copy the multiplayermod files into the new dlc using the dlc name
shutil.copytree(owd + "\MultiplayerModFiles\MainFiles\install_dlc", owd + dlcname)
print("copied \MultiplayerModFiles to " + dlcname)

#start portal 2 with launch options
args = ["portal2.exe", "-windowed", "-w 69", "-h 69"]
subprocess.run(["portal2.exe", "-novid", "-allowspectators", "+map mp_coop_lobby_3"])