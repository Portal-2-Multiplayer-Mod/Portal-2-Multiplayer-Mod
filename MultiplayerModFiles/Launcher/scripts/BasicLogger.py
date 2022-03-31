import os
import sys
# just a basic logger :)
def Log(message):
    
    if sys.platform == "win32":
        nf = "\\"
    if sys.platform == sys.platform.startswith("linux"):
        nf = "/"
    # get the path of the python file and set the directory to it
    path = os.path.dirname(os.path.realpath(__file__))
    # if there is open it as utf-8 but dont delete the contents
    with open(path + nf + "MultiplayerModLauncher.log", "a", encoding="utf-8") as log:
        # write the message to the log
        log.write(message + "\n")
        # close the log
        log.close()
    if len(message) > 0:
        print("(P2:MM): " + message)
    else:
        print("")
