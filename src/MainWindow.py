from cmath import rect
import sys
import os
import random

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
gamepath = GVars.configData["portal2path"]


# change dir into the "GUI" folder
os.chdir(os.path.dirname(os.path.abspath(__file__)) + "/GUI")
cwd = os.getcwd()


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
        print(mountState)
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

class RunButton:
    text = "MOUNT"
    activecolor = (50, 255, 120)
    inactivecolor = (255, 255, 255)
    function = RunGameScript
class StopButton:
    text = "UNMOUNT"
    activecolor = (255, 50, 50)
    inactivecolor = (255, 255, 255)
    function = False

RunButton.below = StopButton
RunButton.above = False

StopButton.below = False
StopButton.above = RunButton

SelectedButton = RunButton

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

    # Start Button
    clr = (0, 0, 0)
    if RunButton == SelectedButton:
        clr = RunButton.activecolor
    else:
        clr = RunButton.inactivecolor
    text1 = pygame.font.Font("assets/fonts/pixel.ttf", int((int(W / 25) + int(H / 50)) / 1.5)).render(RunButton.text, True, clr)
    screen.blit(text1, (W / 16, H / 2 - (text1.get_height() / 2)))
    # Stop Button
    clr = (0, 0, 0)
    if StopButton == SelectedButton:
        clr = StopButton.activecolor
    else:
        clr = StopButton.inactivecolor
    text2 = pygame.font.Font("assets/fonts/pixel.ttf", int((int(W / 25) + int(H / 50)) / 1.5)).render(StopButton.text, True, clr)
    screen.blit(text2, (W / 16, H / 2 - (text2.get_height() / 2) + text1.get_height() + int(H / 50)))

###############################################################################

def Main():
    global running
    global screen
    global fps
    global SelectedButton

    while running:
        for event in pygame.event.get():
            if event.type == QUIT:
                running = False
            elif event.type == KEYDOWN:
                if event.key == K_ESCAPE:
                    running = False
                elif event.key == K_DOWN:
                    if SelectedButton.below:
                        SelectedButton = SelectedButton.below
                elif event.key == K_UP:
                    if SelectedButton.above:
                        SelectedButton = SelectedButton.above
                elif event.key == K_RETURN:
                    if SelectedButton.function:
                        SelectedButton.function()
                    


        
        # make the screen a gradient
        screen.fill((0, 0, 0))
        gradientRect( screen, (0, 2, 10), (2, 2, 10), pygame.Rect( 0, 0, screen.get_width(), screen.get_height() ) )
        Update()
        pygame.display.update()
        fpsclock.tick(fps)

    pygame.quit()
    sys.exit()

Main()