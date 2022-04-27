import Scripts.GlobalVariables as GVars
from Scripts.BasicLogger import Log
from datetime import datetime
from pathlib import Path
import urllib.request
import urllib.parse
import requests
import shutil
import os

currentVersion = "2.0.0" # change this before releasing a new version
ownerName = "kyleraykbs"
repoName = "Portal2-32PlayerMod"  # we can't change this to the id :(


def CheckForNewClient():
    Log("searching for a new client...")
    endpoint = "https://api.github.com/repos"  # github's api endpoint
    # do the get request to retrieve the latest release data
    r = requests.get(f"{endpoint}/{ownerName}/{repoName}/releases/latest")

    # make sure that the latest release has a different version than the current one and is not a beta release
    if (currentVersion == r.json()["tag_name"]) or ("beta" in r.json()["tag_name"]):
        return {"status": False}

    results = {
        "status": True,
        "Type": "info",  # for if we want to add icons for the alert dialog
        "name": "update available",
        "message": ""  # we set this after we see what OS the user is on
    }

    # if it's windows then we ask if the user want to update or no
    # and linux users can update using their package manager
    if GVars.iow:
        # we can have 2 buttons yes or no for this
        results["message"] = "There's a new update available! {GVars.nf}n do you want to download it?"
    else:
        # we only need an "ok" button for this
        results["message"] = "there's a new update available! {GVars.nf}n update through your package manager if you want"

    return results


def DownloadClient():
    Log("Downloading...")

    endpoint = "https://api.github.com/repos"  # github's api endpoint
    r = requests.get(f"{endpoint}/{ownerName}/{repoName}/releases/latest")

    packageType = ".exe"  # so we can easily edit it in the future if we want to

    downloadLink = ""
    # this goes through all the binaries in the latest release until one of them ends with the package type (.exe, .pkg etc...)
    for i in range(len(r.json()["assets"])):
        if(r.json()["assets"][i]["browser_download_url"].endsWith(packageType)):
            Log("Found client to download!")
            downloadLink = r.json()["assets"][i]["browser_download_url"]
            break

    # just to make sure there's a link that we can download from
    if downloadLink == "":
        return False

    # download the file in a temporary folder we move it later
    path = GVars.modPath + GVars.nf + ".temp" + GVars.nf + "p2mm" + packageType
    urllib.request.urlretrieve(downloadLink, path)

    # can we even send a command to delete the current running instance and replace it with the new one?
    # it's like self destruction, is that even possible?


def CheckForNewFiles():
    Log("Checking for new files...")
    # plan
    # download modIndex.json
    # check if the date is greater than the one saved in the locak identifier file
    # ask the user if they want to update
    # if yes read where the files are saved on the github repo
    # download all the files and delete the old ones

    r = requests.get(f"https://raw.githubusercontent.com/{ownerName}/{repoName}/main/ModIndex.json")
    r = r.json()

    # this way if the identifier file does not exist or the time in it is older, it will download the mod files
    try:
        localIdPath = GVars.modPath + GVars.nf + f"ModFiles{GVars.nf}Portal 2{GVars.nf}install_dlc{GVars.nf}32playermod.identifier"
        localDate = datetime.strptime("%Y-%m-%d", open(localIdPath, "r").read())
        remoteDate = datetime.strptime("%Y-%m-%d", r["Date"])
        # love safe guards
        if not (remoteDate > localDate):
            Log("mod files are up to date")
            return
    except:
        Log(f"'{localIdPath}' does not exist")

    Log("downloading "+str(len(r["Files"]))+" files...")
    # downlaod the files to a temp folder
    tempPath = GVars.modPath + GVars.nf + ".temp"
    for file in r["Files"]:
        downloadLink = f"https://raw.githubusercontent.com/{ownerName}/{repoName}/main/"+urllib.parse.quote(r["Path"]+file)

        Path(os.path.dirname(tempPath + file.replace("/", GVars.nf))).mkdir(parents=True,exist_ok=True)  # create the folder where the file exists
        urllib.request.urlretrieve(downloadLink, tempPath + file.replace("/", GVars.nf))

    Log("finished downloading")
    try:
        # when downloading is done delete the old mod files
        shutil.rmtree(GVars.modPath + f"{GVars.nf}ModFiles{GVars.nf}Portal 2{GVars.nf}install_dlc")
        Log("deleted old files")
    except Exception as e:
        Log("there was no old mod files")

    # then copy the new files there
    shutil.move(tempPath + GVars.nf + ".", GVars.modPath + f"{GVars.nf}ModFiles{GVars.nf}Portal 2{GVars.nf}install_dlc")
    Log("copied new files to " + GVars.modPath + f"{GVars.nf}ModFiles{GVars.nf}Portal 2{GVars.nf}install_dlc")
    