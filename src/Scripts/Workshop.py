import os

import Scripts.BasicFunctions as BF
import Scripts.GlobalVariables as GVars
from Scripts.BasicLogger import Log

def GetDownloadedMaps(workshopPath: str) -> set[dict[str, str]]:
    """returns a list of all downloaded workshop maps

    Parameters
    ----------
    workshopPath : str
        portal 2's workshop folder path

    Returns
    -------
    set[dict[str, str]]
        a list of maps with their 'name', 'bsp' and 'id'
    """

    mapsList : set[dict[str, str]] = {}

    for root, dirs, files in os.walk(workshopPath):
        if (".jpg" in str(files)) and (".bsp" in str(files)):
            CMap = {
                "name": "",
                "bsp": "",
                "id": ""
            }

            for file in files:
                if ".bsp" in file:
                    CMap["name"] = file.replace(".bsp", "")
                    CMap["bsp"] = "workshop" + os.path.join(root, file).replace(workshopPath, "")
                elif ".jpg" in file:
                    CMap["id"] = file.replace("thumb", "").replace(".jpg", "")

            mapsList.add(CMap)

    return mapsList


def SteamIDFromLink(link: str) -> str:
    """Get map id from workshop link

    Parameters
    ----------
    link : str

    Returns
    -------
    str
        workshop id
    """

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


def MapFromSteamID(workshopLink: str) -> str:
    """returns the path for a workshop map from a link

    Parameters
    ----------
    workshopLink : str
        the url of the map

    Returns
    -------
    str
        path relative to the portal 2's path
    """

    SteamID = SteamIDFromLink(workshopLink)
    mapsList = GetDownloadedMaps(GVars.configData["Portal2-Path"]["value"] + BF.NormalizePath("/portal2/maps/workshop"))

    for map_info in mapsList:
        if map_info["id"] == SteamID:
            return map_info["bsp"].replace(".bsp", "")

    return None
