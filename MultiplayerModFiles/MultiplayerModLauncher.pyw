import os
import shutil
NumList = []
lastnumber = 0
owd = os.getcwd()
os.chdir(owd)

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

shutil.copytree(owd + "\MultiplayerModFiles\MainFiles\gamedir", owd, dirs_exist_ok=True)
print("copied \MultiplayerModFiles\MainFiles\gamedir\MultiplayerModFiles to \Portal 2")
shutil.copytree(owd + "\MultiplayerModFiles\MainFiles\install_dlc", owd + dlcname)
print("copied \MultiplayerModFiles to " + dlcname)