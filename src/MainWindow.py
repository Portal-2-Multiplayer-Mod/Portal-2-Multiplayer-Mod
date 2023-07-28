import json
import os
import random
import subprocess
import sys
import threading
import time
import webbrowser
from inspect import _void
import traceback

import __main__
import pygame
import pyperclip
from pygame.locals import *
from steamid_converter import Converter

import Scripts.BasicFunctions as BF
import Scripts.Configs as CFG
import Scripts.GlobalVariables as GVars
import Scripts.RunGame as RG
import Scripts.Updater as UP
import Scripts.Workshop as Workshop
from Scripts.BasicLogger import Log, StartLog

# set current directory to the directory of this file
os.chdir(os.path.dirname(os.path.abspath(__file__)))


class Gui:
    def __init__(self, devMode: bool) -> None:
        pygame.mixer.pre_init(channels=1)
        pygame.init()
        pygame.mixer.init()

        self.HoverSound = pygame.mixer.Sound("GUI/sounds/hoverSound.wav")
        self.HoverSound.set_volume(0.05)

        #! public variables
        self.coolDown: int = 0
        self.CurInput: str = ""
        self.ERRORLIST: list = []
        self.InputPrompt: list = []
        self.SDShift = False
        self.PromptBreaks: int = 0
        self.HasBreaks: bool = False
        self.PlayersMenu: list = []
        self.DirectoryMenu: list = []
        self.DirectoryMenuText: list = []
        self.PopupBoxList: list = []
        self.LanguagesMenu: list = []
        self.IsUpdating: bool = False
        self.AfterInputFunction = None
        self.SettingsButtons: list = []
        self.SecAgo: float = time.time()
        self.SelectedPopupButton: self.ButtonModel
        self.LookingForInput: bool = False
        self.CurrentSelectedPlayer: int = 0
        self.Floaters: list[self.Floater] = []

    ###############################################################################
        # The resolution of the launcher when it opens.
        # Why the height is 800 is to accommodate the Steam Decks resolution if launching the launcher in Gaming Mode
        self.screen = pygame.display.set_mode((1280, 800), RESIZABLE)
        self.Clock = pygame.time.Clock()
        self.devMode: bool = devMode
        self.running: bool = True
        self.FPS: int = 60
        self.currentVersion: str = "2.2.0"

        # Define the name and image of the window
        pygame.display.set_caption('Portal 2: Multiplayer Mod Launcher')
        self.P2mmLogo = pygame.image.load(
            "GUI/images/p2mm64.ico").convert_alpha()
        pygame.display.set_icon(self.P2mmLogo)

        # The cube floaters for the launcher screen
        self.GreenCube = pygame.image.load(
            "GUI/images/greenCube.png").convert_alpha()
        self.RedCube = pygame.image.load(
            "GUI/images/redCube.png").convert_alpha()
        self.GoldenCube = pygame.image.load(
            "GUI/images/yellowCube.png").convert_alpha()

        ###############################################################################

        self.DefineMainMenu()
        self.DefineSettingsMenu()
        self.DefineBlankMenu()
        self.DefineWorkshopMenu()
        self.DefineManualMountingMenu()
        self.DefineResourcesMenu()
        self.DefineTestingMenu()

        self.CurrentButtonsIndex: int = 0
        self.CurrentMenuTextIndex: int = 0
        self.CurrentMenuButtons: list = self.MainMenuButtons
        self.CurrentMenuText: list = self.MainMenuText
        self.SelectedButton: self.ButtonModel = self.CurrentMenuButtons[self.CurrentButtonsIndex]

        # Add the cubes onto the launcher screen
        for i in range(9):
            self.AddFloater(50, 50, 20, 75, 75)

    def PlaySound(self, sound: pygame.mixer.Sound) -> None:
        """Plays the launcher's sounds when hovering / clicking on a button
        Args:
            sound (pygame.mixer.Sound): the sound to play
        """

        LauncherSFX = GVars.configData["Launcher-SFX"]["value"]
        if LauncherSFX:
            pygame.mixer.Sound.play(sound)

    class Floater:
        def __init__(self, rot: float, surf: pygame.Surface, x: float, y: float, negativeRotation: bool) -> None:
            self.rot: float = rot
            self.surf: pygame.Surface = surf
            self.x: float = x
            self.y: float = y
            self.NegativeRotation: bool = negativeRotation

    def AddFloater(self, width: float, height: float, rot: float, x: float, y: float) -> None:
        """creates the falling cubes and adds them to a list of floaters

        Args:
            width (float): the width of the cube's image
            height (float): the height of the cube's image
            rot (float): the rotation of the cube on the z axis when it spawns
            x (float): the x position where it first spawns
            y (float): the y position where it first spawns
        """
        surf = self.GreenCube
        surf = pygame.transform.scale(surf, (width, height))
        surf = pygame.transform.rotate(surf, 0)

        negativeRotation = random.randint(0, 1) == 1

        floater = self.Floater(rot, surf, x, y, negativeRotation)

        self.Floaters.append(floater)

    class DisplayText:
        def __init__(self,
                     text: str,  # The text you want to display
                     # The color you want the text displayed to be in RGB format
                     textColor: tuple = (155, 155, 155),
                     # The bigger the number, the more right the text will be.
                     xPos: float = 0,
                     # The bigger the number, the lower the text will be.
                     yPos: float = 0,
                     # Where the next line for the line will begin, normally this should be equal to xPos
                     xStart: float = 0,
                     xEnd: float = 100,  # Where the line of text will end and start the next one at xStart
                     # The bigger the number, the smaller it is, because that definitely makes sense
                     size: float = 100
                     ) -> None:

            self.text = text
            self.textColor = textColor
            self.xPos = xPos
            self.xStart = xStart
            self.xEnd = xEnd
            self.yPos = yPos
            self.size = size

    class ButtonModel:

        def __init__(self,
                     text: str,  # The text for the button
                     func=_void,  # What the button will do when the user clicks it
                     # The color of the button when the user hovers the cursor over it
                     activeColor: tuple = (255, 255, 0),
                     # The color that the button will be when the user doesn't hover over it
                     inactiveColor: tuple = (155, 155, 155),
                     sizeMultiplier: float = 1,
                     clickAnimation: str = "pop",  # The sound that is played when it is hovered over
                     currentAnimation: str = "",
                     isAsync: bool = False,
                     # The small the number, the more the text moves right.
                     xPos: float = 16,
                     # The bigger the number, the more the text moves up.
                     yPos: float = 2,
                     x: float = 16,  # A duct tape fix to prevent errors with mouse movement detection
                     y: float = 2,  # A duct tape fix to prevent errors with mouse movement detection
                     width: float = 28,  # A duct tape fix to prevent errors with mouse movement detection
                     height: float = 14,  # A duct tape fix to prevent errors with mouse movement detection
                     # Size "700" appears to be default size. Increasing over "7500" will start to make the launcher unstable.
                     size: float = 700,
                     ) -> None:

            self.text = text
            self.function = func
            self.ActiveColor = activeColor
            self.InactiveColor = inactiveColor
            self.sizeMultiplier = sizeMultiplier
            self.ClickAnimation = clickAnimation
            self.CurrentAnimation = currentAnimation
            self.isAsync = isAsync

            self.ClickSound = pygame.mixer.Sound("GUI/sounds/click.wav")
            self.ClickSound.set_volume(0.25)
            self.HoverSound = pygame.mixer.Sound("GUI/sounds/blip.wav")
            self.HoverSound.set_volume(0.25)

            self.xPos = xPos
            self.yPos = yPos
            self.x = x
            self.y = y
            self.width = width
            self.height = height
            self.size = size

    #!############################
    #! Declaring buttons
    #!############################

    def DefineMainMenu(self) -> None:
        self.Button_LaunchGame = self.ButtonModel(
            translations["play_button"], self.Button_LaunchGame_func, (50, 255, 120), isAsync=True)
        self.Button_Settings = self.ButtonModel(
            translations["settings_button"], self.Button_Settings_func)
        self.Button_Update = self.ButtonModel(
            translations["update_button"], self.Button_Update_func, (255, 0, 255), isAsync=True)
        self.Button_ManualMode = self.ButtonModel(
            translations["manual_mounting_button"], self.Button_ManualMode_func)
        self.Button_Workshop = self.ButtonModel(
            translations["workshop_button"], self.Button_Workshop_func, (14, 216, 235))
        self.Button_ResourcesMenu = self.ButtonModel(
            translations["resources_button"], self.Button_ResourcesMenu_func, (75, 0, 255))
        self.Button_Exit = self.ButtonModel(
            translations["exit_button"], self.Button_Exit_func, (255, 50, 50), isAsync=True, clickAnimation="none")
        self.Text_MainMenuText = self.DisplayText(translations["welcome"], textColor=(
            255, 234, 0), xPos=790, xStart=790, xEnd=1850, yPos=20, size=80)
        self.Text_LauncherVersionText = self.DisplayText(
            translations["version"] + self.currentVersion, textColor=(255, 234, 0), xPos=75, xStart=75, xEnd=750, yPos=770)

        # The DisplayText class needs a separate table for displaying nonfunctional text
        self.MainMenuText = [self.Text_MainMenuText,
                             self.Text_LauncherVersionText]
        self.MainMenuButtons = [self.Button_LaunchGame, self.Button_Settings, self.Button_Update,
                                self.Button_ManualMode, self.Button_Workshop, self.Button_ResourcesMenu]

        if self.devMode:
            self.Button_Test = self.ButtonModel(
                "Test Button", self.Button_Test_func)
            self.Text_DevMode = self.DisplayText(translations["dev_mode_enabled"], textColor=(
                255, 0, 0), xPos=75, xStart=75, xEnd=750, yPos=735)
            self.MainMenuButtons.append(self.Button_Test)
            self.MainMenuText.append(self.Text_DevMode)

        self.MainMenuButtons.append(self.Button_Exit)
        # We don't need the back button in the main menu but I thought it will be better the declare it here -Cabiste
        self.Button_Back = self.ButtonModel(
            translations["back_button"], self.Button_Back_func)

    def DefineSettingsMenu(self) -> None:
        self.Button_LauncherSettingsMenu = self.ButtonModel(
            translations["launcher_settings_button"], self.Button_LauncherSettingsMenu_func)
        self.Button_Portal2Settings = self.ButtonModel(
            translations["portal2_config_button"], self.Button_Portal2Settings_func)
        self.Button_AdminsMenu = self.ButtonModel(
            translations["player_button"], self.Button_AdminsMenu_func, (0, 255, 255))
        self.Button_LanguageMenu = self.ButtonModel(
            translations["languages_button"], self.Button_LanguageMenu_func, (175, 75, 0))
        self.Text_SettingsLaunchText = self.DisplayText(
            translations["language_menu_launch_text"], textColor=(255, 234, 0), xPos=40, xStart=40, xEnd=1000, yPos=540, size=75)
        self.Text_SettingsPortal2Text = self.DisplayText(
            translations["language_menu_portal2_text"], textColor=(255, 234, 0), xPos=40, xStart=40, xEnd=1000, yPos=620, size=75)
        self.Text_SettingsPlayersText = self.DisplayText(
            translations["language_menu_players_text"], textColor=(255, 234, 0), xPos=40, xStart=40, xEnd=1000, yPos=700, size=75)

        self.SettingsMenus = [self.Button_LauncherSettingsMenu, self.Button_Portal2Settings,
                              self.Button_AdminsMenu, self.Button_LanguageMenu]
        self.SettingsMenuText = [self.Text_SettingsLaunchText, self.Text_SettingsPortal2Text,
                                 self.Text_SettingsPlayersText]

        if self.devMode:
            self.Button_HiddenSettings = self.ButtonModel(
                translations["dev_settings_button"], self.Button_DevSettings_func)
            self.SettingsMenus.append(self.Button_HiddenSettings)

        self.SettingsMenus.append(self.Button_Back)

    def DefineBlankMenu(self) -> None:
        self.Button_BlankButton = self.ButtonModel("", yPos=8)

        self.BlankButton = [self.Button_BlankButton]

    def DefineWorkshopMenu(self) -> None:
        self.Button_GetWorkShopCommand = self.ButtonModel(
            translations["get_level_button"], self.Button_GetWorkShopCommand_func)
        self.Text_WorkshopMenuInfo = self.DisplayText(
            translations["workshop_menu_info"],
            textColor=(255, 234, 0),
            xPos=75, xStart=75, xEnd=1100, yPos=220, size=70)

        self.WorkshopMenuText = [self.Text_WorkshopMenuInfo]
        self.WorkshopButtons = [
            self.Button_GetWorkShopCommand, self.Button_Back]

    def DefineManualMountingMenu(self) -> None:
        self.Button_ManualMount = self.ButtonModel(
            translations["mount_button"], self.Button_ManualMount_func, (50, 255, 120), isAsync=True)
        self.Button_ManualUnmount = self.ButtonModel(
            translations["unmount_button"], self.Button_ManualUnmount_func, (255, 50, 50), isAsync=True)

        self.ManualButtons = [self.Button_ManualMount,
                              self.Button_ManualUnmount, self.Button_Back]

    def DefineResourcesMenu(self) -> None:
        self.Button_GitHub = self.ButtonModel(
            translations["github_button"], self.Button_GitHub_func, (255, 255, 255), isAsync=True)
        self.Button_Guide = self.ButtonModel(
            translations["guide_button"], self.Button_Guide_func, (35, 35, 50), isAsync=True)
        self.Button_Discord = self.ButtonModel(
            translations["discord_server_button"], self.Button_Discord_func, (75, 75, 150), isAsync=True)

        self.ResourcesButtons = [
            self.Button_GitHub, self.Button_Guide, self.Button_Discord, self.Button_Back]

    def DefineTestingMenu(self) -> None:
        self.Button_InputField = self.ButtonModel(
            "User Input", self.Button_InputField_func)
        self.PopupBox_Gui = self.ButtonModel(
            "Popup Box", self.PopupBox_test_func)
        self.Button_PrintToConsole = self.ButtonModel(
            "Print to Console", self.Button_PrintToConsole_func)
        self.Button_Back = self.ButtonModel(
            translations["back_button"], self.Button_Back_func)

        self.Text_TestMenuTextTest1 = self.DisplayText(
            "DisplayText: All default settings")
        self.Text_TestMenuTextTest2 = self.DisplayText(
            "DisplayText2: textColor=(52, 67, 235), yPos=600", textColor=(52, 67, 235), yPos=600)
        self.Text_TestMenuTextTest3 = self.DisplayText(
            "DisplayText3: textColor=(214, 30, 17), xPos=600, xStart=600", textColor=(214, 30, 17), xPos=600, xStart=600)
        self.Text_TestMenuTextTest4 = self.DisplayText(
            "DisplayText4: textColor=(143, 222, 24), xPos=600, xStart=600, yPos=600", textColor=(143, 222, 24), xPos=600, xStart=600, yPos=600)
        self.Text_TestMenuTextTest5 = self.DisplayText(
            "DisplayText5: textColor=(255, 255, 0), xPos=600, xStart=600, xEnd=1900, yPos=300", textColor=(255, 255, 0), xPos=600, xStart=600, xEnd=1900, yPos=300)

        self.TestMenuText = [self.Text_TestMenuTextTest1, self.Text_TestMenuTextTest2,
                             self.Text_TestMenuTextTest3, self.Text_TestMenuTextTest4,
                             self.Text_TestMenuTextTest5]
        self.TestMenu = [self.Button_InputField, self.PopupBox_Gui,
                         self.Button_PrintToConsole, self.Button_Back]

