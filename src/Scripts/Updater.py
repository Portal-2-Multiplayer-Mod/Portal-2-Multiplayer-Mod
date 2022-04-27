from Scripts.BasicLogger import Log
import Scripts.GlobalVariables as GVars
import requests
import urllib.request
import os
import __main__

currentVersion = "2.0.0"
# get request related data
endpoint = "https://api.github.com/repos"  # github's api endpoint
ownerName = "kyleraykbs"
# we probably can change this to the ID so it's more consistent
repoName = "Portal2-32PlayerMod"


def CheckForNewClient():
    Log("searching for a new client...")
    
    # do the get request to retrieve the latest release data
    r = requests.get(f"{endpoint}/{ownerName}/{repoName}/releases/latest")
    
    # make sure that the latest release has a different version than the current one and is not a beta release
    if (currentVersion == r.json()["tag_name"]) or ("beta" in r.json()["tag_name"]):
        return {"status": False}
    
    results = {
        "status": True,
        "Type": "info", # for if we want to add icons for the alert dialog
        "name": "update available",
        "message": "" # we set this after we see what OS the user is on
    }
    
    # if it's windows then we ask if the user want to update or no
    # and linux users can update using their package manager  
    if GVars.iow:
        results["message"] = "There's a new update available! \n do you want to download it?" # we can have 2 buttons yes or no for this
    else:
        results["message"] = "there's a new update available! \n update through your package manager if you want" # we only need an "ok" button for this
    
    return results
   

def CheckForNewFiles():
    Log("Checking for new files...")
    


def DownloadClient():
    Log("Downloading...")

    r = requests.get(f"{endpoint}/{ownerName}/{repoName}/releases/latest")
    
    packageType = ".exe" # so we can easily edit it in the future if we want to
    
    downloadLink =""
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
    path = os.path.dirname(__main__.__file__) + GVars.nf + ".temp" + GVars.nf + "p2mm" + packageType
    urllib.request.urlretrieve(downloadLink, path)

    # can we even send a command to delete the current running instance and replace it with the new one?
    # it's like self destruction, is that even possible?