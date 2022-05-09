import Scripts.GlobalVariables as GVars
import os
import sys

if (GVars.iol):
    import winreg

##############
# CONVERSION #
##############

def ConvertPath(path):
    if (GVars.iol):
        path = path.replace("\\", GVars.nf)
        path = path.replace("/", GVars.nf)
        path = path.replace("~", os.path.expanduser("~"))
        return path
    elif (GVars.iow):
        path = path.replace("\\", GVars.nf)
        path = path.replace("/", GVars.nf)
        return path

def DeleteFolder(path):
    if (GVars.iow):
        os.system("rmdir /s /q \"" + path + "\"")
    elif (GVars.iol):
        os.system("rm -rf \"" + path + "\"")

def CopyFolder(src, dst):
    if (GVars.iow):
        os.system("xcopy /E /H /C /I \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol):
        os.system("cp -r \"" + src + "\" \"" + dst + "\"")
    return dst

def CopyFile(src, dst):
    if (GVars.iow):
        os.system("copy \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol):
        os.system("cp \"" + src + "\" \"" + dst + "\"")
    return dst

def TryFindPortal2Path():
    # if C:\Program Files (x86)\Steam\steamapps\common\Portal 2 exists
    defpathwin = ConvertPath("C:\Program Files (x86)\Steam\steamapps\common\Portal 2")
    defpathlin = ConvertPath("~/.local/share/Steam/steamapps/common/Portal 2")
    
    if (GVars.iol):
        if (os.path.isdir(defpathlin)):
            return defpathlin
    elif (GVars.iow):
        if (os.path.isdir(defpathwin)):
            return defpathwin

    if (GVars.iow):
        try:
            hkey = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, "SOFTWARE\WOW6432Node\Valve\Steam")
            print(hkey)
            steam_path = winreg.QueryValueEx(hkey, "InstallPath")
            print(steam_path)
            return steam_path[0] + "steamapps"
        except Exception as e:
            print("ERROR: " + str(e))

    return False