#######################################################################

    def gradientRect(self, window: pygame.Surface, leftColor: tuple, rightColor: tuple, targetRectangle: pygame.Rect) -> None:
        color_rect = pygame.Surface((2, 2))  # tiny! 2x2 bitmap
        pygame.draw.line(color_rect, leftColor, (0, 0),
                         (0, 1))  # left color line
        pygame.draw.line(color_rect, rightColor, (1, 0),
                         (1, 1))  # right color line
        color_rect = pygame.transform.smoothscale(
            color_rect, (targetRectangle.width, targetRectangle.height))  # stretch!
        window.blit(color_rect, targetRectangle)

    def BackMenu(self) -> None:
        if len(self.DirectoryMenu) > 0:
            self.ChangeMenu(self.DirectoryMenu.pop(),
                            self.DirectoryMenuText.pop(), False)

    # the button to go to the previous menu
    def Button_Back_func(self) -> None:
        self.BackMenu()

    class ConfigButtonModel:

        def __init__(self, key: str, outerSelf, menu) -> None:
            self.Menu = menu
            self.text = str(GVars.configData[key]["value"])
            maxTextLength = 10

            if len(self.text) > maxTextLength:
                self.text = self.text[:maxTextLength] + "..."

            self.text = translations[key] + ": " + self.text
            self.ConfigKey = key
            self.ConfigValue = GVars.configData[key]["value"]
            self.KeyObject = GVars.configData[key]
            self.ActiveColor = (255, 255, 0)
            self.InactiveColor = (155, 155, 155)
            self.sizeMultiplier = 1
            self.OuterSelf = outerSelf
            self.size = 700
            self.xPos = 16
            self.yPos = 2
            self.x = 16  # A duct tape fix to prevent errors with mouse movement detection
            self.y = 2  # A duct tape fix to prevent errors with mouse movement detection
            self.width = 28  # A duct tape fix to prevent errors with mouse movement detection
            self.height = 14  # A duct tape fix to prevent errors with mouse movement detection

            self.ClickAnimation = "pop"
            self.CurrentAnimation = ""
            self.ClickSound = pygame.mixer.Sound("GUI/sounds/click.wav")
            self.ClickSound.set_volume(0.25)
            self.HoverSound = pygame.mixer.Sound("GUI/sounds/blip.wav")
            self.HoverSound.set_volume(0.25)

        def Hovered(self, outerSelf) -> None:
            try:
                outerSelf.BlitDescription(
                    translations[self.KeyObject["description"]], 75, 590, (130, 130, 255))
                outerSelf.BlitDescription(
                    translations[self.KeyObject["warning"]], 75, 625, (255, 50, 50))
            # * this is not really needed and thus commented out
            except Exception as e:
                # print(str(e))
                pass

        def function(self) -> None:
            if type(self.ConfigValue) is bool:
                CFG.EditConfig(self.ConfigKey, not self.ConfigValue)

            else:
                def AfterInputGenericSetConfig(inp: str) -> None:
                    CFG.EditConfig(self.ConfigKey, inp.strip())
                    Log("Saved '" + inp.strip() +
                        "' to config " + self.ConfigKey)
                    self.OuterSelf.Error(
                        translations["error_saved"], 5, (75, 200, 75))
                    self.OuterSelf.BackMenu()

                self.OuterSelf.ChangeMenu(
                    self.OuterSelf.BlankButton, append=True)
                self.OuterSelf.GetUserInput(
                    AfterInputGenericSetConfig, translations[self.KeyObject["prompt"]], self.ConfigValue)

            self.OuterSelf.RefreshSettingsMenu(self.Menu)

        isAsync = False

    def RefreshSettingsMenu(self, menu: str) -> None:

        self.SettingsButtons.clear()

        for key in GVars.configData:
            if GVars.configData[key]["menu"] == menu:
                Log(str(key) + ": " + str(GVars.configData[key]["value"]))
                self.SettingsButtons.append(
                    self.ConfigButtonModel(key, self, menu))

        self.SettingsButtons.append(self.Button_Back)

    def RefreshPlayersMenu(self) -> None:
        CFG.ValidatePlayerKeys()

        self.PlayersMenu.clear()
        PlayerKey: dict[str,
                        str] = GVars.configData["Players"]["value"][self.CurrentSelectedPlayer]
        if GVars.configData["Dev-Mode"]["value"]:
            Log(f"Selected players key information: {PlayerKey}")

        # displays and changes the player name
        def Button_PlayerName_func() -> None:
            def AfterInputPlayerName(inp: str) -> None:
                Log("Saving player name: " + inp)
                CFG.EditPlayer(self.CurrentSelectedPlayer, name=inp.strip())
                self.Error(translations["error_saved"], 5, (75, 200, 75))
                self.RefreshPlayersMenu()
                self.BackMenu()

            self.ChangeMenu(self.BlankButton, append=True)
            self.GetUserInput(
                AfterInputPlayerName, translations["players_enter_username"], PlayerKey["name"])

        Button_PlayerName = self.ButtonModel(
            translations["players_name"] + PlayerKey["name"], Button_PlayerName_func, (255, 255, 120))

        # sets the steam id for the player
        def Button_PlayerSteamId_func() -> None:
            def AfterInputSteamID(inp: str) -> None:
                Log("Saving SteamID: " + str(inp))

                if not (inp.isdigit()):
                    try:
                        # this is only useful if the user gives a steamID2
                        inp = Converter.to_steamID3(inp.strip())
                        # replace all [] with ""
                        inp = inp.replace("[", "").replace("]", "")
                        # only get everything after the last ":"
                        inp = inp.split(":")[-1]
                        self.Error(
                            translations["players_converted_steamid"], 5, (75, 120, 255))
                    except Exception as e:
                        self.Error(
                            translations["players_invalid_steamid"], 5, (255, 50, 50))
                        Log(str(e))
                        return

                CFG.EditPlayer(self.CurrentSelectedPlayer, steamId=inp)
                self.Error(translations["error_saved"], 5, (75, 200, 75))
                self.RefreshPlayersMenu()
                self.BackMenu()

            self.ChangeMenu(self.BlankButton, append=True)
            self.GetUserInput(
                AfterInputSteamID, translations["players_enter_steamid"], PlayerKey["steamid"])

        Button_PlayerSteamId = self.ButtonModel(
            "SteamID: " + PlayerKey["steamid"], Button_PlayerSteamId_func, (255, 255, 120))

        # sets the admin level for th player
        def Button_AdminLevel_func() -> None:
            def AfterInputAdminLevel(inp: str) -> None:

                if not inp.isdigit():
                    self.Error(
                        translations["players_admin_error_not-a-number"], 5, (255, 50, 50))
                    return

                if int(inp) > 6 or int(inp) < 0:
                    self.Error(
                        translations["admin_level_error_out-of-range"], 5, (255, 255, 50))
                    return

                # here i'm converting to int then to str so it removes all the extra 0s on the left side (05 -> 5)
                CFG.EditPlayer(self.CurrentSelectedPlayer, level=str(int(inp)))
                self.Error(translations["error_saved"], 5, (75, 200, 75))
                Log("Saving admin level as " + str(inp))
                self.RefreshPlayersMenu()
                self.BackMenu()

            self.ChangeMenu(self.BlankButton, append=True)
            self.GetUserInput(
                AfterInputAdminLevel, translations["players_admin-enter-admin-level"], PlayerKey["adminLevel"])

        Button_AdminLevel = self.ButtonModel(
            translations["players_admin_level"] + PlayerKey["adminLevel"], Button_AdminLevel_func, (255, 255, 120))

        # changes the view to the next player
        def Button_NextPlayer_func() -> None:

            if self.CurrentSelectedPlayer < len(GVars.configData["Players"]["value"]) - 1:
                Log("Next player")
                self.CurrentSelectedPlayer += 1
            else:
                Log("No more players")
                self.CurrentSelectedPlayer = 0

            self.RefreshPlayersMenu()
            self.ChangeMenu(self.PlayersMenu, append=False)

        Button_NextPlayer = self.ButtonModel(
            translations["players_next_button"], Button_NextPlayer_func, (255, 255, 120))

       # adds a player to the list
        def Button_AddPlayer_func() -> None:

            Log("Adding blank player...")
            GVars.configData["Players"]["value"].append(CFG.DefaultPlayer)
            CFG.WriteConfigFile(GVars.configData)
            Log(str(len(GVars.configData["Players"]["value"]) - 1))
            self.CurrentSelectedPlayer = len(
                GVars.configData["Players"]["value"]) - 1
            self.RefreshPlayersMenu()

        Button_AddPlayer = self.ButtonModel(
            translations["players_add_player"], Button_AddPlayer_func, (120, 255, 120))

        # deletes a player from the list
        def Button_DeletePlayer_func() -> None:

            if len(GVars.configData["Players"]["value"]) <= 1:
                self.Error(
                    translations["players_error_must_be_at_least_one_player"], 5, (255, 50, 50))
                return

            Log("Deleting player...")
            CFG.DeletePlayer(self.CurrentSelectedPlayer)
            self.CurrentSelectedPlayer -= 1
            self.RefreshPlayersMenu()

        Button_DeletePlayer = self.ButtonModel(
            translations["players_remove_player"], Button_DeletePlayer_func, (255, 50, 50))

        ####################
        self.PlayersMenu.append(Button_PlayerName)
        self.PlayersMenu.append(Button_PlayerSteamId)
        self.PlayersMenu.append(Button_AdminLevel)
        self.PlayersMenu.append(Button_NextPlayer)
        self.PlayersMenu.append(Button_AddPlayer)
        self.PlayersMenu.append(Button_DeletePlayer)
        self.PlayersMenu.append(self.Button_Back)

    #!############################
    #! MAIN BUTTONS FUNCTIONS
    #!############################

    # Mounts and launches Portal 2
    def Button_LaunchGame_func(self) -> None:
        if self.coolDown > 0:
            return

        self.coolDown = int(3 * 60)
        RunGameScript()

    # Switches to the settings menu
    def Button_Settings_func(self) -> None:
        self.ChangeMenu(self.SettingsMenus, self.SettingsMenuText)

    # Checks for any updates for the launcher
    def Button_Update_func(self) -> None:
        if self.coolDown > 0:
            return

        self.coolDown = int(3 * 60)

        if not CheckForUpdates():
            self.Error(
                translations["update_already_up_to_date"], 5, (200, 75, 220))

    # Switches to the manual mod mounting and unmounting menu
    def Button_ManualMode_func(self) -> None:
        self.ChangeMenu(self.ManualButtons, append=True)

    # Switches to the workshop menu, where you can get the changelevel command for workshop maps
    def Button_Workshop_func(self) -> None:
        self.ChangeMenu(self.WorkshopButtons, self.WorkshopMenuText)

    # Switches to the resources menu, access to links to the GitHub Repo, P2MM Discord, etc
    def Button_ResourcesMenu_func(self) -> None:
        self.ChangeMenu(self.ResourcesButtons, append=True)

    # Performs a clean close of the launcher, it will close down and unmount Portal 2 if it's open
    def Button_Exit_func(self) -> None:
        self.running = False

    #!############################
    #! SETTINGS BUTTONS FUNCTIONS
    #!############################

    # Switches to the Launcher Settings
    def Button_LauncherSettingsMenu_func(self) -> None:
        self.RefreshSettingsMenu("launcher")
        self.ChangeMenu(self.SettingsButtons, append=True)

    # Switches to the Portal 2 Settings
    def Button_Portal2Settings_func(self) -> None:
        self.RefreshSettingsMenu("portal2")
        self.ChangeMenu(self.SettingsButtons, append=True)

    # Switches to the Player menu where you can add admins
    def Button_AdminsMenu_func(self) -> None:
        self.RefreshPlayersMenu()
        self.ChangeMenu(self.PlayersMenu, append=True)

    # Switches to the Language menu where you can pick a language for the launcher
    def Button_LanguageMenu_func(self) -> None:
        # for choosing a language
        self.LanguageButton()
        self.ChangeMenu(self.LanguagesMenu, append=True)

    # Access to the launchers Developer settings
    def Button_DevSettings_func(self) -> None:
        self.RefreshSettingsMenu("dev")
        self.ChangeMenu(self.SettingsButtons, append=True)

    #!############################
    #! MANUAL MODE BUTTONS FUNCTIONS
    #!############################

    # Button to manually mount P2MM
    def Button_ManualMount_func(self) -> None:
        if self.coolDown > 0:
            return

        self.coolDown = int(3 * 60)
        MountModOnly()

    # Button to manually unmount P2MM
    def Button_ManualUnmount_func(self) -> None:
        if self.coolDown > 0:
            return

        self.coolDown = int(3 * 60)
        UnmountScript()
        Ui.Error(translations["unmounted_error"], 5, (125, 0, 125))

    #!############################
    #! WORKSHOP BUTTONS FUNCTIONS
    #!############################

    # Get's the id from a map's url then copies the changelevel command to the clipboard
    def Button_GetWorkShopCommand_func(self) -> None:
        def AfterInput(input: str):
            map = Workshop.MapFromSteamID(input)

            if map is not None:
                pyperclip.copy("changelevel " + map)
                self.Error(
                    translations["workshop_changelevel_command"], 3, (255, 0, 255))
                self.Error(
                    translations["workshop_copied_to_clipboard"], 3, (0, 255, 0))
                self.BackMenu()
                return

            self.Error(
                translations["workshop_map_not_found"], 6, (255, 255, 0))
            self.BackMenu()

        self.ChangeMenu(self.BlankButton, append=True)
        self.GetUserInput(AfterInput, translations["workshop_link"])

    #!############################
    #! RESOURCES BUTTONS FUNCTIONS
    #!############################

    # opens the github repo in the browser

    def Button_GitHub_func(self) -> None:
        # open the discord invite in the default browser
        webbrowser.open(
            "https://github.com/kyleraykbs/Portal2-32PlayerMod#readme")

    # this simply opens the steam guide

    def Button_Guide_func(self) -> None:
        # open the steam guide in the default browser
        webbrowser.open(
            "https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280")

    # opens the browser to an invite to the discord server

    def Button_Discord_func(self) -> None:
        # open the discord invite in the default browser
        webbrowser.open("https://discord.com/invite/kW3nG6GKpF")

    #!############################
    #! TESTING BUTTONS FUNCTIONS
    #!############################

    # a button for testing stuff

    def Button_Test_func(self) -> None:
        self.ChangeMenu(self.TestMenu, self.TestMenuText, True)

