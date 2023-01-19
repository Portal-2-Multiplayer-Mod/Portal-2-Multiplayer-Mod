import Scripts.GlobalVariables as GVars
import os
from Scripts.BasicLogger import Log

##############
# CONVERSION #
##############

def ConvertPath(path: str) -> str:
    if (GVars.iol):
        path = path.replace("\\", GVars.nf)
        path = path.replace("~", os.path.expanduser("~"))

    elif (GVars.iow):
        path = path.replace("/", GVars.nf)

    return path

def DeleteFolder(path: str) -> None:
    if (GVars.iow):
        os.system("rmdir /s /q \"" + path + "\"")
    elif (GVars.iol):
        os.system("rm -rf \"" + path + "\"")

def CopyFolder(src: str, dst: str) -> str:
    if (GVars.iow):
        os.system("xcopy /E /H /C /I \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol):
        os.system("cp -r \"" + src + "\" \"" + dst + "\"")
    return dst

def CopyFile(src: str, dst: str) -> str:
    if (GVars.iow):
        os.system("copy \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol):
        os.system("cp \"" + src + "\" \"" + dst + "\"")
    return dst


def MoveFile(src: str, dst: str) -> str:
    if (GVars.iow):
        os.system("move \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol):
        os.system("mv \"" + src + "\" \"" + dst + "\"")
    return dst

def TryFindPortal2Path() -> str:

    # should be default linux path for the game
    defpathlin = ConvertPath("~/.local/share/Steam/steamapps/common/Portal 2")

    if (GVars.iol and os.path.isfile(defpathlin + "/portal2_linux")):
        return defpathlin


    if (GVars.iow):
        import winreg
        try:
            hkey = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, "SOFTWARE\WOW6432Node\Valve\Steam")
            print(hkey)
            steam_path = winreg.QueryValueEx(hkey, "InstallPath")
            print(steam_path)
            manifestpath = steam_path[0] + ConvertPath("/steamapps/libraryfolders.vdf")
            print(manifestpath)
            if (os.path.isfile(manifestpath)):
                # read the manifest file
                manifest = open(manifestpath, "r", encoding="utf-8").readlines()
                paths = []

                for line in manifest:
                    line = line.strip()
                    # remove the quotes
                    line = line.replace("\"", "")
                    print(line)
                    if (line.startswith("path")):
                        line = line.replace("path", "")
                        line = line.strip()
                        paths.append(line)

                for path in paths:
                    print(path)
                    if (os.path.isdir(path + ConvertPath("/steamapps/common/Portal 2"))):
                        return path + ConvertPath("/steamapps/common/Portal 2")

        except Exception as e:
            Log("ERROR: " + str(e))

    return False
