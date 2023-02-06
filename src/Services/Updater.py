import http.client as httplib
import os
import shutil
import subprocess
import urllib.parse
import urllib.request
from datetime import datetime
from pathlib import Path

import requests

import Services.BasicFunctions as Funcs
import Services.GlobalVariables as GVars
from Services.BasicLogger import Log

# REMEMBER TO CHANGE THIS BEFORE RELEASEING A NEW VERSION OF THE LAUNCHER
currentVersion = "2.1.0"
ownerName = "Portal-2-Multiplayer-Mod"
repoName = "Portal-2-Multiplayer-Mod"  # we can't change this to the id :(

# A quick easy way to check if the system is connected to the internet, thanks stackOverflow for this solution <3


def haveInternet() -> bool:
    conn = httplib.HTTPSConnection("8.8.8.8", timeout=5)
    try:
        conn.request("HEAD", "/")
        conn.close()
        return True
    except Exception as e:
        Log(f"Failed to connect to the internet:\n{str(e)}")
        return False


def CheckForNewClient() -> dict:

    if not haveInternet():
        Log("No internet Connection")
        return {"status": False}

    Log("searching for a new client...")
    endpoint = "https://api.github.com/repos"  # github's api endpoint

    try:
        # do the get request to retrieve the latest release data
        r = requests.get(
            f"{endpoint}/{ownerName}/{repoName}/releases/latest").json()
    except Exception as e:
        Log(f"error retrieving the latest releases: {str(e)}")
        return {"status": False}

    if not "tag_name" in r:
        return {"status": False}

    # make sure that the latest release has a different version than the current one and is not a beta release
    if (currentVersion == r["tag_name"]) or ("beta" in r["tag_name"]):
        Log("Found release but it's old...")
        return {"status": False}

    results = {
        "status": True,
        "name": "Client Update",
        "message": "Would you like to download \n the new client?"
    }

    return results


def DownloadClient(cType: str = "") -> bool:

    if not haveInternet():
        Log("No internet Connection!")
        return False

    # cType is the Client Type (gui / cli)
    Log("Downloading...")
    cType = cType.upper()

    endpoint = "https://api.github.com/repos"  # github's api endpoint
    r = requests.get(
        f"{endpoint}/{ownerName}/{repoName}/releases/latest").json()

    # so we can easily edit it in the future if we want to
    if (GVars.iow):
        packageType = ".EXE"
    elif (GVars.iol)  :
        packageType = ".SH"

    downloadLink = ""
    # this goes through all the binaries in the latest release until one of them ends with the package type (.exe, .pkg etc...)
    for i in range(len(r["assets"])):
        if (r["assets"][i]["browser_download_url"].upper().endswith(cType+packageType)):
            Log("Found new client to download!")
            downloadLink = r["assets"][i]["browser_download_url"]
            break

    # make sure there's a download link
    if downloadLink == "":
        return False

    # download the file in the same directory
    # i don't want to bother with folders
    path = os.path.dirname(GVars.executable) + "/p2mm" + packageType
    urllib.request.urlretrieve(downloadLink, path)
    Log(f"Downloaded new client in: {path}")

    # if (GVars.iow):
    #     command = [path, "updated", GVars.executable]
    #     subprocess.Popen(command)
    if (GVars.iol)  :
        Log("Linux system detected, gotta chmod that bad boy...")
        permissioncommand = "chmod +x " + path
        os.system(permissioncommand)

    command = path + " updated " + GVars.executable
    subprocess.Popen(command, shell=True)
    Log("Launched the new client...")
    return True


def CheckForNewFiles() -> bool:

    if not haveInternet():
        Log("No internet Connection")
        return False

    Log("Checking for new files...")
    # plan
    # download modIndex.json
    # check if the date is greater than the one saved in the local identifier file
    # ask the user if they want to update
    # if yes read where the files are saved on the github repo
    # download all the files and delete the old ones

    # check if the identifier file exists or no
    localIdPath = GVars.modFilesPath + "/32playermod.identifier"
    if not os.path.isfile(localIdPath):
        Log("Identifier file doesn't exist so the mod files are probably unavailable too...")
        return True

    Log("Found local identifier file!")

    # if there was an error retrieving this file that means most likely that the name has changed and there is a new released client
    try:
        r = requests.get(
            f"https://raw.githubusercontent.com/{ownerName}/{repoName}/main/ModIndex.json").json()
    except Exception as e:
        Log(f"Error getting the index file: {str(e)}")
        return False

    # compare the dates of the local file and the file on the repo
    localDate = datetime.strptime(open(localIdPath, "r").read(), "%Y-%m-%d")
    remoteDate = datetime.strptime(r["Date"], "%Y-%m-%d")
    # if the remote date is less or equal to the local date that means our client is up to date
    if (remoteDate <= localDate):
        Log("Mod files are up to date...")
        return False

    Log(f"The remote date {remoteDate} is greater than the local date {localDate}...")

    return True


def DownloadNewFiles() -> None:

    if not haveInternet():
        Log("No internet Connection")
        return False

    r = requests.get(
        f"https://raw.githubusercontent.com/{ownerName}/{repoName}/main/ModIndex.json")
    r = r.json()
    Log("Downloading "+str(len(r["Files"]))+" files...")

    # downlaod the files to a temp folder
    tempPath = GVars.modPath + "/.temp"

    for file in r["Files"]:
        downloadLink = f"https://raw.githubusercontent.com/{ownerName}/{repoName}/main/"+urllib.parse.quote(
            r["Path"]+file)

        Path(os.path.dirname(tempPath + file)).mkdir(parents=True,
                                                     exist_ok=True)  # create the folder where the file exists

        try:
            urllib.request.urlretrieve(downloadLink, tempPath + file)
        except Exception as e:
            Log(f"Failed to download a file: {str(e)}")

    Log("finished downloading")

    try:
        # when downloading is done delete the old mod files
        Funcs.DeleteFolder(GVars.modFilesPath)
        Log("Deleted old files!")
    except Exception as e:
        Log("There was no old mod files.")
        Log(str(e))

    # then copy the new files there
    shutil.move(tempPath,  GVars.modFilesPath)
    Log("Copied new files to " + GVars.modFilesPath)