#! END OF BUTTON FUNCTIONS

    def ChangeMenu(self, menu: list, text: list = [], append: bool = True) -> None:
        if append:
            self.DirectoryMenu.append(self.CurrentMenuButtons)
            self.DirectoryMenuText.append(self.CurrentMenuText)

        self.CurrentMenuButtons = menu
        self.CurrentMenuText = text

        if self.CurrentButtonsIndex >= len(menu):
            self.CurrentButtonsIndex = len(menu) - 1

        if self.CurrentMenuTextIndex >= len(text):
            self.CurrentMenuTextIndex = len(text) - 1

        self.SelectedButton = self.CurrentMenuButtons[self.CurrentButtonsIndex]

    ####################

    # Test for input fields
    def Button_InputField_func(self) -> None:
        def AfterInput(input) -> None:
            self.Error("Input: " + input, 3, (255, 255, 0))
            self.BackMenu()

        self.ChangeMenu(self.BlankButton, append=True)
        self.GetUserInput(
            AfterInput, "As you can see this text can \n go onto another line :)")

    # Test for popup boxes
    def PopupBox_test_func(self) -> None:
        def YesInput() -> None:
            self.Error("Let's go!!!", 3, (75, 255, 75))

        def NoInput() -> None:
            self.Error("Bruh...", 3, (255, 75, 75))

        Button_Confirm = self.ButtonModel(
            translations["error_yes"], YesInput, (75, 200, 75))
        Button_Decline = self.ButtonModel(
            translations["error_no"], NoInput, (255, 75, 75))
        self.PopupBox("Trolling Time!?!?!", "Have you given Cabiste an\nAneurysm today?",
                      [Button_Confirm, Button_Decline])

    # Test to print text to console
    def Button_PrintToConsole_func(self) -> None:
        print(self.Clock.get_fps())

    ################################

    def SelectAnimation(self, btn: ButtonModel, anim: str) -> None:
        if anim == "pop":
            btn.CurrentAnimation = "pop1"

    def RunAnimation(self, button: ButtonModel, anim: str) -> None:
        if anim == "pop1":
            if button.sizeMultiplier < 1.3:
                button.sizeMultiplier += 0.1
            else:
                button.CurrentAnimation = "pop2"
        if anim == "pop2":
            if button.sizeMultiplier > 1:
                button.sizeMultiplier -= 0.1
            else:
                button.sizeMultiplier = 1
                button.CurrentAnimation = ""

    # Displaying the "prompt" and "warning" fields when hovering over settings
    def BlitDescription(self, text: str, x: float = None, y: float = None, color: tuple = (255, 255, 255)) -> None:

        if x is None:
            x = self.screen.get_width() / 16
        if y is None:
            y = self.screen.get_height() / 16

        if (len(text) > 0):
            text = pygame.font.Font(translations["font"], int(int(
                int((int(self.screen.get_width() / 15) + int(self.screen.get_height() / 25)) / (len(text) * 0.1))))).render(text, True, color)
            if not (self.LookingForInput):
                self.screen.blit(text, (x, y))

    def GetUserInput(self, action=None, prompt: str = "", preInput: str = "") -> None:

        Log("Getting user input...")

        self.LookingForInput = True
        self.CurInput = preInput

        # Will tell the blit part of the code (line 1180) to blit it as multiple lines or not
        self.HasBreaks = False
        # Need to count how many lines there are to pass to the blit part of the code (line 1180)
        self.PromptBreaks = 0

        # needed to display the prompt text in multiple lines
        if "\n" in prompt:
            self.HasBreaks = True
            prompt = prompt.split("\n")
            self.PromptBreaks = len(prompt)

        self.InputPrompt = prompt
        self.AfterInputFunction = action

    def Error(self, text: str, time: int = 3, color: tuple = (255, 75, 75)) -> None:
        Log(text)

        if "\n" not in text:
            self.ERRORLIST.append([text, time, color])
            return

        # if the text has newlines, split it up
        text = text.split("\n")
        for i in range(0, len(text)):
            self.ERRORLIST.append([text[i], time, color])

    def PopupBox(self, title: str, text: str, buttons: list) -> None:

        # MANUAL #
        # title = "A String Title For The Box"
        # text = "A String Of Text To Display In The Box (use \n for newlines)"
        # buttons = [["Button Text", "Button Function"], ["Button Text", "Button Function"], etc, etc.....]
        ##########

        self.SelectedPopupButton = buttons[0]

        PopupBox = [title, text, buttons]  # TITLE, TEXT, BUTTONS
        Log("Creating popup box... Tile: " + str(title) + " Text: " + text )
        self.PopupBoxList.append(PopupBox)

    # the language button (English, French, etc...)
    def Button_Language_func(self) -> None:
        lang: str = self.LanguagesMenu[self.CurrentButtonsIndex].text.replace(
            "→ ", "")
        Log("Language set: " + lang)
        CFG.EditConfig("Active-Language", lang)
        LoadTranslations()
        self.__init__(self.devMode)
        self.Error(translations["language_error_language_update"])

    def LanguageButton(self) -> None:
        self.LanguagesMenu.clear()
        Languages = GetAvailableLanguages()
        for language in Languages:
            if GVars.configData["Active-Language"]["value"] == language:
                language = "→ " + language

            self.LanguagesMenu.append(self.ButtonModel(
                language, self.Button_Language_func, (150, 150, 255)))

        self.LanguagesMenu.append(self.Button_Back)

    ###############################################################################

    def Update(self) -> None:
        W = self.screen.get_width()
        H = self.screen.get_height()
        clr = (0, 0, 0)
        fntdiv: int = 32
        fontSize = int(W / fntdiv)
        mindiv = int(fntdiv / 1.25)

        # loop through all buttons
        buttonIndex = 0

        for button in self.CurrentMenuButtons:
            buttonIndex += 1
            button.width = int(button.size / 27)
            button.height = int(button.size / 52)

            if button == self.SelectedButton:
                clr = button.ActiveColor
            else:
                clr = button.InactiveColor
            self.RunAnimation(button, button.CurrentAnimation)

            text1 = pygame.font.Font(
                translations["font"], (button.width + button.height)).render(button.text, True, clr)

            if not (self.LookingForInput):
                self.screen.blit(
                    text1, (W / button.xPos, (H / button.yPos - (text1.get_height() / 2)) * (buttonIndex / 5.6)))
            button.x = W / button.xPos
            button.y = ((H / button.yPos) -
                        (text1.get_height() / 2)) * (buttonIndex / 5.6)
            button.width = text1.get_width()
            button.height = text1.get_height()

        # For drawing "displayText"
        for displayText in self.CurrentMenuText:
            displayText.width = int(W / displayText.size)
            displayText.height = int(H / displayText.size)
            text = pygame.font.Font(
                translations["font"], (displayText.width + displayText.height))
            # 2D array where each row is a list of words.
            words = [word.split(' ') for word in displayText.text.splitlines()]
            space = text.size(' ')[0]  # The width of a space.
            max_width = displayText.xEnd
            max_height = H
            x = displayText.xPos
            y = displayText.yPos
            # This code will wrap any text that goes off screen, thanks Stack Overflow for this :)
            for line in words:
                for word in line:
                    word_surface = text.render(
                        word, True, displayText.textColor)
                    word_width, word_height = word_surface.get_size()
                    if x + displayText.xStart >= max_width:
                        x = displayText.xStart  # Reset the x.
                        y += word_height  # Start on new row.
                    self.screen.blit(word_surface, (x, y))
                    x += word_width + space
                x = displayText.xStart  # Reset the x.
                y += word_height  # Start on a new row.

        # BACKGROUND
        for floater in self.Floaters:
            surf = floater.surf
            if (self.SelectedButton.text == translations["unmount_button"] or self.SelectedButton.text == translations["exit_button"]):
                surf = self.RedCube
            if (self.SelectedButton.text == translations["back_button"]):
                surf = self.GoldenCube
            surf = pygame.transform.scale(surf, (W / 15, W / 15))
            surf = pygame.transform.rotate(surf, floater.rot)
            center = surf.get_rect().center
            LauncherCubes = GVars.configData["Launcher-Cubes"]["value"]
            if (LauncherCubes):
                self.screen.blit(
                    surf, (floater.x - center[0], floater.y - center[1]))
            if floater.NegativeRotation:
                floater.rot -= (1 + random.randint(0, 2))
            else:
                floater.rot += (1 + random.randint(0, 2))
            if (self.SelectedButton.text == translations["back_button"]):
                floater.x -= W / 60
                if floater.x < (floater.surf.get_width() * -2):
                    floater.y = random.randint(0, H)
                    floater.x = (floater.surf.get_width() * 2) + \
                        (random.randint(W, W * 2)) * 1
                    floater.NegativeRotation = random.randint(0, 1) == 1
            elif (self.SelectedButton.text == translations["unmount_button"] or self.SelectedButton.text == translations["exit_button"]):
                floater.y -= H / 60
                if floater.y < (floater.surf.get_height() * -2):
                    floater.y = (floater.surf.get_height() * 2) + \
                        (random.randint(H, H * 2))
                    floater.x = random.randint(0, W)
                    floater.NegativeRotation = random.randint(0, 1) == 1
            else:
                floater.y += H / 60
                if floater.y > (H + floater.surf.get_height() * 2):
                    floater.y = (floater.surf.get_height() * -2) + \
                        (random.randint(0, H)) * -1
                    floater.x = random.randint(0, W)
                    floater.NegativeRotation = random.randint(0, 1) == 1

        # Displaying button icons for keyboard or Steam Deck controller input
        if (not self.LookingForInput):
            if GVars.iosd:
                sdButtons = pygame.image.load(
                    "GUI/images/sdButtons.png").convert_alpha()
                sdButtons = pygame.transform.scale(sdButtons, (W / 10, W / 10))
                self.screen.blit(
                    sdButtons, ((W / 1.03) - sdButtons.get_width(), H / 1.22))
            else:
                # Puts assets/images/keys.png on the bottom right corner of the screen
                keys = pygame.image.load("GUI/images/keys.png").convert_alpha()
                keys = pygame.transform.scale(keys, (W / 10, W / 10))
                self.screen.blit(
                    keys, ((W / 1.03) - keys.get_width(), H / 1.22))

        # For showing the button to press to get up the on-screen keyboard on Steam Deck
        if (self.LookingForInput and GVars.iosd):
            keyboardButton = pygame.image.load(
                "GUI/images/sdKeyboard.png").convert_alpha()
            keyboardButton = pygame.transform.scale(
                keyboardButton, (W / 10, W / 10))
            self.screen.blit(keyboardButton, ((W / 1.03) -
                             keyboardButton.get_width(), H / 1.22))
            pasteButton = pygame.image.load(
                "GUI/images/sdClipboard.png").convert_alpha()
            pasteButton = pygame.transform.scale(pasteButton, (W / 12, W / 17))
            self.screen.blit(pasteButton, ((W / 1.14) -
                             pasteButton.get_width(), H / 1.22))
            if self.SDShift:
                shiftIndicator = pygame.image.load(
                    "GUI/images/sdShiftOn.png").convert_alpha()
                shiftIndicator = pygame.transform.scale(
                    shiftIndicator, (W / 6, W / 16))
                self.screen.blit(
                    shiftIndicator, ((W / 1.13) - shiftIndicator.get_width(), H / 1.11))
            else:
                shiftIndicator = pygame.image.load(
                    "GUI/images/sdShiftOff.png").convert_alpha()
                shiftIndicator = pygame.transform.scale(
                    shiftIndicator, (W / 6, W / 16))
                self.screen.blit(
                    shiftIndicator, ((W / 1.13) - shiftIndicator.get_width(), H / 1.11))

        # MENU

        self.SelectedButton = self.CurrentMenuButtons[self.CurrentButtonsIndex]

        # OVERLAY

        buttonIndex = 0
        for error in self.ERRORLIST[::-1]:
            buttonIndex += 1
            errorText = pygame.font.Font(translations["font"], int(
                int(W / 60) + int(H / 85))).render(error[0], True, error[2])

            self.screen.blit(
                errorText, (W / 30, ((errorText.get_height() * buttonIndex) * -1) + (H / 1.05)))

        # every 1 second go through each error and remove it if it's been there for more than 1 second
        if (time.time() - self.SecAgo) > 1:
            for error in self.ERRORLIST:
                if (error[1] < 0):
                    self.ERRORLIST.remove(error)
                error[1] -= 1
            self.SecAgo = time.time()

        if type(self.SelectedButton) is self.ConfigButtonModel:
            self.SelectedButton.Hovered(self)

        # DRAW POPUP BOX
        if len(self.PopupBoxList) > 0:
            sz = 1.25

            # draw a white box that is half the width and height of the screen
            popupBackground = pygame.Surface((W / sz, W / (sz * 2)))
            popupBackground.fill((255, 255, 255))
            popupBackground.set_alpha(175)
            self.screen.blit(popupBackground, (W / 2 - (popupBackground.get_width() / 2),
                                             H / 2 - (popupBackground.get_height() / 2)))

            popupBackgroundWidth = popupBackground.get_width()
            popupBackgroundHeight = popupBackground.get_height()
            bx = W / 2 - (popupBackgroundWidth / 2)
            by = H / 2 - (popupBackgroundHeight / 2)

            # put the title in the box
            popupTitle = pygame.font.Font(translations["font"], fontSize).render(self.PopupBoxList[0][0], True,
                                                                               (255, 255, 0))
            titleWidth = popupTitle.get_width()
            titleHeight = popupTitle.get_height()
            titleX = bx + (popupBackgroundWidth / 2) - (titleWidth / 2)
            titleY = by + (titleHeight / 2)
            self.screen.blit(popupTitle, (titleX, titleY))

            # put the text in the box
            ctext = self.PopupBoxList[0][1].split("\n")
            buttonIndex = 0
            for line in ctext:
                text = pygame.font.Font(
                    translations["font"], int(fontSize / 1.5)).render(line, True, (0, 0, 0))
                textWidth = text.get_width()
                textHeight = text.get_height()
                textX = bx + (popupBackgroundWidth / 2) - (textWidth / 2)
                textY = by + (titleHeight * 2) + (textHeight * buttonIndex)
                self.screen.blit(text, (textX, textY))
                buttonIndex += 1

            # put the buttons in the box
            amtob = len(self.PopupBoxList[0][2])
            buttonIndex = 0
            for button in self.PopupBoxList[0][2]:
                buttonSurface = pygame.surface.Surface(
                    ((popupBackgroundWidth / amtob) / 1.2, (popupBackgroundHeight / 5)))

                if (button == self.SelectedPopupButton):
                    buttonSurface.fill(button.ActiveColor)
                else:
                    buttonSurface.fill(button.InactiveColor)

                buttonSurfaceWidth = buttonSurface.get_width()
                buttonSurfaceHeight = buttonSurface.get_height()
                buttonSurfaceX = bx + (popupBackgroundWidth / amtob) * buttonIndex + \
                    (popupBackgroundWidth / amtob) / 2 - (buttonSurfaceWidth / 2)

                buttonSurfaceY = by + popupBackgroundHeight - (popupBackgroundHeight / 4)
                button.x = buttonSurfaceX
                button.y = buttonSurfaceY
                button.width = buttonSurfaceWidth
                button.height = buttonSurfaceHeight
                self.screen.blit(buttonSurface, (buttonSurfaceX, buttonSurfaceY))

                text = pygame.font.Font(translations["font"], int(
                    fontSize / 1.5)).render(button.text, True, (255, 255, 255))
                textWidth = text.get_width()
                textHeight = text.get_height()
                textX = bx + (popupBackgroundWidth / amtob) * buttonIndex + \
                    ((popupBackgroundWidth / amtob) / 2) - (textWidth / 2)
                textY = by + popupBackgroundHeight - (popupBackgroundHeight / 5) + (textHeight / 2)
                self.screen.blit(text, (textX, textY))
                buttonIndex += 1

        # DRAW INPUT BOX
        if self.LookingForInput:
            # divide the CurrentInput into lines
            lines = []
            # every  23 characters, add a new line
            lines.append(self.CurInput[0:mindiv])
            for i in range(mindiv, len(self.CurInput), mindiv):
                lines.append(self.CurInput[i:i + mindiv])

            InputText = ""
            for i in range(len(lines)):
                InputText = pygame.font.Font(
                    translations["font"], fontSize).render(lines[i], True, (255, 255, 175))
                self.screen.blit(InputText, (W / 2 - (InputText.get_width() / 2), (
                    (((H / 2) - (InputText.get_height() * 1.25)) + ((text1.get_height() * 1.25) * i))) - (
                    (((text1.get_height() * 1.25) * (len(lines) / 2))))))

            surf1 = pygame.Surface((W / 1.5, W / 100))
            surf1.fill((255, 255, 255))
            surf2 = pygame.Surface((W / 1.5, W / 100))
            blitPos = (
                (W / 2) - (surf2.get_width() / 2), (H / 2) + ((InputText.get_height() * 1.725) * ((len(lines) / 2) - 1)))
            self.screen.blit(surf1, blitPos)
            # We need to check if breaks were detected before in the prompt part of the code (line 868)
            if self.HasBreaks == True:
                for breaks in range(0, self.PromptBreaks):
                    surfInputPrompt = pygame.font.Font(translations["font"],
                                                       int(fontSize/1.5)).render(self.InputPrompt[breaks], True, (255, 255, 255))

                    # blit it right below the surf1
                    self.screen.blit(surfInputPrompt,
                                     (blitPos[0] + (surf1.get_width() / 2) - (surfInputPrompt.get_width() / 2),
                                      ((blitPos[1] + 15) + (surfInputPrompt.get_height() * breaks))))
            else:
                surfInputPrompt = pygame.font.Font(translations["font"],
                                                   int(fontSize/1.5)).render(self.InputPrompt, True, (255, 255, 255))

                # blit it right below the surf1
                self.screen.blit(surfInputPrompt,
                                 (blitPos[0] + (surf1.get_width() / 2) - (surfInputPrompt.get_width() / 2),
                                  (blitPos[1] + surfInputPrompt.get_height())))

    ###############################################################################

    def Main(self) -> None:
        LastBackspace = 0
        while self.running:
            mouse = pygame.mouse.get_pos()
            mouseX = mouse[0]
            mousey = mouse[1]

            # make the screen a gradient
            self.screen.fill((0, 0, 0))
            self.gradientRect(self.screen, (0, 2, 10), (2, 2, 10), pygame.Rect(
                0, 0, self.screen.get_width(), self.screen.get_height()))
            self.Update()
            pygame.display.update()
            self.Clock.tick(self.FPS)

            if self.coolDown > 0:
                self.coolDown -= 1

            # so you can hold backspace to delete
            if self.LookingForInput:
                BACKSPACE_HELD = pygame.key.get_pressed()[pygame.K_BACKSPACE]
                if BACKSPACE_HELD:
                    LastBackspace += 0.25
                # if its been a second since the last backspace, delete the last character
                if (LastBackspace >= 1):
                    if (len(self.CurInput) > 0):
                        self.CurInput = self.CurInput[:-1]
                    LastBackspace = 0

            for event in pygame.event.get():
                if event.type == QUIT:
                    self.running = False

                if self.LookingForInput:
                    CTRL_HELD = pygame.key.get_mods() & pygame.KMOD_CTRL
                    SHIFT_HELD = pygame.key.get_mods() & pygame.KMOD_SHIFT
                    # For debugging input prompt inputs
                    if GVars.configData["Dev-Mode"]["value"] and not event.type == pygame.MOUSEMOTION:
                        print(f"event: {event}")
                        print(f"event.type: {event.type}")
                        print(f"event.dict: {event.dict}")
                    if event.type == pygame.KEYDOWN:
                        if GVars.configData["Dev-Mode"]["value"]:
                            print(f"event.key: {event.key}")
                            print(
                                f"event.key Name: {pygame.key.name(event.key)}")

                        # get the key and add it to self.CurInput
                        name = pygame.key.name(event.key)

                        if name == "space":
                            self.CurInput += " "
                        # In order to delete characters for input prompts on Steam Deck
                        elif name == "backspace" and GVars.iosd:
                            if (len(self.CurInput) > 0):
                                self.CurInput = self.CurInput[:-1]
                        elif name in ["return", "enter"]:
                            self.LookingForInput = False
                            self.AfterInputFunction(self.CurInput)
                        elif name == "escape":
                            self.LookingForInput = False
                            self.BackMenu()
                        elif name == "tab":
                            self.CurInput += "    "
                        # Pasting on Steam Deck, Right Arrow on on-screen keyboard
                        elif event.key == 4:
                            try:
                                pastedString = str(
                                    pyperclip.paste().replace("\n", ""))
                                self.CurInput += pastedString
                                Log(f"Pasted: {pastedString}")
                            except Exception as e:
                                Log(str(e))
                                pass
                        # Shifting on Steam Deck, Left Arrow on on-screen keyboard
                        elif event.key == 3:
                            if self.SDShift:
                                self.SDShift = False
                            else:
                                self.SDShift = True
                            print(self.SDShift)
                        elif CTRL_HELD and name == "v":
                            try:
                                pastedString = str(
                                    pyperclip.paste().replace("\n", ""))
                                self.CurInput += pastedString
                                Log(f"Pasted: {pastedString}")
                            except Exception as e:
                                Log(str(e))  # Log a error in case it fails
                                pass
                        elif len(name) == 1:
                            # On Steam Deck the on-screen shift button doesn't work :(
                            if SHIFT_HELD or self.SDShift:
                                # if the name doesn't contain a letter
                                if not name.isalpha():
                                    name = name.replace("1", "!").replace("2", "@").replace("3", "#").replace("4",
                                                                                                              "$").replace(
                                        "5", "%").replace("6", "^").replace("7", "&").replace("8", "*").replace("9",
                                                                                                                "(").replace(
                                        "0", ")").replace("`", "~").replace("-", "_").replace("=", "+").replace("[",
                                                                                                                "{").replace(
                                        "]", "}").replace("\\", "|").replace(";", ":").replace("'", "\"").replace(",",
                                                                                                                  "<").replace(
                                        ".", ">").replace("/", "?")
                                # convert lowercase to uppercase
                                else:
                                    name = name.upper()
                                self.CurInput += name
                            else:
                                self.CurInput += name
                        # support for numpad
                        elif len(name) == 3:
                            self.CurInput += name[1]
                    continue

                # POPUP BOX INPUT
                if len(self.PopupBoxList) > 0:
                    boxLength = len(self.PopupBoxList[0][2])
                    if event.type == KEYDOWN:
                        if event.key == K_ESCAPE:
                            self.PopupBoxList.pop()

                        if event.key == K_RIGHT:
                            for button in self.PopupBoxList[0][2]:
                                if button == self.SelectedPopupButton:
                                    if self.PopupBoxList[0][2].index(button) < boxLength - 1:
                                        self.SelectedPopupButton = self.PopupBoxList[0][2][self.PopupBoxList[0][2].index(
                                            button) + 1]

                        elif event.key == K_LEFT:
                            for button in self.PopupBoxList[0][2]:
                                if button == self.SelectedPopupButton:
                                    if self.PopupBoxList[0][2].index(button) > 0:
                                        self.SelectedPopupButton = self.PopupBoxList[0][2][self.PopupBoxList[0][2].index(
                                            button) - 1]

                        elif event.key == K_SPACE or event.key == K_RETURN:
                            self.SelectedPopupButton.function()
                            self.PopupBoxList.pop()

                    elif event.type == MOUSEBUTTONDOWN:
                        # if the mouse is over a button
                        for button in self.PopupBoxList[0][2]:
                            if (button.x < mouseX < button.x + button.width) and (button.y < mousey < button.y + button.height):
                                self.SelectedPopupButton = button
                                self.SelectedPopupButton.function()
                                self.PopupBoxList.pop()
                                break

                # NORMAL INPUT
                if (not self.LookingForInput):
                    # Leaving this here for testing inputs when not in a input prompt
                    # Too many log messages to have for a Developer Mode thing
                    # print(f"event: {event}")
                    # print(f"event.type: {event.type}")
                    # print(f"event.dict: {event.dict}")
                    if event.type == KEYDOWN:
                        # print(f"event.key: {event.key}")
                        if event.key in [K_ESCAPE, K_BACKSPACE]:
                            self.BackMenu()
                        elif event.key in [K_DOWN, K_s]:
                            if self.CurrentButtonsIndex < len(self.CurrentMenuButtons) - 1:
                                self.CurrentButtonsIndex += 1
                                self.SelectedButton = self.CurrentMenuButtons[self.CurrentButtonsIndex]
                                self.PlaySound(self.SelectedButton.HoverSound)
                            else:
                                self.CurrentButtonsIndex = 0
                                self.SelectedButton = self.CurrentMenuButtons[self.CurrentButtonsIndex]
                                self.PlaySound(self.SelectedButton.HoverSound)
                        elif event.key in [K_UP, K_w]:
                            if self.CurrentButtonsIndex > 0:
                                self.CurrentButtonsIndex -= 1
                                self.SelectedButton = self.CurrentMenuButtons[self.CurrentButtonsIndex]
                                self.PlaySound(self.SelectedButton.HoverSound)
                            else:
                                self.CurrentButtonsIndex = len(
                                    self.CurrentMenuButtons) - 1
                                self.SelectedButton = self.CurrentMenuButtons[self.CurrentButtonsIndex]
                                self.PlaySound(self.SelectedButton.HoverSound)
                        # On Steam Deck, for some reason the Y button also acts as a enter key,
                        # but for the users sake the A button is going to be used
                        elif event.key in [K_SPACE] or event.key == 13:
                            self.SelectAnimation(
                                self.SelectedButton, self.SelectedButton.ClickAnimation)
                            if self.SelectedButton.function:
                                if self.SelectedButton.isAsync:
                                    threading.Thread(
                                        target=self.SelectedButton.function).start()
                                else:
                                    self.SelectedButton.function()
                            self.PlaySound(self.SelectedButton.ClickSound)

                # LMB
                # executes the button's function on left mouse click IF the mouse is above the button
                if event.type == pygame.MOUSEBUTTONDOWN:
                    if event.button == 1:
                        button = self.SelectedButton
                        if (mouseX > button.x and mouseX < button.x + button.width) and (mousey > button.y and mousey < button.y + button.height):
                            if self.SelectedButton.function:
                                if self.SelectedButton.isAsync:
                                    threading.Thread(
                                        target=self.SelectedButton.function).start()
                                else:
                                    self.SelectedButton.function()

                            self.SelectAnimation(
                                self.SelectedButton, self.SelectedButton.ClickAnimation)

                            self.PlaySound(self.SelectedButton.ClickSound)

                ###############################
                # changes the `SelectedButton` and the `CurrentButtonsIndex` to the button the mouse is on
                if event.type == pygame.MOUSEMOTION:
                    for button in self.CurrentMenuButtons:
                        # if the mouse is over the button
                        if (mouseX > button.x and mouseX < button.x + button.width) and (mousey > button.y and mousey < button.y + button.height):
                            # if the button isn't already selected
                            if button != self.SelectedButton:
                                # select the button
                                self.SelectedButton = button
                                # set current buttons index to the button
                                self.CurrentButtonsIndex = self.CurrentMenuButtons.index(
                                    button)
                                # play the hover sound
                                self.PlaySound(self.HoverSound)

            ###############################
            # changes the color of the hovered button in the popup box
            if len(self.PopupBoxList) > 0:
                for button in self.PopupBoxList[0][2]:
                    # if the mouse is over the button
                    if ((mouseX > button.x and mouseX < button.x + (button.size / 25)) and (mousey > button.y and mousey < button.y + (button.size / 50))):
                        if button != self.SelectedPopupButton:
                            self.SelectedPopupButton = button
                            self.PlaySound(button.HoverSound)

        PreExit()

        pygame.quit()
        os._exit(0)

