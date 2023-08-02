import os
from datetime import datetime
import json


# to update the files just
# 1- run this code
# 2- copy the relative path of the identifier file (ex: src\ModFiles\Portal 2\install_dlc\32playermod.identifier)
# 3- input it whe the mod asks for it
# 4- a file should be created / updated (ModIndex.json) that means everything ran correctly
# 5- just push the changes to github


def GetFiles(path):
    fileList = []
    # goes through all the files in the directory and saves their full name in fileList
    for root, dirs, files in os.walk(path):
        for file in files:
            fileList.append(os.path.join(root, file).replace(
                path, "").replace(os.sep, "/"))

    return fileList


def SaveData():
    filesData = {
        "Date": str(datetime.now().date()),
        "Path": "",
        "Files": []
    }

    # loop until the given path is a file (Just copy the identifier's relative path)
    while not os.path.isfile(filesData["Path"]):
        filesData["Path"] = input(
            "input the relative path for the identifier file ")

    # write the date to the identifier file (yes we need it)
    open(os.getcwd()+os.sep + filesData["Path"],
         "w", encoding="utf-8").write(filesData["Date"])

    filesData["Path"] = os.path.dirname(
        filesData["Path"])  # we only need the directory
    # this to get the absolute path of the folder for whoever is running this code
    path = os.getcwd()+os.sep + filesData["Path"]
    filesData["Files"] = GetFiles(path)
    # to make it easy when using the path for the url
    filesData["Path"] = filesData["Path"].replace(os.sep, "/")
    savePath = os.getcwd() + os.sep + "ModIndex.json"
    jsonStr = json.dumps(filesData)
    with open(savePath, "w", encoding="utf-8") as file:
        file.write(jsonStr)
    print("finished writing to file")


SaveData()
