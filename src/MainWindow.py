from cmath import rect
from locale import getlocale
import sys
import os
import random
import asyncio
import threading
import time
import webbrowser

import pygame
from pygame.locals import *
import Scripts.GlobalVariables as GVars
from Scripts.BasicLogger import Log, StartLog
import Scripts.RunGame as RG
import Scripts.Configs as cfg

# populate the global variables
GVars.init()
GVars.LoadConfig()
pygame.init()
pygame.mixer.init()
gamepath = GVars.configData["portal2path"]


# change dir into the "GUI" folder
os.chdir(os.path.dirname(os.path.abspath(__file__)) + "/GUI")
cwd = os.getcwd()

blipsnd = pygame.mixer.Sound("assets/sounds/blip.wav")
blipsnd.set_volume(0.5)

pwrsnd = pygame.mixer.Sound("assets/sounds/power.wav")
pwrsnd.set_volume(0.5)

###############################################################################

fps = 60
fpsclock = pygame.time.Clock()

screen = pygame.display.set_mode((1280, 720), RESIZABLE)

running = True

###############################################################################

Floaters = []

# surf = pygame.surface.Surface([int(W / 25) + int(H / 50), int(W / 25) + int(H / 50)])
#     surf.set_colorkey((0, 0, 0))
#     surf.fill((255, 255, 255))
#     surf = pygame.transform.rotate(surf, 19)

def Floater(width, height, rot, x, y, negrot):
    surf = pygame.image.load("assets/images/button.png")
    surf = pygame.transform.scale(surf, (width, height))
    # surf.set_colorkey((0, 0, 0))
    # surf.fill((130, 130, 140))
    surf = pygame.transform.rotate(surf, 0)
    nrot = rot
    nsurf = surf
    class Floater:
        rot = nrot
        surf = nsurf
    Floater.x = x
    Floater.y = y
    Floater.negrot = negrot
    return Floater


def AddFloater(width, height, rot, x, y):
    # random bool
    negrot = random.randint(0, 1) == 1
    Floaters.append(Floater(width, height, rot, x, y, negrot))

AddFloater(50, 50, 20, 75, 75)
AddFloater(50, 50, 20, 75, 75)
AddFloater(50, 50, 20, 75, 75)
AddFloater(50, 50, 20, 75, 75)
AddFloater(50, 50, 20, 75, 75)
AddFloater(50, 50, 20, 75, 75)
AddFloater(50, 50, 20, 75, 75)
AddFloater(50, 50, 20, 75, 75)
AddFloater(50, 50, 20, 75, 75)



def gradientRect( window, left_colour, right_colour, target_rect ):
    colour_rect = pygame.Surface( ( 2, 2 ) )                                   # tiny! 2x2 bitmap
    pygame.draw.line( colour_rect, left_colour,  ( 0,0 ), ( 0,1 ) )            # left colour line
    pygame.draw.line( colour_rect, right_colour, ( 1,0 ), ( 1,1 ) )            # right colour line
    colour_rect = pygame.transform.smoothscale( colour_rect, ( target_rect.width, target_rect.height ) )  # stretch!
    window.blit( colour_rect, target_rect )  

def GetGamePath():
    folder = input("please enter the path to the game:")
    cfg.EditConfig("portal2path", folder)
    Log("saved '" + folder + "' as the game path")

def CheckForGamePath():
    # checks for the state of the mounting process
    mountState = ""
    # undefined -> the game path in the config file is either undefined or invalid
    # filesMissing -> the mod's files (ModFiles/Portal 2/install_dlc) are missing
    # true -> the mouting process completed successfully
    while mountState != True:
        mountState = RG.MountMod(gamepath)
        if mountState == "undefined":
            Log("game path is undefined/ invalid , would you like to select it?")
            GetGamePath()

        if mountState == "filesMissing":
            Log("the mod files are missing")
            return

def RunGameScript():
    CheckForGamePath()
    RG.LaunchGame(gamepath)

def UnmountScript():
    CheckForGamePath()
    RG.DeleteUnusedDlcs(gamepath)
    RG.UnpatchBinaries(gamepath)