# !######################################################
# !                       Logic
# !######################################################


def PreExit() -> None:
    Log("Shutting down the P2MM launcher...")
    Log("Shutting down Portal 2...")
    # Windows
    if (GVars.iow):
        os.system("taskkill /f /im portal2.exe")

    # Linux and Steam Deck
    if (GVars.iol) or (GVars.iosd):
        os.system("killall -9 portal2_linux")

    # This waits to make sure the Portal 2 thread is dead
    # 1 second should be enough for it to die
    time.sleep(1)
    Log("Portal 2 has been shutdown...")

    # Make sure the P2MM ModFiles are unmounted from Portal 2
    if (GVars.configData["Auto-Unmount"]["value"]):
        Log("Unmounting P2MM's ModFiles from Portal 2...")
        UnmountScript(False)
        Ui.Error(translations["unmounted_error"], 5, (125, 0, 125))
        Log("Unmounted P2MM's ModFiles from Portal 2...")

    Log("The P2MM launcher has been shutdown...")


def GetGamePath() -> None:
    tempPath = BF.TryFindPortal2Path()

    if tempPath:
        CFG.EditConfig("Portal2-Path", tempPath.strip())
        Log("Saved '" + tempPath.strip() + "' as the game path!")
        Ui.Error(translations["game_path_error-founded"], 5, (255, 255, 75))
        VerifyGamePath(False)
        return

    def AfterInputGP(inp) -> None:
        CFG.EditConfig("Portal2-Path", inp.strip())
        Log("Saved '" + inp.strip() + "' as the game path!")
        Ui.Error(translations["game_path_error-saved"], 5, (75, 200, 75))
        VerifyGamePath(False)

    Ui.ChangeMenu(Ui.BlankButton, append=True)
    Ui.GetUserInput(AfterInputGP, translations["game_path_enter_path"])


