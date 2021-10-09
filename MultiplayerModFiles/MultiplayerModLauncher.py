import os
lastnumber = 0
owd = os.getcwd()
os.chdir(owd)
for filename in os.listdir():
    if filename[0 : 11] == "portal2_dlc":
        if filename[11 : ].isnumeric():
            if int(filename[11 : ])-1 == lastnumber:
                lastnumber = int(filename[11 : ])
                print(filename)