def SelectAnimation(btn, anim):
    if anim == "pop":
        btn.curanim = "pop1"

def RunAnimation(button, anim):
    if anim == "pop1":
        if button.sizemult < 1.3:
            button.sizemult += 0.1
        else:
            button.curanim = "pop2"
    if anim == "pop2":
        if button.sizemult > 1:
            button.sizemult -= 0.1
        else:
            button.sizemult = 1
            button.curanim = ""

directorymenu = []

CurrentMenu = None
SelectedButton = None
CurrentButtonsIndex = 0

def ChangeMenu(menu):
    global CurrentMenu
    global SelectedButton
    global directorymenu
    global CurrentButtonsIndex
    CurrentButtonsIndex = 0
    directorymenu.append(CurrentMenu)
    print("changing menu to " + str(menu))
    CurrentMenu = menu
    SelectedButton = CurrentMenu[0]


############ BUTTON CLASSES

class ManualButton:
    text = "MANUAL"
    activecolor = (255, 255, 0)
    inactivecolor = (255, 255, 255)
    sizemult = 1
    selectanim = "pop"
    selectsnd = pwrsnd
    hoversnd = blipsnd
    curanim = ""
    def function():
        ChangeMenu(ManualButtons)
    isasync = False

class BackButton:
    text = "BACK"
    activecolor = (255, 255, 0)
    inactivecolor = (255, 255, 255)
    sizemult = 1
    selectanim = "pop"
    selectsnd = pwrsnd
    hoversnd = blipsnd
    curanim = ""
    def function():
        ChangeMenu(directorymenu[-1])
        directorymenu.pop()
        CurrentButtonsIndex = 0
    isasync = False

class RunButton:
    text = "MOUNT"
    activecolor = (50, 255, 120)
    inactivecolor = (255, 255, 255)
    sizemult = 1
    selectanim = "pop"
    selectsnd = pwrsnd
    hoversnd = blipsnd
    curanim = ""
    function = RunGameScript
    isasync = True

class StopButton:
    text = "UNMOUNT"
    activecolor = (255, 50, 50)
    inactivecolor = (255, 255, 255)
    sizemult = 1
    selectanim = "pop"
    selectsnd = pwrsnd
    hoversnd = blipsnd
    curanim = ""
    function = UnmountScript
    isasync = True

class LaunchGameButton:
    text = "START GAME"
    activecolor = (50, 255, 120)
    inactivecolor = (255, 255, 255)
    sizemult = 1
    selectanim = "pop"
    selectsnd = pwrsnd
    hoversnd = blipsnd
    curanim = ""
    function = RunGameScript
    isasync = True

class GuideButton:
    text = "GUIDE"
    activecolor = (255, 255, 0)
    inactivecolor = (255, 255, 255)
    sizemult = 1
    selectanim = "pop"
    selectsnd = pwrsnd
    hoversnd = blipsnd
    curanim = ""
    def function():
        # open https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280 in the default browser
        webbrowser.open("https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280")
    isasync = True

class DiscordButton:
    text = "DISCORD"
    activecolor = (75, 75, 150)
    inactivecolor = (255, 255, 255)
    sizemult = 1
    selectanim = "pop"
    selectsnd = pwrsnd
    hoversnd = blipsnd
    curanim = ""
    def function():
        # open https://discord.com/invite/kW3nG6GKpF in the default browser
        webbrowser.open("https://discord.com/invite/kW3nG6GKpF")
    isasync = True

##############################

### BUTTONS
ManualButtons = [RunButton, StopButton, BackButton]

MainButtons = [LaunchGameButton, ManualButton, GuideButton, DiscordButton]
###########

CurrentMenu = MainButtons

CurrentButtonsIndex = 0

SelectedButton = CurrentMenu[CurrentButtonsIndex]

###############################################################################

