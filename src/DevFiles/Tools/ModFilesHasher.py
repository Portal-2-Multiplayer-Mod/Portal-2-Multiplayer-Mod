import json
import os
import hashlib

# this file is to be run every time we want to push an update 
# this code will generate a json file with all the files' names and hashes 

def GetFiles(path):
    fileList = []
    # goes through all the files in the directory and saves their full name in fileList
    for root, dirs, files in os.walk(path):
        for file in files:
            fileList.append(os.path.join(root, file))

    return fileList


def GetHash(file):
    hasher = hashlib.md5()

    # opens the file for reading in binary mode
    with open(file, 'rb') as f:

        # loop till the end of the file
        chunk = 0
        while chunk != b'':
            # read only 1024 bytes at a time
            chunk = f.read(1024)
            hasher.update(chunk)

    return hasher.hexdigest()


def SaveFilesData():
    # if the files structure ever changed just change this line
    modFilesPath = "src/ModFiles/Portal 2/install_dlc" 
    # and keep the rest as is
    path = os.getcwd()+os.sep + modFilesPath
    savePath = os.getcwd() + os.sep + "modFilesData.json"
    fileList = GetFiles(path)
    jsn = {}
    for i in range(len(fileList)):
        jsn[fileList[i].replace(path, "").replace(os.sep, "/")] = GetHash(fileList[i])

    jsonStr = json.dumps(jsn)
    open(savePath, "w").write(modFilesPath + "\n") # this is so the client can know where the files are saved
    open(savePath, "a").write(jsonStr)

    print("saved Files Data in: " + savePath)


SaveFilesData()
