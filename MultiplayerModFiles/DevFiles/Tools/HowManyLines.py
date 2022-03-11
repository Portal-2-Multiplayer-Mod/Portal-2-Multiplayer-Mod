import os
# set the current directory to the directory of this file
os.chdir(os.path.dirname(os.path.realpath(__file__)))
# go back 3 directories
os.chdir("../../")

lineamt = 0

# go through every file in every directory
for root, dirs, files in os.walk("."):
    # go through every file in the current directory
    for file in files:
        if file.endswith(".nut") or file.endswith(".py"):
            try:
                amtthistime = lineamt
                print(file)
                with open(os.path.join(root, file), "r") as f:
                    lines = f.readlines()
                    for line in lines:
                        # strip the start and end of the line
                        line = line.strip()
                        # if the line starts with "//"
                        if line.startswith("//"):
                            # skip the line
                            #pass
                            continue
                        # if the line starts with "#"
                        elif line.startswith("#"):
                            # skip the line
                            #pass
                            continue

                        lineamt += 1

                    
                print(lineamt - amtthistime)
            except:
                pass

print(lineamt)