def VerifyGamePath(shouldGetPath: bool = True) -> bool:
    Log("Verifying game path...")
    gamePath = GVars.configData["Portal2-Path"]["value"]

    if not os.path.exists(gamePath):
        Ui.Error(translations["game_path-is-invalid"])

        if shouldGetPath:
            Ui.Error(
                translations["game_path-attempt-to-fetch"], 5, (255, 255, 75))
            GetGamePath()

        return False
    Log("Game path is valid...")
    return True


def VerifyModFiles() -> bool:
    Log("Searching for mod files in: " + GVars.modFilesPath)
    if GVars.configData["Dev-Mode"]["value"]:
        Log("modFilesPath and identifier file exist?")
        print(os.path.exists(GVars.modFilesPath))
        print(GVars.modFilesPath)
        print(os.path.exists(GVars.modFilesPath + os.sep + "Portal 2" +
              os.sep + "install_dlc" + os.sep + "p2mm.identifier"))
        print(GVars.modFilesPath + os.sep + "Portal 2" +
              os.sep + "install_dlc" + os.sep + "p2mm.identifier")

    #
    # if (os.path.exists(GVars.modFilesPath)) and (os.path.exists(GVars.modFilesPath + os.sep + "Portal 2" + os.sep + "install_dlc" + os.sep + "p2mm.identifier")):
    if (os.path.exists(GVars.modFilesPath)) and (os.path.exists(GVars.modFilesPath + os.sep + "Portal 2" + os.sep + "install_dlc" + os.sep + "32playermod.identifier")):
        Log("Mod files found!")
        return True

    Log("Mod files not found!")
    return False


