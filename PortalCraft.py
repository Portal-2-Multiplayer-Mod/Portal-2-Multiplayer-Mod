import os

# set current directory to the directory of the script
os.chdir(os.path.dirname(os.path.realpath(__file__)))

LastNum = 0.0




def GetValue(str):
        return str[str.find("=")+1:]

def GetVarName(str):
    return str[:str.find("=")]



# make a loop
while True:
    try:
        # open the file in "/home/kyle/aServer/outputdata.p2dat"
        f = open("/home/kyle/aServer/outputdata.p2dat", "r")
        # read the file
        data = f.readlines()
        # close the file
        f.close()

        # get the top line
        top = data[0]
        # remove all the new lines
        top = top.replace("\n", "")
        # make it a float
        top = float(top)
        # if its not the same as the last time
        if top != LastNum:
            LastNum = top

            CaptureData = False
            Blocks = []
            
            # print the data
            for line in data:
                # remove all the new lines
                line = line.replace("\n", "")

                # seperate the line into a list every time there is a comma
                line = line.split(",")
                if line[0] == "block":
                    line = line[1:]
                    # make a block class
                    class Block:
                        x = 0
                        y = 0
                        z = 0
                        name = ""
                    for data in line:
                        if (GetVarName(data) == "name"):
                            Block.name = GetValue(data)
                        if (GetVarName(data) == "x"):
                            Block.x = int(GetValue(data))
                        if (GetVarName(data) == "y"):
                            Block.z = int(GetValue(data))
                        if (GetVarName(data) == "z"):
                            Block.y = int(GetValue(data))
                    
                    if (Block.name != "AIR" and Block.name != "CAVE_AIR"):
                        Blocks.append(Block)

                if line[0] == "capture":
                    line = line[1:]
                    # make a capture class
                    class Capture:
                        x = 0.0
                        y = 0.0
                        z = 0.0
                        pitch = 0.0
                        yaw = 0.0
                    for data in line:
                        if (GetVarName(data) == "x"):
                            Capture.x = float(GetValue(data))
                        if (GetVarName(data) == "y"):
                            Capture.z = float(GetValue(data))
                        if (GetVarName(data) == "z"):
                            Capture.y = float(GetValue(data))
                        if (GetVarName(data) == "pitch"):
                            Capture.pitch = float(GetValue(data))
                        if (GetVarName(data) == "yaw"):
                            Capture.yaw = float(GetValue(data))

                    CaptureData = Capture


            # print the data
            for block in Blocks:
                print(block.name + ": " + str(block.x) + " " + str(block.y) + " " + str(block.z))


            # if there is a file portal2/scripts/vscripts/portalcraft.nut delete it
            if os.path.exists("portal2/scripts/vscripts/portalcraft.nut"):
                os.remove("portal2/scripts/vscripts/portalcraft.nut")

            # open a new file in the current dir /portal2/scripts/vscripts/portalcraft.nut
            f = open("portal2/scripts/vscripts/portalcraft.nut", "w")
            # write the data to the file
            f.write("PortalCapture <- class {\n")
            f.write("   x = " + str(CaptureData.x) + "\n")
            f.write("   y = " + str(CaptureData.y) + "\n")
            f.write("   z = " + str(CaptureData.z) + "\n")
            f.write("   pitch = " + str(CaptureData.pitch) + "\n")
            f.write("   yaw = " + str(CaptureData.yaw) + "\n")
            f.write("}\n")
            f.write("\n")
            f.write("PortalBlocks <- [\n")
            for block in Blocks:
                f.write("   class {" + "\n")
                f.write("       name = \"" + block.name + "\"" + "\n")
                f.write("       x = " + str(block.x) + "\n")
                f.write("       y = " + str(block.y) + "\n")
                f.write("       z = " + str(block.z) + "\n")
                f.write("   }," + "\n")
            f.write("]")
    except:
        print("Error")
        pass
