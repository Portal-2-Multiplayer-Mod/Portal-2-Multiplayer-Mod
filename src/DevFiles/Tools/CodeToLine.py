# open /home/kyle/.local/share/Steam/steamapps/common/Portal 2/MultiplayerModFiles/MultiplayerModLauncher.pyw
import os
output = []
f = open("/home/kyle/.local/share/Steam/steamapps/common/Portal 2/MultiplayerModFiles/MultiplayerModLauncher.pyw", "r")
for line in f:
    line = line.strip()
    # replace \n with nothing
    line = line.replace("\n", "")
    output.append(line)
print(output)