def MountModOnly() -> bool:
    CFG.ValidatePlayerKeys()

    if Ui.IsUpdating:
        Ui.Error(translations["update_is-updating"], 5, (255, 75, 75))
        return False

    if not VerifyGamePath():
        return False

    Ui.Error(translations["mounting_mod"], 5, (75, 255, 75))

    # Need to make sure the game path is in fact defined if not P2MM will not be run/mounted
    gamePath = GVars.configData["Portal2-Path"]["value"]
    if ("undefined" in gamePath):
        Ui.Error(translations["mount_nopath_error"], 5, (255, 21, 0))
        return False

    # Check if both of Portal 2's DLC folders exist
    if not RG.CheckForRequiredDLC(gamePath):
        Ui.Error(translations["mount_nodlc_error"], 5, (255, 21, 0))
        return False

    if VerifyModFiles():
        DoEncrypt = GVars.configData["Encrypt-CVars"]["value"]
        if DoEncrypt:
            Ui.Error(
                translations["mounting_mod_with_encryption"], 10, (255, 255, 0))
        RG.MountMod(gamePath, DoEncrypt)
        Ui.Error(translations["mounted"], 5, (75, 255, 75))
        return True

    # If the they are not a developer and the mod files don't exist ask them to download the files from the repo
    if (os.path.exists(GVars.modPath + os.sep + "ModFiles")):
        BF.DeleteFolder(GVars.modPath + os.sep + "ModFiles")

    def YesInput():
        Log("User agreed to download the mod files! Fetching mod...")
        if not UP.HasInternet():
            Ui.Error(
                translations["update_error_connection_problem"], 5, (255, 75, 75))
            return False
        UpdateModFiles()

    def NoInput():
        Log("User cancelled downloading the ModFiles...")
        Ui.Error(translations["game_launch_cancel"], 5)
        return False

    YesButton = Ui.ButtonModel(
        translations["error_yes"], YesInput, (75, 200, 75))

    NoButton = Ui.ButtonModel(
        translations["error_no"], NoInput, (255, 0, 0))

    Ui.PopupBox(translations["game_files_fetch_game"],
                translations["game_files_no_cached_files"], [YesButton, NoButton])