def Update():
    W = screen.get_width()
    H = screen.get_height()

    
    for floater in Floaters:
        surf = floater.surf
        surf = pygame.transform.scale(surf, (W/15, W/15))
        surf = pygame.transform.rotate(surf, floater.rot)
        center = surf.get_rect().center
        screen.blit(surf, (floater.x - center[0], floater.y - center[1]))
        if floater.negrot:
            floater.rot -= (1 + random.randint(0, 2))
        else:
            floater.rot += (1 + random.randint(0, 2))
        floater.y += H / 60
        if floater.y > (H + floater.surf.get_height() * 2):
            floater.y = (floater.surf.get_height() * -2) + (random.randint(0, H * 2)) * -1
            floater.x = random.randint(0, W)
            floater.negrot = random.randint(0, 1) == 1


    # Put assets/images/keys.png on the top right corner of the screen
    keys = pygame.image.load("assets/images/keys.png")
    keys = pygame.transform.scale(keys, (W/10, W/10))
    screen.blit(keys, ((W / 1.05) - keys.get_width(), H/15))

    # loop through all buttons
    indx = 0
    for button in CurrentMenu:
        indx += 1
        clr = (0, 0, 0)
        if button == SelectedButton:
            clr = button.activecolor
        else:
            clr = button.inactivecolor
        RunAnimation(button, button.curanim)
        text1 = pygame.font.Font("assets/fonts/pixel.ttf", int(int((int(W / 25) + int(H / 50)) / 1.5) * button.sizemult)).render(button.text, True, clr)
        screen.blit(text1, (W / 16, (H / 2 - (text1.get_height() / 2)) * (indx / 5)  ))

    # Start Button
    # clr = (0, 0, 0)
    # if RunButton == SelectedButton:
    #     clr = RunButton.activecolor
    # else:
    #     clr = RunButton.inactivecolor
    # RunAnimation(RunButton, RunButton.curanim)
    # text1 = pygame.font.Font("assets/fonts/pixel.ttf", int(int((int(W / 25) + int(H / 50)) / 1.5) * RunButton.sizemult)).render(RunButton.text, True, clr)
    # screen.blit(text1, (W / 16, H / 2 - (text1.get_height() / 2)))
    # # Stop Button
    # clr = (0, 0, 0)
    # if StopButton == SelectedButton:
    #     clr = StopButton.activecolor
    # else:
    #     clr = StopButton.inactivecolor
    # RunAnimation(StopButton, StopButton.curanim)
    # text2 = pygame.font.Font("assets/fonts/pixel.ttf", int(int((int(W / 25) + int(H / 50)) / 1.5) * StopButton.sizemult)).render(StopButton.text, True, clr)
    # screen.blit(text2, (W / 16, H / 2 - (text2.get_height() / 2) + text1.get_height() + int(H / 50)))

###############################################################################

def Main():
    global running
    global screen
    global fps
    global SelectedButton
    global CurrentButtonsIndex

    while running:
        for event in pygame.event.get():
            if event.type == QUIT:
                running = False
            elif event.type == KEYDOWN:
                if event.key == K_ESCAPE:
                    running = False
                elif event.key == K_DOWN:
                    if CurrentButtonsIndex < len(CurrentMenu) - 1:
                        CurrentButtonsIndex += 1
                        SelectedButton = CurrentMenu[CurrentButtonsIndex]
                        pygame.mixer.Sound.play(SelectedButton.hoversnd)
                elif event.key == K_UP:
                    if CurrentButtonsIndex > 0:
                        CurrentButtonsIndex -= 1
                        SelectedButton = CurrentMenu[CurrentButtonsIndex]
                        pygame.mixer.Sound.play(SelectedButton.hoversnd)
                elif event.key == K_SPACE:
                    if SelectedButton.function:
                        if SelectedButton.isasync:
                            threading.Thread(target=SelectedButton.function).start()
                        else:
                            SelectedButton.function()

                    SelectAnimation(SelectedButton, SelectedButton.selectanim)

                    pygame.mixer.Sound.play(SelectedButton.selectsnd) 

        
        # make the screen a gradient
        screen.fill((0, 0, 0))
        gradientRect( screen, (0, 2, 10), (2, 2, 10), pygame.Rect( 0, 0, screen.get_width(), screen.get_height() ) )
        Update()
        pygame.display.update()
        fpsclock.tick(fps)

    pygame.quit()
    sys.exit()

Main()