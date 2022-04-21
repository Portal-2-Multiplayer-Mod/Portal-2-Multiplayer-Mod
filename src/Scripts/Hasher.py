import json
import os
import hashlib
from Scripts.BasicLogger import Log

def GetFiles(path):
    fileList = []
    # goes through all the files in the directory and saves their full name in fileList
    for root, files in os.walk(path):
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
    
    modFilesPath = "src"+os.sep+"ModFiles" + os.sep+"Portal 2"+os.sep+"install_dlc" # relative mod path
    path = os.getcwd()+os.sep+ modFilesPath # absolute mod path
    savePath = os.getcwd() + os.sep + "modFilesData.json" # where to save the files data
    
    fileList = GetFiles(path)
    Log("got all Files data")
    Log("serializing Data")
    jsn = []
    for i in range(len(fileList)):
        jsn.append({"name": fileList[i].replace(path, "").replace(os.sep, "/"),
                    "hash": GetHash(fileList[i])})

    Log("writing to file")
    jsonStr = json.dumps(jsn)
    open(savePath, "w").write(jsonStr)

    Log("saved Files Data in: " + savePath)
