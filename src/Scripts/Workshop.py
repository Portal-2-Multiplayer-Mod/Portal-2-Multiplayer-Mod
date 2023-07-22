import os
import re
from typing import List, Dict

import Scripts.BasicFunctions as BF
import Scripts.GlobalVariables as GVars
from Scripts.BasicLogger import Log

# Get a full list of all the users workshop maps so we can find the requested map
def UpdateMapList(workshoppath: str) -> List[Dict[str, str]]:
    maplist = []
    for root, dirs, files in os.walk(workshoppath):
        if (".jpg" in str(files)) and (".bsp" in str(files)):
            CMap = {
                "name": "",
                "bsp": "",
                "id": ""
            }

            for file in files:
                if ".bsp" in file:
                    CMap["name"] = file.replace(".bsp", "")
                    CMap["bsp"] = "workshop" + os.path.join(root, file).replace(workshoppath, "")
                elif ".jpg" in file:
                    CMap["id"] = file.replace("thumb", "").replace(".jpg", "")
            maplist.append(CMap)
    return maplist

# Use regular expression to extract the workshop's SteamID
def SteamIDFromLink(link: str) -> str:
    match = re.search(r"https://steamcommunity.com/sharedfiles/filedetails/\?id=(\d+)", link)
    if match:
        return match.group(1)
    else:
        Log("Invalid Steam Workshop link format!")
        return

# Get the changelevel command of a map from the workshop maps Steam page link
def MapFromSteamID(workshopLink: str) -> str:
    SteamID = SteamIDFromLink(workshopLink)
    maplist = UpdateMapList(GVars.configData["Portal2-Path"]["value"] + BF.ConvertPath("/portal2/maps/workshop"))

    for map_info in maplist:
        if map_info["id"] == SteamID:
            return map_info["bsp"].replace(".bsp", "")
    return None