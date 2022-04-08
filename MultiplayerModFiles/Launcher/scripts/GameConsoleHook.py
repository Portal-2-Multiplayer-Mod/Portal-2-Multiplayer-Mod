# imports
import os
import random
from dhooks import Webhook, Embed

# define variables
gamepath = "/home/kyle/common/Portal 2"
filepath = "/portal2/console.log"
path = gamepath + filepath

prefix = "ᴘᴏʀᴛᴀʟᴘʏᴛʜᴏɴɪɴᴘᴜᴛ╠═╣" # required!
suffix = "╠═╣" # required!

Portal2InputNumber = 0

key = 'https://discord.com/api/webhooks/961887529810923541/v-o3XiwLmOLXej0-5wJqol14npNz06IVsUJqQ_1oPbp_FZkZD_udB1KpGnVDa4_rRUkX'

hook = Webhook(key)

links = [
    "https://cdn.discordapp.com/attachments/958242420313698344/958278365331222528/left_4_dead.mp4",
    "https://cdn.discordapp.com/attachments/958242420313698344/958278685281103932/redditsave.com_reggie_irl-gykb5a2o00m812.mp4",
    "https://cdn.discordapp.com/attachments/958242420313698344/958278800708345876/redditsave.com_rule-kpfm3g5vykg81.mp4",
    "https://cdn.discordapp.com/attachments/958242420313698344/958278921198141440/video041.mp4",
    "https://cdn.discordapp.com/attachments/958242420313698344/958278921198141440/video041.mp4",
    "https://cdn.discordapp.com/attachments/958242420313698344/958279151477981254/video0.mp4",
    "https://cdn.discordapp.com/attachments/958242420313698344/958279215583723550/IMG_4209.mp4",
    "https://cdn.discordapp.com/attachments/958242420313698344/958279322509135872/99.mov",
    "https://cdn.discordapp.com/attachments/958242420313698344/958279365102272522/redditsave.com_le_methe-qi4lsfjupb071.mp4",
    "https://cdn.discordapp.com/attachments/958242420313698344/958279409788420116/Crab_boogie1.mp4",
    "https://cdn.discordapp.com/attachments/958242420313698344/958279479699075102/NoBitches.mp4",
    "https://cdn.discordapp.com/attachments/958242420313698344/958279479699075102/NoBitches.mp4",
    "https://cdn.discordapp.com/attachments/958242420313698344/958279557033623642/no_damsels.mp4",
    "https://cdn.discordapp.com/attachments/958242420313698344/958279617800712242/trim.BCD7CCC3-1DF4-447B-85FF-27E7C53B74CF.mov",
    "https://cdn.discordapp.com/attachments/958242420313698344/958279696167075870/video06.mp4",
    "https://cdn.discordapp.com/attachments/844275121950687232/941408792904597604/video0-205.mov",
    "https://cdn.discordapp.com/attachments/844275121950687232/941408472027791432/fall_guys.mp4",
    "https://cdn.discordapp.com/attachments/858082675464863764/937429700509331456/redditsave.com_her_ps5_or_pc-9zph4n92cve81.mp4",
    "https://cdn.discordapp.com/attachments/844275121950687232/958297431290822716/Logging_into_discord_be_like.mp4",
    "https://cdn.discordapp.com/attachments/844275121950687232/958297431290822716/Logging_into_discord_be_like.mp4",
    "https://cdn.discordapp.com/attachments/844275121950687232/958161162418139196/video1.mov",
    "https://cdn.discordapp.com/attachments/839651381383397378/959406612605456394/youtube_tutorials_be_like.mp4",
    "https://cdn.discordapp.com/attachments/839651381383397378/959406749767577610/french.mp4",
    "https://cdn.discordapp.com/attachments/839651381383397378/959407122813173810/234238622_361815072183954_4327328764559183360_n.mp4",
    "https://cdn.discordapp.com/attachments/439519668819066880/959285762317250611/I_am_no_longer_racist.mp4",
    "https://cdn.discordapp.com/attachments/311176612341088258/959072455564075058/y.mp4",
    "https://cdn.discordapp.com/attachments/782174973074604052/959172812411662366/mhng.mp4",
    "https://cdn.discordapp.com/attachments/407955661016793088/958912106147754004/0c0ad448cae4189f9e8ced06cd8db7b5.mov",
    "https://cdn.discordapp.com/attachments/607866069767684096/958516788373618688/ugb9mJS77iH6v49B.mp4",
    "https://cdn.discordapp.com/attachments/835922432790626314/957288049325260810/trim.D4FB7751-4071-4CCC-8B85-90CD52963020.mov",
    "https://cdn.discordapp.com/attachments/547851758668611634/947086989218414602/senator_armstrong_sons_of_your_mom.mp4",
    "https://cdn.discordapp.com/attachments/824184319391956993/931809744912515142/ssstiktok_1642231149.mp4",
    "https://cdn.discordapp.com/attachments/693229671407681537/928460648252338297/redditsave.com_bones-ojisk0kafb981.mp4",
    "https://cdn.discordapp.com/attachments/878044914770907156/929459944858742834/939a46845c4e03d2cae12cb9fd60b6fe.mp4",
    "https://cdn.discordapp.com/attachments/649230397569368064/908454259392147496/redditsave.com_betrayal-k6v7agxd5uw71.mp4",
    "https://cdn.discordapp.com/attachments/429143634072305675/899788628937556058/video0-2-3-1.mp4"
]

# define functions
def FetchData():
    with open(path, "r") as file:
        data = file.readlines()
    return data

def ClearFile():
    newdata = FetchData()
    for index, line in enumerate(newdata):
        # if it doesnt have the prefix, delete it
        if not prefix in line:
            newdata.pop(index)

    # join the list into a string with newlines
    newdata = "".join(newdata)

    with open(path, "w") as file:
        file.write(newdata)

def ResetFile():
    with open(path, "w") as file:
        file.write("")
    print("__File reset__")

def SendHook(message):
    print("__Sending hook__")
    print(message)
    hook.send(message)

def ProcessData(data):
    global Portal2InputNumber

    commands = []

    for line in data:
        if prefix in line:
            # remove the newline character
            line = line.replace("\n", "")
            # delete the prefix
            line = line.replace(prefix, "")
            # read everything before the suffix
            number = line.split(suffix)[0]
            # check for the reset char
            if number == "reset":
                Portal2InputNumber = 0
                ResetFile()
                return commands
            else:
                number = int(number)
            # delete the suffix and everything before it
            line = line.split(suffix)[1]

            if number > Portal2InputNumber:
                # set the global variable
                Portal2InputNumber = number
                print("Portal2InputNumber: " + str(Portal2InputNumber))
                commands.append(line)
        
    return commands

def RunCommands(commands):
    for command in commands:
        print(command)
        if (command.startswith("hookdiscord")):
            command = command.replace("hookdiscord", "")
            SendHook(command)

# main
ResetFile()

while True:
    data = FetchData()
    commands = ProcessData(data)
    RunCommands(commands)
    if len(commands) > 0:
        ClearFile()