#VARIBLES
# prefix = 'script if (Entities.FindByClassname(null, "point_clientcommand") == null) { Entities.CreateByClassname("point_clientcommand")} else { myclientcommand <- Entities.FindByClassname(null, "point_clientcommand")};echo NEWLINE;script EntFireByHandle(myclientcommand, "Command", \''
# suffix = '\', 0, Entities.FindByName(null, "red"), Entities.FindByName(null, "red"));echo NEWLINE'
prefix = ''
suffix = ''
quoteovverride = '\\"'
scripttag = "script_client"


# read the file inside of currentdir/temp named scriptdata.nut 
import os
from traceback import print_last
os.chdir(os.path.dirname(os.path.realpath(__file__)))
os.chdir(os.getcwd()+"/Temp")
f = open("scriptdata.nut", "r")
data = f.readlines()
f.close()
print("Compacting scriptdata.nut")
print("")

# go through each line and remove all the comments that start with //
newline = "" + prefix + scripttag + " "
for line in data:

    # find if there is a // in the line
    if "//" in line:
        # if there is, remove the comment
        line = line.split("//")[0]
    # remove the \n at the end of the line
    line = line.rstrip()
    # replace multiple tabs with one tab
    looptime = 0
    while(looptime < len(line)):
        line = line.replace("\t\t", "\t")
        looptime += 1
    # replace tabs with spaces
    line = line.replace("\t", " ")
    #replace multiple spaces with one space
    looptime = 0
    while(looptime < len(line)):
        line = line.replace("  ", " ")
        looptime += 1

    # if the line is not empty, add it to the newline
    if line.strip() != "":

        # if this line starts with a } or a ] or a ) then remove the ,
        if line[0] == "}" or line[0] == "]" or line[0] == ")":
            newline = newline[:-1]


        # if the line does not end with a {, or a }, add a ,
        if line[-1] != "{" and line[-1] != "}":
            # go theough every character in newline backwards and find the nearest }
            print("$$$$")
            print(line)
            print("$$$$")
            cbracket = False
            obracket = False
            looptime = len(newline) - 1
            while(looptime > 0):
                if newline[looptime] == "}":
                    cbracket = True
                    break
                elif newline[looptime] == "{":
                    obracket = True
                    break
                looptime -= 1
            
            if obracket == True:
                newline = newline + line + ","
            elif cbracket == True:
                # if the last character in newline is a }, then add a "; echo NEWLINE" at the beginning of the line
                if newline[-1] == "}":
                    newline = newline + ";echo NEWLINE;" + scripttag + " " + line + ";echo NEWLINE;" + scripttag + " "
                else:
                    newline = newline + line + ";echo NEWLINE;" + scripttag + " "
            # if crbracket and obracket are both false
            if cbracket == False:
                if obracket == False:
                    newline = newline + line + ";echo NEWLINE;" + scripttag + " "
        else:
            # remove all \n at the end of the line
            print("=======")
            print(newline.strip()[-1])
            print("=======")
            # if the last character in newline is a } then add a ;
            newline = newline + line
        print(newline)

#replace every quote in newline with the quoteovverride
newline = newline.replace('"', quoteovverride)
newline = newline + suffix
print("")
print("Compacting scriptdata.nut done")
print("")
print("[==============================]")
print(newline)