def GetAvailableLanguages() -> list[str]:
    Log("Searching for available languages...")
    langs = []
    for file in os.listdir("Languages"):
        print(f"File 1: {file}")
        langs.append(file[:-5])
    if os.path.exists(GVars.modPath + os.sep + "Languages"):
        for file in os.listdir(GVars.modPath + os.sep + "Languages"):
            print(f"File 2: {file}")
            langs.append(file[:-5])

    return langs


def LoadTranslations() -> dict:
    global translations
    langPath = "Languages/" + \
        GVars.configData["Active-Language"]["value"] + ".json"

    if not os.path.exists(langPath):
        langPath = GVars.modPath + os.sep + "Languages/" + \
            GVars.configData["Active-Language"]["value"] + ".json"

    translations = json.load(open(langPath, "r", encoding="utf8"))

    if (not os.path.exists(langPath)):
        CFG.EditConfig("Active-Language",
                       CFG.DefaultConfigFile["Active-Language"]["value"])
        langPath = "Languages/" + \
            GVars.configData["Active-Language"]["value"] + ".json"
        if GVars.configData["Dev-Mode"]["value"]:
            print(langPath)
        translations = json.load(open(langPath, "r", encoding="utf8"))

        Log("[ERROR] Language file isn't found or key mismatch")


