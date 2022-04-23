import os
import json
import hashlib
from Scripts.BasicLogger import Log
import Scripts.GlobalVariables as GVars

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
    modFilesPath = "ModFiles" + GVars.nf + "Portal 2" + GVars.nf + "install_dlc" # relative mod path
    # and keep the rest as is
    path = GVars.modPath + GVars.nf + modFilesPath # absolute mod path
    savePath = GVars.modPath + GVars.nf + "modFilesData.json" # where to save the files data
    Log(path)
    fileList = GetFiles(path)
    Log("got all Files data")
    Log("serializing Data")
    jsn = {}
    for i in range(len(fileList)):
        jsn[fileList[i].replace(path, "").replace(os.sep, "/")] = GetHash(fileList[i]) # the second replace is only needed for windows but whatever
        
    Log("writing to file")
    jsonStr = json.dumps(jsn)
    open(savePath, "w").write(jsonStr)

    Log("saved Files Data in: " + savePath)
    return savePath
