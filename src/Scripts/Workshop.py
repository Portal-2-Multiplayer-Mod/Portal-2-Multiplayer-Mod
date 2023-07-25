import os
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

# Get the workshop pages Steam ID from its link
def SteamIDFromLink(link: str) -> str:
    # Check if it's a valid Steam Workshop link
    if not link.startswith("https://steamcommunity.com/sharedfiles"):
        Log("Not a valid Steam Workshop link!")
        return None
    
    # Find the index of '?id=' in the link
    id_index = link.find('?id=')

    if id_index != -1:
        # Extract the substring after '?id='
        link = link[id_index + 4:]

        # Find the index of '&' in the remaining substring )if present)
        ampersand_index = link.find('&')

        if ampersand_index != -1:
            # Remove everything after '&' to get the Steam ID
            link = link[:ampersand_index]

    return link

# Get the changelevel command of a map from the workshop maps Steam Workshop page link
def MapFromSteamID(workshopLink: str) -> str:
    SteamID = SteamIDFromLink(workshopLink)
    maplist = UpdateMapList(GVars.configData["Portal2-Path"]["value"] + BF.NormalizePath("/portal2/maps/workshop"))

    for map_info in maplist:
        if map_info["id"] == SteamID:
            return map_info["bsp"].replace(".bsp", "")
    return None