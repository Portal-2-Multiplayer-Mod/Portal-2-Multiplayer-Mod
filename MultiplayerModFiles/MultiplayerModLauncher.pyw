import os
import shutil
import subprocess
import mmap
NumList = []
lastnumber = 0
owd = os.getcwd()
os.chdir(owd.replace("MultiplayerModFiles", "")[:-1])
owd = os.getcwd()

for filename in os.listdir():
    if filename[0 : 11] == "portal2_dlc":
        if filename[11 : ].isnumeric():
            NumList.append(int(filename[11 : ]))

Number = len(NumList)
for i in range (Number):
    for j in range(i + 1, Number):
        if(NumList[i] > NumList[j]):
            temp = NumList[i]
            NumList[i] = NumList[j]
            NumList[j] = temp

for number in NumList:
            if number-1 == lastnumber:
                lastnumber = number
                dlcname = "\portal2_dlc" + str(number + 1)

# shutil.copytree(owd + "\MultiplayerModFiles\MainFiles\gamedir", owd, dirs_exist_ok=True)
# print("copied \MultiplayerModFiles\MainFiles\gamedir\MultiplayerModFiles to \Portal 2")
# shutil.copytree(owd + "\MultiplayerModFiles\MainFiles\install_dlc", owd + dlcname)
# print("copied \MultiplayerModFiles to " + dlcname)

# args = ["portal2.exe", "-windowed", "-w 69", "-h 69"]
# subprocess.run(["portal2.exe", "-novid", "-allowspectators", "+map mp_coop_lobby_3"])

# load it
with open("C:\Program Files (x86)\Steam\steamapps\common\Portal 2\portal2" + "\\" + "bin\server.dll", 'rb') as f:
    data = f.read()

# do something with data
data.replace(b'\x8b\x4d\x08\xc7\x00\x01\x00\x00\x00\xc7\x01\x01\x00\x00\x00\xff\x15\x28\x32\x58\x10', b'\x8b\x4d\x08\xc7\x00\x1f\x00\x00\x00\xc7\x01\x1f\x00\x00\x00\xff\x15\x28\x32\x58\x10')

# save it
with open("server.dll", 'wb') as f:
    f.write(data)