def UpdateModFiles() -> None:
    PreExit()
    Ui.Error(translations["update_fetching"], 5000, (255, 150, 75))

    def UpdateThread() -> None:
        Log("Updating...")
        Ui.IsUpdating = True
        UP.DownloadNewFiles()
        Ui.Error(translations["update_complete"], 5, (75, 255, 75))
        Ui.IsUpdating = False
        for thing in Ui.ERRORLIST:
            if thing[0] == translations["update_fetching"]:
                Ui.ERRORLIST.remove(thing)

    threading.Thread(target=UpdateThread).start()


def UpdateModClient(data: dict) -> None:
    PreExit()
    Ui.Error(translations["updating_client"], 5000, (255, 150, 75))

    def UpdateThread() -> None:
        Log("Updating client...")
        Ui.IsUpdating = True

        if not UP.DownloadClient(data["newRepo"]):
            Ui.Error(
                translations["update_nolink_error"])
            return

        Ui.running = False
        Log("self.running set to false")

    threading.Thread(target=UpdateThread).start()


def RunGameScript() -> None:
    if MountModOnly():
        gamePath = GVars.configData["Portal2-Path"]["value"]
        GVars.gameActive = True
        RG.LaunchGame(gamePath)
        Ui.Error(translations["game_launched"], 5, (75, 255, 75))
    else:
        Ui.Error(translations["game_path_undefined_fetch"], 5)
        GetGamePath()


def UnmountScript(shouldGetPath: bool = True) -> None:
    Log("___Unmounting Mod___")
    VerifyGamePath(shouldGetPath)
    gamePath = GVars.configData["Portal2-Path"]["value"]
    RG.DeleteUnusedDLCs(gamePath)
    RG.UnPatchBinaries(gamePath)
    Log("____DONE UNMOUNTING____")


def RestartClient(path: str = sys.executable) -> None:
    if (GVars.iol) or (GVars.iosd):
        chmodCommand = "chmod +x " + path
        os.system(chmodCommand)

    command = path
    subprocess.Popen(command, shell=True)
    Log("Restarting client")
    Ui.running = False

# checks if the client was downloaded by a previous version of itself


def IsNew() -> None:
    # Two arguments are passed when the client updates
    # 1- the word "updated"
    # 2- the path of the previous version
    # argument 0 is always the command to start the app so it is not needed

    if len(sys.argv) != 3:
        return

    if (sys.argv[1] != "updated") or (not os.path.exists(sys.argv[2])):
        return

    Log("This is first launch after a successful update")

    Log("Deleting old client...")
    os.remove(sys.argv[2])

    # this will rename the new client to the old client's name
    Log("Renaming new client...")
    os.rename(GVars.executable, sys.argv[2])
    RestartClient("\"" + sys.argv[2] + "\"")


def ClientUpdateBox(update: dict) -> None:
    YesButton = Ui.ButtonModel(
        translations["error_yes"], lambda: UpdateModClient(update), (75, 200, 75))
    NoButton = Ui.ButtonModel(
        translations["error_no"], activeColor=(255, 75, 75))

    Ui.PopupBox(update["name"], update["message"], [YesButton, NoButton])


def NewClientNotifyPopup(update: dict) -> None:
    YesButton = Ui.ButtonModel(
        translations["error_ok"], activeColor=(75, 200, 75))

    message = "There's a new client available, if you want to update please check the github repo for more info"

    Ui.PopupBox(update["name"], BF.StringToParagraph(message, 37), [YesButton])


def ModFilesUpdateBox() -> None:
    YesButton = Ui.ButtonModel(
        translations["error_yes"], UpdateModFiles, (75, 200, 75))
    NoButton = Ui.ButtonModel(
        translations["error_no"], activeColor=(255, 75, 75))

    Ui.PopupBox(translations["update_available"],
                translations["update_would_you_like_to"], [YesButton, NoButton])


def CheckForUpdates() -> bool:
    Log("Checking for updates...")
    clientUpdate = UP.CheckForNewClient()

    if clientUpdate["status"]:
        if clientUpdate["newRepo"] and (GVars.iol or GVars.iosd):
            NewClientNotifyPopup(clientUpdate)
        else:
            ClientUpdateBox(clientUpdate)
        return True

    if UP.CheckForNewFiles():
        ModFilesUpdateBox()
        return True

    return False


def Initialize() -> None:
    # Load the global variables
    GVars.init()
    # do the fancy log thing
    StartLog()
    # load the config file into memory
    GVars.LoadConfig()
    # load the client's translations
    LoadTranslations()

    # For pasting on Steam Deck
    # Thankfully doesn't need to be installed as its preinstalled on Steam Deck
    if GVars.iosd:
        import PyQt5

    # checks if this is a dev or release build
    if sys.argv[0].endswith(".py"):
        Log("Running through Python! Not checking for updates.")
        return

    IsNew()  # Check for first time setup after update

    # remove old temp files
    if (os.path.exists(GVars.modPath + os.sep + ".temp")):
        BF.DeleteFolder(GVars.modPath + os.sep + ".temp")


def PostInitialize() -> None:
    # only check for updates if the user is not running from source
    if not sys.argv[0].endswith(".py"):
        CheckForUpdates()

    VerifyGamePath()

    def NewAfterFunction() -> None:
        Ui.Error(translations["game_exited"], 5, (125, 0, 125))
        if (GVars.configData["Auto-Unmount"]["value"]):
            UnmountScript()
            Ui.Error(translations["unmounted_error"], 5, (125, 0, 125))

    GVars.AfterFunction = NewAfterFunction

    if (GVars.HadToResetConfig):
        Log("Config has been reset to default settings!")
        OkButton = Ui.ButtonModel(
            translations["error_ok"], activeColor=(75, 255, 75))
        Ui.PopupBox(translations["launcher_config_reset"],
                    translations["launcher_had_to_reset"], [OkButton])


if __name__ == '__main__':
    try:
        cwd = os.getcwd()
        Initialize()
        Ui = Gui(GVars.configData["Dev-Mode"]["value"])
        PostInitialize()
        Ui.Main()

    except Exception as e:
        Log("=============")
        Log("__________FATAL LAUNCHER ERROR!!!__________")
        Log("Exception encountered:\n" + str(e))
        Log("__________FATAL LAUNCHER ERROR!!!__________")
