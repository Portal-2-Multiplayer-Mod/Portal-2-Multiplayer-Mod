import Scripts.GlobalVariables as GVars
import Scripts.BasicFunctions as BF
import os

def UpdateMapList(workshoppath):
    global maplist
    maplist = []
    for root, dirs, files in os.walk(workshoppath):
        if (".jpg" in str(files)) and (".bsp" in str(files)):
            CMap = {
                "name" : "",
                "bsp" : "",
                "id" : ""
            }

            for file in files:
                if ".bsp" in file:
                    CMap["name"] = file.replace(".bsp", "")
                    CMap["bsp"] = "workshop" + os.path.join(root, file).replace(workshoppath, "")
                elif ".jpg" in file:
                    CMap["id"] = file.replace("thumb", "").replace(".jpg", "")
            maplist.append(CMap)

def SteamIDFromLink(link : str):
    # remove the usual url
    link = link.replace("https://steamcommunity.com/sharedfiles/filedetails/?id=", "")
    # removes the searchtext
    # when you search for a map and you copy the link it will append the search text to the end of the url
    # like this -> https://steamcommunity.com/sharedfiles/filedetails/?id=91038223&searchtext=gelocity
    # so to remove it we loop through the string we have until we find a letter then we substring all that's before it
    i : int = 0
    for letter in link:
        if not letter.isdigit():
            link = link[0:i]
            break
        i += 1
    
    return link

def MapFromSteamID(SteamID, workshoppath = False):
    if workshoppath == False:
        workshoppath = GVars.configData["portal2path"]["value"] + BF.ConvertPath("/portal2/maps/workshop")
    SteamID = SteamIDFromLink(SteamID)
    UpdateMapList(workshoppath)

    for map in maplist:
        if map["id"] == SteamID:
            return map
    return False