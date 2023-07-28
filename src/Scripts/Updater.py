import http.client as httplib
import os
import shutil
import subprocess
import urllib.parse
import urllib.request
from datetime import datetime
from pathlib import Path

import requests

import Scripts.BasicFunctions as BF
import Scripts.GlobalVariables as GVars
from Scripts.BasicLogger import Log

currentVersion = "2.2.0" # change this before releasing a new version
ownerName = "Portal-2-Multiplayer-Mod"
repoName = "Portal-2-Multiplayer-Mod"  # we can't change this to the id :(
# this is to download the new client if it ever releases
newRepoName = "P2MM-Entanglement"


# thanks stackOverflow for this solution <3
def HasInternet() -> bool:
    """Check for internet connection

    Returns
    -------
    bool
        has internet or no
    """

    conn = httplib.HTTPSConnection("8.8.8.8", timeout=5)
    try:
        conn.request("HEAD", "/")
        return True
    except Exception:
        return False
    finally:
        conn.close()


def CheckForNewClient() -> dict:

    if not HasInternet():
        Log("No internet Connection")
        return {"status": False}

    Log("searching for a new client...")

    endpoint = "https://api.github.com/repos"
    foundNewVer = True
    foundNewRepo = False

    #! search for a new client on the old repo
    try:
        repoData = requests.get(
            f"{endpoint}/{ownerName}/{repoName}/releases/latest").json()
    except Exception as e:
        Log(f"error retrieving the latest releases: {str(e)}")
        return {"status": False}

    if "tag_name" in repoData:

        # make sure that the latest release has a different version than the current one and is not a beta release
        if (currentVersion == repoData["tag_name"]) or ("beta" in repoData["tag_name"]):
            Log("found release but it's old")
            foundNewVer = False

    #! search for a new client on the new repo
    try:
        repoData = requests.get(
            f"{endpoint}/{ownerName}/{newRepoName}/releases/latest").json()
    except Exception as e:
        Log(f"error retrieving the latest releases: {str(e)}")
        return {"status": False}

    if "tag_name" in repoData:
        foundNewRepo = True

    if foundNewRepo or foundNewVer:
        results = {
            "status": True,
            "newRepo": False
        }

        if foundNewRepo:
            results["newRepo"] = True

    else:
        results = {"status": False}

    return results


def DownloadClient(newRepo: bool) -> bool:

    if not HasInternet():
        Log("No internet Connection!")
        return False

    Log("Downloading...")

    endpoint = "https://api.github.com/repos"

    if not newRepo:
        r = requests.get(
            f"{endpoint}/{ownerName}/{repoName}/releases/latest").json()
    else:
        r = requests.get(
            f"{endpoint}/{ownerName}/{newRepoName}/releases/latest").json()

    # so we can easily edit it in the future if we want to
    if (GVars.iow):
        packageType = ".EXE"
    elif (GVars.iol or GVars.iosd):
        packageType = ".SH"

    downloadLink = ""

    # this goes through all the binaries in the latest release until one of them ends with the package type (.exe, .pkg etc...)
    for i in range(len(r["assets"])):
        if (r["assets"][i]["browser_download_url"].upper().endswith(packageType)):
            Log("Found new client to download!")
            downloadLink = r["assets"][i]["browser_download_url"]
            break

    # make sure there's a download link
    if downloadLink == "":
        return False

    # download the file in the same directory
    # i don't want to bother with folders
    path = os.path.dirname(GVars.executable) + os.sep + "p2mm" + packageType
    urllib.request.urlretrieve(downloadLink, path)
    Log(f"Downloaded new client in: {path}")

    # if (GVars.iow):
    #     command = [path, "updated", GVars.executable]
    #     subprocess.Popen(command)

    if (GVars.iol or GVars.iosd):
        Log("Linux detected, gotta chmod that bad boy!")
        os.system(f"chmod +x {path}")

    command = path + " updated " + GVars.executable
    subprocess.Popen(command, shell=True)
    Log("Launched the new client")
    return True


def CheckForNewFiles() -> bool:

    if not HasInternet():
        Log("No internet Connection!")
        return False

    Log("Checking for new files...")
    # plan
    # download modIndex.json
    # check if the date is greater than the one saved in the local identifier file
    # ask the user if they want to update
    # if yes read where the files are saved on the github repo
    # download all the files and delete the old ones

    # check if the identifier file exists or no
    localIdPath = GVars.modPath + os.sep + \
        f"ModFiles{os.sep}Portal 2{os.sep}install_dlc{os.sep}p2mm.identifier"
    if not os.path.isfile(localIdPath):
        Log("Identifier file doesn't exist so the mod files are probably unavailable too")
        return True

    Log("Found local identifier file")

    # if there was an error retrieving this file that means most likely that we changed it's name and released a new client
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
        Log("Mod files are up to date")
        return False

    Log(f"The remote date {remoteDate} is greater than the local date {localDate}")

    return True


def DownloadNewFiles() -> None:

    if not HasInternet():
        Log("No internet Connection")
        return False

    r = requests.get(
        f"https://raw.githubusercontent.com/{ownerName}/{repoName}/main/ModIndex.json")
    r = r.json()
    Log("downloading "+str(len(r["Files"]))+" files...")

    # download the files to a temp folder
    tempPath = GVars.modPath + os.sep + ".temp"
    for file in r["Files"]:
        downloadLink = f"https://raw.githubusercontent.com/{ownerName}/{repoName}/main/"+urllib.parse.quote(
            r["Path"]+file)

        Path(os.path.dirname(tempPath + file.replace("/", os.sep))).mkdir(parents=True,
                                                                          exist_ok=True)  # create the folder where the file exists
        try:
            urllib.request.urlretrieve(
                downloadLink, tempPath + file.replace("/", os.sep))
        except Exception as e:
            Log(f"Failed to download a file: {str(e)}")
    Log("Finished downloading")

    try:
        # when downloading is done delete the old mod files
        BF.DeleteFolder(BF.NormalizePath(
            GVars.modPath + "/ModFiles/Portal 2/install_dlc"))
        Log("Deleted old files")
    except Exception as e:
        Log("There was no old mod files")
        Log(str(e))

    # then copy the new files there
    shutil.move(tempPath, BF.NormalizePath(
        GVars.modPath + "/ModFiles/Portal 2/install_dlc"))
    Log("Copied new files to " + GVars.modPath +
        BF.NormalizePath("/ModFiles/Portal 2/install_dlc"))
