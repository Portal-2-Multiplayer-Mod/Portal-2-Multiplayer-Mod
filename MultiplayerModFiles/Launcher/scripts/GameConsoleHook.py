# imports
from hashlib import new
from mimetypes import suffix_map
import os

# define variables
gamepath = "/home/kyle/common/Portal 2"
filepath = "/portal2/console.log"
path = gamepath + filepath

prefix = "ᴘᴏʀᴛᴀʟᴘʏᴛʜᴏɴɪɴᴘᴜᴛ╠═╣" # required!
suffix = "╠═╣" # required!

# make a global variable
Portal2InputNumber = 0

# define functions
def FetchData():
    with open(path, "r") as file:
        data = file.readlines()
    return data

def ClearFile():
    newdata = FetchData()
    for index, line in enumerate(newdata):
        # if it doesnt have the prefix, delete it
        if not prefix in line:
            newdata.pop(index)

    # join the list into a string with newlines
    newdata = "".join(newdata)

    with open(path, "w") as file:
        file.write(newdata)

def ResetFile():
    with open(path, "w") as file:
        file.write("")
    print("__File reset__")

def ProcessData(data):
    global Portal2InputNumber

    commands = []

    for line in data:
        if prefix in line:
            # remove the newline character
            line = line.replace("\n", "")
            # delete the prefix
            line = line.replace(prefix, "")
            # read everything before the suffix
            number = line.split(suffix)[0]
            # check for the reset char
            if number == "reset":
                Portal2InputNumber = 0
                ResetFile()
                return commands
            else:
                number = int(number)
            # delete the suffix and everything before it
            line = line.split(suffix)[1]

            if number > Portal2InputNumber:
                # set the global variable
                Portal2InputNumber = number
                print("Portal2InputNumber: " + str(Portal2InputNumber))
                commands.append(line)
        
    return commands

def RunCommands(commands):
    for command in commands:
        print(command)

# main
ResetFile()

while True:
    data = FetchData()
    commands = ProcessData(data)
    RunCommands(commands)
    if len(commands) > 0:
        ClearFile()