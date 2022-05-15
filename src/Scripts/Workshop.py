import Scripts.GlobalVariables as GVars
import Scripts.BasicFunctions as BF
import os

def UpdateMapList(workshoppath):
    global maplist
    maplist = []
    for root, dirs, files in os.walk(workshoppath):
        if ".jpg" in str(files) and ".bsp" in str(files):
            CMap = {}

            for file in files:
                if ".bsp" in file:
                    CMap["name"] = file.replace(".bsp", "")
                    CMap["bsp"] = "workshop" + os.path.join(root, file).replace(workshoppath, "")
                elif ".jpg" in file:
                    CMap["id"] = file.replace("thumb", "").replace(".jpg", "")
            maplist.append(CMap)

def SteamIDFromLink(link):
    return link.replace("https://steamcommunity.com/sharedfiles/filedetails/?id=", "")

def MapFromSteamID(SteamID, workshoppath = False):
    if workshoppath == False:
        workshoppath = GVars.configData["portal2path"]["value"] + BF.ConvertPath("/portal2/maps/workshop")
    SteamID = SteamIDFromLink(SteamID)
    UpdateMapList(workshoppath)

    for map in maplist:
        if map["id"] == SteamID:
            return map
    return False