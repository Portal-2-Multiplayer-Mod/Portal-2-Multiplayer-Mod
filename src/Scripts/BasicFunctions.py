"""Common functions used throughout the project."""

import Scripts.GlobalVariables as GVars
import os

def NormalizePath(path: str) -> str:
    """Normalizes the given path

    Parameters
    ----------
    path : str

    Returns
    -------
    str
        A path that's compatible by the OS
    """

    if (GVars.iol) or (GVars.iosd):
        path = path.replace("~", os.path.expanduser("~"))

    return os.path.normpath(path)

def DeleteFolder(path: str) -> None:
    """Deletes folder using OS specific commands

    Parameters
    ----------
    path : str
        folder path
    """

    if (GVars.iow):
        os.system("rmdir /s /q \"" + path + "\"")
    elif (GVars.iol) or (GVars.iosd):
        os.system("rm -rf \"" + path + "\"")


def CopyFolder(src: str, dst: str) -> str:
    """Copies folder using OS specific commands

    Parameters
    ----------
    src : str
        original folder path
    dst : str
        the destination to copy the folder to

    Returns
    -------
    str
        path copied to.
    """

    if (GVars.iow):
        os.system("xcopy /E /H /C /I /Y \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol) or (GVars.iosd):
        os.system("cp -r \"" + src + "\" \"" + dst + "\"")
    return dst

# Copies a file using the OSes copy command
def CopyFile(src: str, dst: str) -> str:
    """Copies file using OS specific commands

    Parameters
    ----------
    src : str
        original file path
    dst : str
        the destination to copy the file to

    Returns
    -------
    str
        dst
    """

    if (GVars.iow):
        os.system("copy \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol) or (GVars.iosd):
        os.system("cp \"" + src + "\" \"" + dst + "\"")
    return dst

def MoveFile(src: str, dst: str) -> str:
    """Moves file using OS specific commands

    Parameters
    ----------
    src : str
        original file path
    dst : str
        path to move the file to

    Returns
    -------
    str
        dst
    """

    if (GVars.iow):
        os.system("move \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol) or (GVars.iosd):
        os.system("mv \"" + src + "\" \"" + dst + "\"")
    return dst

def TryFindPortal2Path() -> str | bool:
    """Attempts to find the game's path mainly on windows

    Returns
    -------
    str | bool
        path to the game if found / false if it doesn't exist
    """

    if (GVars.iol or GVars.iosd):
        # Should be default linux path for the game
        defaultLinuxPath = NormalizePath("~/.local/share/Steam/steamapps/common/Portal 2")

        if (os.path.isfile(defaultLinuxPath + "/portal2_linux")):
            return defaultLinuxPath

    if (GVars.iow):
        import winreg
        try:
            hkey = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, "SOFTWARE\WOW6432Node\Valve\Steam")
            print(hkey)
            steamPath = winreg.QueryValueEx(hkey, "InstallPath")
            print(steamPath)
            manifestPath = steamPath[0] + NormalizePath("/steamapps/libraryfolders.vdf")
            print(manifestPath)

            if (os.path.isfile(manifestPath)):
                # read the manifest file
                manifest = open(manifestPath, "r", encoding="utf-8").readlines()
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
                    if (os.path.isdir(path + NormalizePath("/steamapps/common/Portal 2"))):
                        return path + NormalizePath("/steamapps/common/Portal 2")

        except Exception as e:
            print("ERROR: " + str(e))

    return False

def StringToParagraph(text: str, length: int) -> str:
    """formats a string to a paragraph like text

    Parameters
    ----------
    text : str
        text to format
    length : int
        how many characters can be in 1 line

    Returns
    -------
    str
        formatted text
    """

    words = text.split(" ")
    newText : str = ""
    currentLineLength = 0

    for i in range(len(words)):
        if (currentLineLength + len(words[i])) > length:
            newText += "\n"
            currentLineLength = 0

        newText += " " + words[i]
        currentLineLength += len(words[i]) +1

    return newText.strip()
