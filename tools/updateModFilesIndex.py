import os, json
from datetime import datetime

#? Purpose:
#* This Python script is used to update the ModIndex.json file as well as 
#* the identifier file found in the ModFiles.
#* This is used by the launcher to check if the version of the ModFiles
#* on remote is newer than what is downloaded on the users system, and if
#* the user has all the files. If not they will be asked to update their
#* ModFiles.

#? User Process:
#* 1- Run script from the src directory. `python tools\updateModFilesIndex.py`
#* 2- Copy the relative path of the identifier file. (ex: src\ModFiles\Portal 2\install_dlc\p2mm.identifier)
#* 3- Input the path when the script asks for it.
#* 4- A file should be created/updated (ModIndex.json) that means everything ran correctly, the identifier given will also be updated.
#* 5- Push the changes to GitHub.


def GetFiles(path):
    fileList = []
    # goes through all the files in the directory and saves their full name in fileList
    for root, dirs, files in os.walk(path):
        for file in files:
            fileList.append(os.path.join(root, file).replace(path,"").replace(os.sep, "/"))

    return fileList

def SaveData():
    filesData = {
        "Date": str(datetime.now().date()),
        "Path": "",
        "Files":[]
    }

    # loop until the given path is a file (Just copy the identifier's relative path)
    while not os.path.isfile(filesData["Path"]):
        filesData["Path"] = input("Input the relative path for the identifier file: ")
    
    open(os.getcwd()+os.sep + filesData["Path"], "w", encoding="utf-8").write(filesData["Date"]) # write the date to the identifier file (yes we need it) 
    print(os.getcwd() + os.sep + filesData["Path"])
    filesData["Path"] = os.path.dirname(filesData["Path"] ) # we only need the directory 
    path = os.getcwd()+os.sep + filesData["Path"] # this to get the absolute path of the folder for whoever is running this code
    filesData["Files"] = GetFiles(path)
    filesData["Path"] = filesData["Path"].replace(os.sep, "/") # to make it easy when using the path for the url
    savePath = os.getcwd() + os.sep + "ModIndex.json" 
    jsonStr = json.dumps(filesData)
    with open(savePath, "w",encoding="utf-8") as file:
        file.write(jsonStr)

SaveData()
print("Finished writing to ModIndex.json and identifier file! :D")