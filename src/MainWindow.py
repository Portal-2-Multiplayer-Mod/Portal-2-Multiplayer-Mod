import json
import os
import random
import subprocess
import sys
import threading
import time
import webbrowser
import traceback

import __main__
import pygame
import pyperclip
from pygame.locals import *
from steamid_converter import Converter

import Scripts.BasicFunctions as BF
import Scripts.Configs as cfg
import Scripts.GlobalVariables as GVars
import Scripts.RunGame as RG
import Scripts.Updater as UP
import Scripts.Workshop as workshop
from Scripts.BasicLogger import Log, StartLog

from Models.FloaterModel import Floater
from Models.ButtonModel import ButtonTemplate
from Models.DisplayTextModel import DisplayText
from Models.SettingsEntryModel import curkeyButton

# set current directory to the directory of this file
os.chdir(os.path.dirname(os.path.abspath(__file__)))


class Gui:
    def __init__(self, devMode: bool) -> None:
        pygame.mixer.pre_init(channels=1)
        pygame.init()
        pygame.mixer.init()

        self.hvrclksnd = pygame.mixer.Sound("GUI/assets/sounds/hoverclick.wav")
        self.hvrclksnd.set_volume(0.05)

        # public variables
        self.CoolDown: int = 0
        self.CurInput: str = ""
        self.ErrorList: list = []
        self.InputPrompt: list = []
        self.PromptBreaks: int = 0
        self.HasBreaks: bool = False
        self.PlayersMenu: list = []
        self.DirectoryMenu: list = []
        self.DirectoryMenuText: list = []
        self.PopupBoxList: list = []
        self.LanguagesMenu: list[ButtonTemplate] = []
        self.IsUpdating: bool = False
        self.AfterInputFunction = None
        self.SettingsButtons: list = []
        self.SecAgo: float = time.time()
        self.SelectedPopupButton: ButtonTemplate
        self.LookingForInput: bool = False
        self.CurrentSelectedPlayer: int = 0
        self.FloatingCubesList: list[Floater] = []

    ###############################################################################
        # The resolution of the launcher when it opens,
        # why the height is 800 is to accomidate the Steam Decks resolution
        # if launching the launcher in Gaming Mode or without a monitor
        self.screen = pygame.display.set_mode((1280, 800), RESIZABLE)
        self.fpsclock = pygame.time.Clock()
        self.devMode: bool = devMode
        self.running: bool = True
        self.FPS: int = 60
        # REMEMBER TO CHANGE THIS BEFORE RELEASEING A NEW VERSION OF THE LAUNCHER
        self.currentVersion: str = UP.currentVersion

        # Define the name and image of the window
        pygame.display.set_caption('Portal 2: Multiplayer Mod Launcher')
        self.p2mmlogo = pygame.image.load(
            "GUI/assets/images/p2mm64.ico").convert_alpha()
        pygame.display.set_icon(self.p2mmlogo)

        # The cube floaters for the launcher screen
        self.CubeGreenAsset = pygame.image.load(
            "GUI/assets/images/greencube.png").convert_alpha()
        self.CubeRedAsset = pygame.image.load(
            "GUI/assets/images/redcube.png").convert_alpha()
        self.CubeGoldAsset = pygame.image.load(
            "GUI/assets/images/yellowcube.png").convert_alpha()

        ###############################################################################

        self.DefineMainMenu()
        self.DefineSettingsMenu()
        self.DefineWorkshopMenu()
        self.DefineManualMountingMenu()
        self.DefineResourcesMenu()
        self.DefineTestingMenu()

        self.CurrentButtonIndex: int = 0
        self.CurrentMenuButtons: list = self.MainMenuButtons
        self.CurrentMenuText: list = self.MainMenuText
        self.SelectedButton: ButtonTemplate = self.CurrentMenuButtons[self.CurrentButtonIndex]

        # Add the cubes onto the launcher screen
        for i in range(9):
            self.AddFloater(50, 50, 20, 75, 75)

    def PlaySound(self, sound: pygame.mixer.Sound) -> None:
        """Plays the launcher's sounds when hovering / clicking on a button
        Args:
            sound (pygame.mixer.Sound): the sound to play
        """

        LauncherSFX = GVars.configsData["Launcher-SFX"]["value"]
        if LauncherSFX:
            pygame.mixer.Sound.play(sound)

    def AddFloater(self, width: float, height: float, rotation: float, posX: float, posY: float) -> None:
        """Creates the falling cubes and adds them to a list of floaters

        Args:
            width (float): the widh of the cube's image
            height (float): the height of the cube's image
            rot (float): the rotation of the cube on the z axis when it spawns
            x (float): the x position where it first spawns
            y (float): the y position where it first spawns
        """
        surf = self.CubeGreenAsset
        surf = pygame.transform.scale(surf, (width, height))
        surf = pygame.transform.rotate(surf, 0)

        negrot = random.randint(0, 1) == 1

        floater = Floater(rotation, surf, posX, posY, negrot)

        self.FloatingCubesList.append(floater)

    #!############################
    #! Declaring buttons
    #!############################

    def DefineMainMenu(self) -> None:
        # * Buttons
        Button_LaunchGame = ButtonTemplate(
            Translations["play_button"], self.Button_LaunchGame_func, (50, 255, 120), isAsync=True)
        Button_Settings = ButtonTemplate(
            Translations["settings_button"], self.Button_Settings_func)
        Button_Update = ButtonTemplate(
            Translations["update_button"], self.Button_Update_func, (255, 0, 255), isAsync=True)
        Button_ManualMode = ButtonTemplate(
            Translations["manual_mounting_button"], self.Button_ManualMode_func)
        Button_Workshop = ButtonTemplate(
            Translations["workshop_button"], self.Button_Workshop_func, (14, 216, 235))
        Button_ResourcesMenu = ButtonTemplate(
            Translations["resources_button"], self.Button_ResourcesMenu_func, (75, 0, 255))
        Button_Exit = ButtonTemplate(
            Translations["exit_button"], self.Button_Exit_func, (255, 50, 50), isAsync=True, selectanim="none")

        self.MainMenuButtons = [Button_LaunchGame, Button_Settings,
                                Button_Update, Button_ManualMode, Button_Workshop, Button_ResourcesMenu]

        # * text
        Text_MainMenuText = DisplayText(Translations["welcome"], textColor=(
            255, 234, 0), posX=750, endX=1870, posY=20, size=75)
        Text_LauncherVersionText = DisplayText(
            Translations["version"] + self.currentVersion, textColor=(255, 234, 0), posX=75, endX=750, posY=770)

        self.MainMenuText = [Text_MainMenuText, Text_LauncherVersionText]

        if self.devMode:
            Button_Test = ButtonTemplate("Test Button", self.Button_Test_func)
            Text_DevMode = DisplayText(Translations["dev_mode_enabled"], textColor=(
                255, 0, 0), posX=75, endX=750, posY=735)

            self.MainMenuButtons.append(Button_Test)
            self.MainMenuText.append(Text_DevMode)

        self.MainMenuButtons.append(Button_Exit)

        # * We don't need the back button in the main menu but I thought it will be better the declare it here -Cabiste
        self.Button_Back = ButtonTemplate(
            Translations["back_button"], self.Button_Back_func)

    def DefineSettingsMenu(self) -> None:
        # * buttons
        Button_LauncherSettingsMenu = ButtonTemplate(
            Translations["launcher_settings_button"], self.Button_LauncherSettingsMenu_func)
        Button_Portal2Settings = ButtonTemplate(
            Translations["portal2_config_button"], self.Button_Portal2Settings_func)
        Button_AdminsMenu = ButtonTemplate(
            Translations["admin_button"], self.Button_AdminsMenu_func, (0, 255, 255))
        Button_LanguageMenu = ButtonTemplate(
            Translations["languages_button"], self.Button_LanguageMenu_func, (175, 75, 0))
        Button_ResetConfig = ButtonTemplate(
            "RESET CONFIG!", self.Button_ResetConfig_func, (255, 0, 0))

        self.SettingsMenus = [Button_LauncherSettingsMenu,
                              Button_Portal2Settings,
                              Button_AdminsMenu,
                              Button_LanguageMenu,
                              Button_ResetConfig]

        # * helper text
        Text_SettingsLaunchText = DisplayText(Translations["language_menu_launch_text"], textColor=(
            255, 234, 0), posX=40, endX=1000, posY=540, size=75)
        Text_SettingsPortal2Text = DisplayText(Translations["language_menu_portal2_text"], textColor=(
            255, 234, 0), posX=40, endX=1000, posY=620, size=75)
        Text_SettingsPlayersText = DisplayText(Translations["language_menu_players_text"], textColor=(
            255, 234, 0), posX=40, endX=1000, posY=700, size=75)
        self.SettingsMenuText = [Text_SettingsLaunchText,
                                 Text_SettingsPortal2Text,
                                 Text_SettingsPlayersText]

        if self.devMode:
            Button_HiddenSettings = ButtonTemplate(
                Translations["dev_settings_button"], self.Button_DevSettings_func, (255, 0, 0))
            self.SettingsMenus.append(Button_HiddenSettings)

        self.SettingsMenus.append(self.Button_Back)

    def DefineManualMountingMenu(self) -> None:
        Button_ManualMount = ButtonTemplate(
            Translations["mount_button"], self.Button_ManualMount_func, (50, 255, 120), isAsync=True)
        Button_ManualUnmount = ButtonTemplate(
            Translations["unmount_button"], self.Button_ManualUnmount_func, (255, 50, 50), isAsync=True)

        self.ManualButtons = [Button_ManualMount,
                              Button_ManualUnmount,
                              self.Button_Back]

    def DefineWorkshopMenu(self) -> None:
        Button_GetWorkShopCommand = ButtonTemplate(
            Translations["get_level_button"], self.Button_GetWorkShopCommand_func)
        self.WorkshopButtons = [Button_GetWorkShopCommand, self.Button_Back]

        Text_WorkshopMenuInfo = DisplayText(Translations["workshop_menu_info"], textColor=(
            255, 234, 0), posX=75, endX=1100, posY=220, size=70)
        self.WorkshopMenuText = [Text_WorkshopMenuInfo]

    def DefineResourcesMenu(self) -> None:
        Button_GitHub = ButtonTemplate(
            Translations["github_button"], self.Button_GitHub_func, (255, 255, 255), isAsync=True)
        Button_Guide = ButtonTemplate(
            Translations["guide_button"], self.Button_Guide_func, (35, 35, 50), isAsync=True)
        Button_Discord = ButtonTemplate(
            Translations["discord_server_button"], self.Button_Discord_func, (75, 75, 150), isAsync=True)

        self.ResourcesButtons = [Button_GitHub,
                                 Button_Guide,
                                 Button_Discord, self.Button_Back]

    def DefineTestingMenu(self) -> None:
        Button_InputField = ButtonTemplate(
            "User Input", self.Button_InputField_func)
        PopupBox_Gui = ButtonTemplate("Popup Box", self.PopupBox_test_func)
        Button_PrintToConsole = ButtonTemplate(
            "Print to Console", self.Button_PrintToConsole_func)

        self.TestMenu = [Button_InputField, PopupBox_Gui,
                         Button_PrintToConsole, self.Button_Back]

        Text_TestMenuTextTest1 = DisplayText(
            "displaytext: All default settings")
        Text_TestMenuTextTest2 = DisplayText(
            "displaytext2: textColor=(52, 67, 235), ypos=600", textColor=(52, 67, 235), posY=600)
        Text_TestMenuTextTest3 = DisplayText(
            "displaytext3: textColor=(214, 30, 17), xpos=600, xstart=600", textColor=(214, 30, 17), posX=600)
        Text_TestMenuTextTest4 = DisplayText(
            "displaytext4: textColor=(143, 222, 24), xpos=600, xstart=600, ypos=600", textColor=(143, 222, 24), posX=600, posY=600)
        Text_TestMenuTextTest5 = DisplayText("displaytext5: textColor=(255, 255, 0), xpos=600, xstart=600, xend=2000, ypos=300", textColor=(
            255, 255, 0), posX=600, endX=2000, posY=300)

        self.TestMenuText = [Text_TestMenuTextTest1, Text_TestMenuTextTest2,
                             Text_TestMenuTextTest3, Text_TestMenuTextTest4, Text_TestMenuTextTest5]

#######################################################################

    def gradientRect(self, window: pygame.Surface, left_colour: tuple, right_colour: tuple, target_rect: pygame.Rect) -> None:
        # tiny! 2x2 bitmap
        colour_rect = pygame.Surface((2, 2))
        # left colour line
        pygame.draw.line(colour_rect, left_colour, (0, 0), (0, 1))
        # right colour line
        pygame.draw.line(colour_rect, right_colour, (1, 0), (1, 1))

        # stretch!
        colour_rect = pygame.transform.smoothscale(
            colour_rect, (target_rect.width, target_rect.height))
        window.blit(colour_rect, target_rect)

    def BackMenu(self) -> None:
        if len(self.DirectoryMenu) > 0:
            self.ChangeMenu(self.DirectoryMenu.pop(),
                            self.DirectoryMenuText.pop(), False)

    # the button to go to the previous menu
    def Button_Back_func(self) -> None:
        self.BackMenu()

    def RefreshSettingsMenu(self, menuName: str) -> None:

        self.SettingsButtons.clear()

        for key in GVars.configsData:
            if GVars.configsData[key]["menu"] == menuName:
                self.SettingsButtons.append(
                    curkeyButton(key, self, menuName,
                                 {
                                     "name": Translations[key],
                                     "description": Translations[GVars.configsData[key]["description"]],
                                     "warning": Translations[GVars.configsData[key]["warning"]],
                                     "error_saved": Translations["error_saved"],
                                     "prompt": Translations[GVars.configsData[key]["prompt"]]
                                 }))

        self.SettingsButtons.append(self.Button_Back)

    def RefreshPlayersMenu(self) -> None:

        cfg.ValidatePlayerKeys()

        self.PlayersMenu.clear()
        PlayerKey = GVars.configsData["Players"]["value"][self.CurrentSelectedPlayer]
        print(PlayerKey)

        # displays and changes the player name
        def Button_PlayerName_func() -> None:
            def AfterInputPlayerName(inp: str) -> None:
                Log("Saving player name: " + inp)
                cfg.EditPlayer(self.CurrentSelectedPlayer, name=inp.strip())
                self.Error(Translations["error_saved"], 5, (75, 200, 75))
                self.RefreshPlayersMenu()

            self.GetUserInput(
                AfterInputPlayerName, Translations["players_enter_username"], PlayerKey["name"])

        Button_PlayerName = ButtonTemplate(
            Translations["players_name"] + PlayerKey["name"], Button_PlayerName_func, (255, 255, 120))

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
                            Translations["players_converted_steamid"], 5, (75, 120, 255))
                    except Exception as e:
                        self.Error(
                            Translations["players_invalid_steamid"], 5, (255, 50, 50))
                        Log(str(e))
                        return

                cfg.EditPlayer(self.CurrentSelectedPlayer, steamId=inp)
                self.Error(Translations["error_saved"], 5, (75, 200, 75))
                self.RefreshPlayersMenu()

            self.GetUserInput(
                AfterInputSteamID, Translations["players_enter_steamid"], PlayerKey["steamid"])

        Button_PlayerSteamId = ButtonTemplate(
            "SteamID: " + PlayerKey["steamid"], Button_PlayerSteamId_func, (255, 255, 120))

        # sets the admin level for th player
        def Button_AdminLevel_func() -> None:
            def AfterInputAdminLevel(inp: str) -> None:

                if not inp.isdigit():
                    self.Error(
                        Translations["players_admin_error_not-a-number"], 5, (255, 50, 50))
                    return

                if int(inp) > 6 or int(inp) < 0:
                    self.Error(
                        Translations["admin_level_error_out-of-range"], 5, (255, 255, 50))
                    return

                # here i'm converting to int then to str so it removes all the extra 0s on the left side (05 -> 5)
                cfg.EditPlayer(self.CurrentSelectedPlayer, level=str(int(inp)))
                self.Error(Translations["error_saved"], 5, (75, 200, 75))
                Log("Saving admin level as " + str(inp))
                self.RefreshPlayersMenu()

            self.GetUserInput(
                AfterInputAdminLevel, Translations["players_admin-enter-admin-level"], PlayerKey["adminlevel"])

        Button_AdminLevel = ButtonTemplate(
            Translations["players_admin_level"] + PlayerKey["adminlevel"], Button_AdminLevel_func, (255, 255, 120))

        # changes the view to the next player
        def Button_NextPlayer_func() -> None:

            if self.CurrentSelectedPlayer < len(GVars.configsData["Players"]["value"]) - 1:
                Log("Next player")
                self.CurrentSelectedPlayer += 1
            else:
                Log("No more players")
                self.CurrentSelectedPlayer = 0

            self.RefreshPlayersMenu()
            self.ChangeMenu(self.PlayersMenu, append=False)

        Button_NextPlayer = ButtonTemplate(
            Translations["players_next_button"], Button_NextPlayer_func, (255, 255, 120))

        # adds a player to the list
        def Button_AddPlayer_func() -> None:
            cfg.AddPlayer()
            self.CurrentSelectedPlayer = len(
                GVars.configsData["Players"]["value"]) - 1
            self.RefreshPlayersMenu()

        Button_AddPlayer = ButtonTemplate(
            Translations["players_add_player"], Button_AddPlayer_func, (120, 255, 120))

        # deletes a player from the list
        def Button_DeletePlayer_func() -> None:

            if len(GVars.configsData["Players"]["value"]) <= 1:
                self.Error(
                    Translations["players_error_must_be_at_least_one_player"], 5, (255, 50, 50))
                return

            Log("Deleting player...")
            cfg.DeletePlayer(self.CurrentSelectedPlayer)
            self.CurrentSelectedPlayer -= 1
            self.RefreshPlayersMenu()

        Button_DeletePlayer = ButtonTemplate(
            Translations["players_remove_player"], Button_DeletePlayer_func, (255, 50, 50))

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
        if self.CoolDown > 0:
            return

        self.CoolDown = int(3 * self.FPS)
        RunGameScript()

    # Switches to the settings menu
    def Button_Settings_func(self) -> None:
        self.ChangeMenu(self.SettingsMenus, self.SettingsMenuText)

    # Checks for any updates for the launcher
    def Button_Update_func(self) -> None:
        if self.CoolDown > 0:
            return

        self.CoolDown = int(3 * self.FPS) # 3 seconds

        if not CheckForUpdates():
            self.Error(
                Translations["update_already_up_to_date"], 5, (200, 75, 220))

    # Switches to the manual mod mounting and unmounting menu
    def Button_ManualMode_func(self) -> None:
        self.ChangeMenu(self.ManualButtons)

    # Switches to the workshop menu, where you can get the changelevel command for workshop maps
    def Button_Workshop_func(self) -> None:
        self.ChangeMenu(self.WorkshopButtons, self.WorkshopMenuText)

    # Switches to the resources menu, access to links to the GitHub Repo, P2MM Discord, etc
    def Button_ResourcesMenu_func(self) -> None:
        self.ChangeMenu(self.ResourcesButtons)

    # Performs a clean close of the launcher, it will close down and unmount Portal 2 if it's open
    def Button_Exit_func(self) -> None:
        self.running = False

    #!############################
    #! SETTINGS BUTTONS FUNCTIONS
    #!############################

    # Switches to the Launcher Settings
    def Button_LauncherSettingsMenu_func(self) -> None:
        self.RefreshSettingsMenu("launcher")
        self.ChangeMenu(self.SettingsButtons)

    # Switches to the Portal 2 Settings
    def Button_Portal2Settings_func(self) -> None:
        self.RefreshSettingsMenu("portal2")
        self.ChangeMenu(self.SettingsButtons)

    # Switches to the Player menu where you can add admins
    def Button_AdminsMenu_func(self) -> None:
        self.RefreshPlayersMenu()
        self.ChangeMenu(self.PlayersMenu)

    # Switches to the Language menu where you can pick a language for the launcher
    def Button_LanguageMenu_func(self) -> None:
        # for choosing a languages
        self.LanguageButton()
        self.ChangeMenu(self.LanguagesMenu)

    def Button_ResetConfig_func(self) -> None:
        def reset():
            cfg.WriteConfigFile(cfg.DefaultConfigFile)
            GVars.configsData = cfg.DefaultConfigFile

        ButtonYes = ButtonTemplate(Translations["error_yes"], reset, (75, 255, 75))
        ButtonNo = ButtonTemplate(Translations["error_no"], None, (255, 75, 75))

        Ui.PopupBox(Translations["launcher_config_reset"],
                    Translations["ask_for_reset"], [ButtonYes, ButtonNo])

    # Access to the launchers Developer settings
    def Button_DevSettings_func(self) -> None:
        self.RefreshSettingsMenu("dev")
        self.ChangeMenu(self.SettingsButtons)

    #!############################
    #! MANUAL MODE BUTTONS FUNCTIONS
    #!############################

    # Button to manually mount P2MM

    def Button_ManualMount_func(self) -> None:
        if self.CoolDown > 0:
            return

        self.CoolDown = int(3 * 60)
        MountModOnly()

    # Button to manually unmount P2MM
    def Button_ManualUnmount_func(self) -> None:
        if self.CoolDown > 0:
            return

        self.CoolDown = int(3 * 60)
        UnmountScript()
        Ui.Error(Translations["unmounted_error"], 5, (125, 0, 125))

    #!############################
    #! WORKSHOP BUTTONS FUNCTIONS
    #!############################

    # Get's the id from a map's url then copies the changelevel command to the clipboard
    def Button_GetWorkShopCommand_func(self) -> None:
        def AfterInput(input: str):
            map = workshop.MapFromSteamID(input)

            if map is not None:
                map = map.replace(".bsp", "")
                pyperclip.copy("changelevel " + map)
                self.Error(
                    Translations["workshop_changelevel_command"], 3, (255, 0, 255))
                self.Error(
                    Translations["workshop_copied_to_clipboard"], 3, (0, 255, 0))
                return

            self.Error(
                Translations["workshop_map_not_found"], 6, (255, 255, 0))

        self.GetUserInput(AfterInput, Translations["workshop_link"])

    #!############################
    #! RESOURCES BUTTONS FUNCTIONS
    #!############################

    # opens the github repo in the browser

    def Button_GitHub_func(self) -> None:
        # open the discord invite in the default browser
        webbrowser.open(
            "https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod")

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

        # if the last selected button was out of bound
        # then we set the last button in the new menu as the selected one
        if self.CurrentButtonIndex >= len(menu):
            self.CurrentButtonIndex = len(menu) - 1

        self.SelectedButton = self.CurrentMenuButtons[self.CurrentButtonIndex]

    ####################

    # this is a test for input fields
    def Button_InputField_func(self) -> None:
        def AfterInput(input) -> None:
            self.Error("Input: " + input, 3, (255, 255, 0))
        self.GetUserInput(
            AfterInput, "As you can see this text can \n go onto another line :)")

    # this is a test for popup boxes
    def PopupBox_test_func(self) -> None:
        def YesInput() -> None:
            self.Error("Let's go!!!", 3, (75, 255, 75))

        def NoInput() -> None:
            self.Error("Bruh...", 3, (255, 75, 75))

        Button_Confirm = ButtonTemplate(
            Translations["error_yes"], YesInput, (75, 200, 75))
        Button_Decline = ButtonTemplate(
            Translations["error_no"], NoInput, (255, 75, 75))
        self.PopupBox("Trolling Time!?!?!", "Have you given Cabiste an\naneruism today?",
                      [Button_Confirm, Button_Decline])

    # this is a test to print text to console
    def Button_PrintToConsole_func(self) -> None:
        print("Without Log():")
        print(GVars.modPath)
        print(GVars.configsPath)
        Log("With Log():")
        Log(GVars.modPath)
        Log(GVars.configsPath)

    ################################

    def SelectAnimation(self, btn: ButtonTemplate, anim: str) -> None:
        if anim == "pop":
            btn.curanim = "pop1"

    def RunAnimation(self, button: ButtonTemplate, anim: str) -> None:
        if anim == "pop1":
            if button.SizeMultiplier < 1.3:
                button.SizeMultiplier += 0.1
            else:
                button.curanim = "pop2"
        if anim == "pop2":
            if button.SizeMultiplier > 1:
                button.SizeMultiplier -= 0.1
            else:
                button.SizeMultiplier = 1
                button.curanim = ""

    # Displaying the "prompt" and "warning" fields when hovering over settings
    def BlitDescription(self,
                        txt: str,
                        x: float = None,
                        y: float = None,
                        clr: tuple = (255, 255, 255)) -> None:

        if x is None:
            x = self.screen.get_width() / 16
        if y is None:
            y = self.screen.get_height() / 16

        if (len(txt) > 0):
            text = pygame.font.Font(Translations["font"], int(int(
                int((int(self.screen.get_width() / 15) + int(self.screen.get_height() / 25)) / (len(txt) * 0.1))))).render(txt, True, clr)
            if not (self.LookingForInput):
                self.screen.blit(text, (x, y))

    def GetUserInput(self, afterfunc=None, prompt: list = [], preinput: str = "") -> None:

        Log("Getting user input...")
        self.LookingForInput = True
        self.CurInput = preinput

        # First it it needs to check for "\n"s in the prompt that is supplied
        # If there are then it will seperate each part of text into a list
        breaktxt = "\n"
        # Will tell the blit part of the code (line 1180) to blit it as multiple lines or not
        self.HasBreaks = False
        # Need to count how many lines there are to pass to the blit part of the code (line 1180)
        self.PromptBreaks = 0
        # We need to check if there even is "\n"s, if no it will be displayed as a single line
        if breaktxt in prompt:
            self.HasBreaks = True
            prompt = prompt.split("\n")
            for breaktxt in prompt:
                self.PromptBreaks += 1
                print(breaktxt)
                print(self.PromptBreaks)
            print(prompt)
            self.InputPrompt = prompt
        else:
            print(prompt)
            self.InputPrompt = str(prompt)

        self.AfterInputFunction = afterfunc
        Log("AfterInputFunction: " + str(self.AfterInputFunction))

    def Error(self, text: str, time: int = 3, color: tuple = (255, 75, 75)) -> None:
        Log(text)

        if "\n" not in text:
            self.ErrorList.append([text, time, color])
            return

        # if the text has newlines, split it up
        text = text.split("\n")
        for i in range(0, len(text)):
            self.ErrorList.append([text[i], time, color])

    def PopupBox(self, title: str, text: str, buttons: list[ButtonTemplate]) -> None:
        """a function to make a pop up window, you can add as many buttons as you wish

        Parameters
        ----------
        title : str
            the title of the window, this will be rendered at the top with big font

        text : str
            the body of the window, you can use `\\n` to return to line

        buttons : list[ButtonTemplate]
            a list of buttons for the user to choose between.
            first button is selected by default.
        """

        self.SelectedPopupButton = buttons[0]

        PopupBox = [title, text, buttons]
        Log("Creating popup box : " + str(title))
        self.PopupBoxList.append(PopupBox)

    # the language button (English, French, etc...)
    def Button_Language_func(self) -> None:
        lang: str = self.LanguagesMenu[self.CurrentButtonIndex].Text.replace(
            "→ ", "")
        Log("Language set: " + lang)
        cfg.EditConfig("Active-Language", lang)
        LoadTranslations()
        self.__init__(self.devMode)
        self.Error(Translations["language_error0_language_update"])

    def LanguageButton(self) -> None:
        self.LanguagesMenu.clear()
        Languages = GetAvailableLanguages()
        for language in Languages:
            if GVars.configsData["Active-Language"]["value"] == language:
                language = "→ " + language

            self.LanguagesMenu.append(ButtonTemplate(
                language, self.Button_Language_func, (150, 150, 255)))

        self.LanguagesMenu.append(self.Button_Back)

    ###############################################################################

    def Update(self) -> None:
        W = self.screen.get_width()
        H = self.screen.get_height()
        clr = (0, 0, 0)
        fntdiv: int = 32
        fntsize = int(W / fntdiv)
        mindiv = int(fntdiv / 1.25)

        # DEBUG

        # tempsurf = pygame.font.Font(translations["font"], int(int((int(W / 25) + int(H / 50)) / 1.5))).render("CuM", True, (255, 100, 255))
        # screen.blit(tempsurf, (mousex - tempsurf.get_width()/2, mousey - tempsurf.get_height()/2))

        # MENU 2 ELECTRIC BOOGALOO
        # loop through all buttons
        indx = 0

        for button in self.CurrentMenuButtons:
            button: ButtonTemplate = button
            indx += 1
            button.Width = int(button.Size / 27)
            button.Height = int(button.Size / 52)

            if button == self.SelectedButton:
                clr = button.ActiveColor
            else:
                clr = button.InactiveColor
            self.RunAnimation(button, button.curanim)

            text1 = pygame.font.Font(
                Translations["font"], (button.Width + button.Height)).render(button.Text, True, clr)

            if not (self.LookingForInput):
                self.screen.blit(
                    text1, (W / button.RelativePosX, (H / button.RelativePosY - (text1.get_height() / 2)) * (indx / 5.6)))
            button.CurrentPosX = W / button.RelativePosX
            button.CurrentPosY = ((H / button.RelativePosY) -
                                  (text1.get_height() / 2)) * (indx / 5.6)
            button.Width = text1.get_width()
            button.Height = text1.get_height()

        # DISPLAYING DISPLAYTEXT ON MENUS
        for displaytext in self.CurrentMenuText:
            displaytext: DisplayText = displaytext
            displaytext.Width = int(W / displaytext.Size)
            displaytext.Height = int(H / displaytext.Size)
            text = pygame.font.Font(
                Translations["font"], (displaytext.Width + displaytext.Height))
            # 2D array where each row is a list of words.
            words = [word.split(' ') for word in displaytext.Text.splitlines()]
            space = text.size(' ')[0]  # The width of a space.
            max_width = displaytext.EndX
            x = displaytext.posX
            y = displaytext.PosY
            # This code will wrap any text that goes off screen, thanks Stack Overflow for this :)
            for line in words:
                for word in line:
                    word_surface = text.render(
                        word, True, displaytext.TextColor)
                    word_width, word_height = word_surface.get_size()
                    if x + displaytext.StartX >= max_width:
                        x = displaytext.StartX  # Reset the x.
                        y += word_height  # Start on new row.
                    self.screen.blit(word_surface, (x, y))
                    x += word_width + space
                x = displaytext.StartX  # Reset the x.
                y += word_height  # Start on a new row.

        # BACKGROUND
        for floater in self.FloatingCubesList:
            surf = floater.Surface
            if (self.SelectedButton.Text == Translations["unmount_button"] or self.SelectedButton.Text == Translations["exit_button"]):
                surf = self.CubeRedAsset
            if (self.SelectedButton.Text == Translations["back_button"]):
                surf = self.CubeGoldAsset
            surf = pygame.transform.scale(surf, (W / 15, W / 15))
            surf = pygame.transform.rotate(surf, floater.Rotation)
            center = surf.get_rect().center
            LauncherCubes = GVars.configsData["Launcher-Cubes"]["value"]
            if (LauncherCubes):
                self.screen.blit(
                    surf, (floater.PosX - center[0], floater.PosY - center[1]))
            if floater.NegativeRotation:
                floater.Rotation -= (1 + random.randint(0, 2))
            else:
                floater.Rotation += (1 + random.randint(0, 2))
            if (self.SelectedButton.Text == Translations["back_button"]):
                floater.PosX -= W / 60
                if floater.PosX < (floater.Surface.get_width() * -2):
                    floater.PosY = random.randint(0, H)
                    floater.PosX = (floater.Surface.get_width() * 2) + \
                        (random.randint(W, W * 2)) * 1
                    floater.NegativeRotation = random.randint(0, 1) == 1
            elif (self.SelectedButton.Text == Translations["unmount_button"] or self.SelectedButton.Text == Translations["exit_button"]):
                floater.PosY -= H / 60
                if floater.PosY < (floater.Surface.get_height() * -2):
                    floater.PosY = (floater.Surface.get_height() * 2) + \
                        (random.randint(H, H * 2))
                    floater.PosX = random.randint(0, W)
                    floater.NegativeRotation = random.randint(0, 1) == 1
            else:
                floater.PosY += H / 60
                if floater.PosY > (H + floater.Surface.get_height() * 2):
                    floater.PosY = (floater.Surface.get_height() * -2) + \
                        (random.randint(0, H)) * -1
                    floater.PosX = random.randint(0, W)
                    floater.NegativeRotation = random.randint(0, 1) == 1

        if (not self.LookingForInput):
            if GVars.isSteamDeck:
                # Puts assets/images/buttons.png on the bottom right corner of the screen
                buttons = pygame.image.load(
                    "GUI/assets/images/buttons.png").convert_alpha()
                buttons = pygame.transform.scale(buttons, (W / 10, W / 10))
                self.screen.blit(
                    buttons, ((W / 1.03) - buttons.get_width(), H / 1.22))
            else:
                # Puts assets/images/keys.png on the bototm right corner of the screen
                keys = pygame.image.load(
                    "GUI/assets/images/keys.png").convert_alpha()
                keys = pygame.transform.scale(keys, (W / 10, W / 10))
                self.screen.blit(
                    keys, ((W / 1.03) - keys.get_width(), H / 1.22))

        # MENU

        self.SelectedButton = self.CurrentMenuButtons[self.CurrentButtonIndex]

        # OVERLAY

        indx = 0
        for error in self.ErrorList[::-1]:
            indx += 1
            errortext = pygame.font.Font(
                Translations["font"],
                int(int(W / 60) + int(H / 85))
            ).render(error[0], True, error[2])

            self.screen.blit(
                errortext, (W / 30, ((errortext.get_height() * indx) * -1) + (H / 1.05)))

        # every 1 second go through each error and remove it if it's been there for more than 1 second
        if (time.time() - self.SecAgo) > 1:
            for error in self.ErrorList:
                if (error[1] < 0):
                    self.ErrorList.remove(error)
                error[1] -= 1
            self.SecAgo = time.time()

        try:
            # if self.CurrentMenu == setti
            self.SelectedButton.WhileSelectedfunction(self)

        except Exception as e:
            # Log(str(e))
            pass

        # DRAW POPUP BOX
        if len(self.PopupBoxList) > 0:
            sz = 1.25

            # draw a white box that is half the width and height of the screen
            boxBackground = pygame.Surface((W / sz, W / (sz * 2)))
            boxBackground.fill((255, 255, 255))
            boxBackground.set_alpha(175)
            self.screen.blit(boxBackground, (W / 2 - (boxBackground.get_width() / 2),
                             H / 2 - (boxBackground.get_height() / 2)))

            bw = boxBackground.get_width()
            bh = boxBackground.get_height()
            bx = W / 2 - (bw / 2)
            by = H / 2 - (bh / 2)

            # put the title in the box
            boxtitle = pygame.font.Font(Translations["font"], fntsize).render(self.PopupBoxList[0][0], True,
                                                                              (255, 255, 0))
            titlew = boxtitle.get_width()
            titleh = boxtitle.get_height()
            titlex = bx + (bw / 2) - (titlew / 2)
            titley = by + (titleh / 2)
            self.screen.blit(boxtitle, (titlex, titley))

            # put the text in the box
            ctext = self.PopupBoxList[0][1].split("\n")
            indx = 0
            for line in ctext:
                text = pygame.font.Font(
                    Translations["font"], int(fntsize / 1.5)).render(line, True, (0, 0, 0))
                textw = text.get_width()
                texth = text.get_height()
                textx = bx + (bw / 2) - (textw / 2)
                texty = by + (titleh * 2) + (texth * indx)
                self.screen.blit(text, (textx, texty))
                indx += 1

            # put the buttons in the box
            amtob = len(self.PopupBoxList[0][2])
            indx = 0
            for button in self.PopupBoxList[0][2]:
                button: ButtonTemplate = button
                buttonsurf = pygame.surface.Surface(
                    ((bw / amtob) / 1.2, (bh / 5)))
                if (button == self.SelectedPopupButton):
                    buttonsurf.fill(button.ActiveColor)
                else:
                    buttonsurf.fill(button.InactiveColor)
                surfw = buttonsurf.get_width()
                surfh = buttonsurf.get_height()
                surfx = bx + (bw / amtob) * indx + \
                    (bw / amtob) / 2 - (surfw / 2)
                surfy = by + bh - (bh / 4)
                button.CurrentPosX = surfx
                button.CurrentPosY = surfy
                button.Width = surfw
                button.Height = surfh
                self.screen.blit(buttonsurf, (surfx, surfy))

                text = pygame.font.Font(Translations["font"], int(
                    fntsize / 1.5)).render(button.Text, True, (255, 255, 255))
                textw = text.get_width()
                texth = text.get_height()
                textx = bx + (bw / amtob) * (indx) + \
                    ((bw / amtob) / 2) - (textw / 2)
                texty = by + bh - (bh / 5) + (texth / 2)
                self.screen.blit(text, (textx, texty))
                indx += 1

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
                    Translations["font"], fntsize).render(lines[i], True, (255, 255, 175))
                self.screen.blit(InputText, (W / 2 - (InputText.get_width() / 2), (
                    (((H / 2) - (InputText.get_height() * 1.25)) + ((text1.get_height() * 1.25) * i))) - (
                    (((text1.get_height() * 1.25) * (len(lines) / 2))))))

            surf1 = pygame.Surface((W / 1.5, W / 100))
            surf1.fill((255, 255, 255))
            surf2 = pygame.Surface((W / 1.5, W / 100))
            blitpos = (
                (W / 2) - (surf2.get_width() / 2), (H / 2) + ((InputText.get_height() * 1.725) * ((len(lines) / 2) - 1)))
            self.screen.blit(surf1, blitpos)
            # We need to check if breaks were detected before in the prompt part of the code (line 868)
            if self.HasBreaks == True:
                for breaks in range(0, self.PromptBreaks):
                    surfInputPrompt = pygame.font.Font(Translations["font"],
                                                       int(fntsize/1.5)).render(self.InputPrompt[breaks], True, (255, 255, 255))

                    # blit it right below the surf1
                    self.screen.blit(surfInputPrompt,
                                     (blitpos[0] + (surf1.get_width() / 2) - (surfInputPrompt.get_width() / 2),
                                      ((blitpos[1] + 15) + (surfInputPrompt.get_height() * breaks))))
            else:
                surfInputPrompt = pygame.font.Font(Translations["font"],
                                                   int(fntsize/1.5)).render(self.InputPrompt, True, (255, 255, 255))

                # blit it right below the surf1
                self.screen.blit(surfInputPrompt,
                                 (blitpos[0] + (surf1.get_width() / 2) - (surfInputPrompt.get_width() / 2),
                                  (blitpos[1] + surfInputPrompt.get_height())))

    ###############################################################################

    def Main(self) -> None:
        LastBackspace = 0
        updateCount = 0
        while self.running:
            mouse = pygame.mouse.get_pos()
            mousex = mouse[0]
            mousey = mouse[1]

            # make the screen a gradient
            self.screen.fill((0, 0, 0))
            self.gradientRect(self.screen, (0, 2, 10), (2, 2, 10), pygame.Rect(
                0, 0, self.screen.get_width(), self.screen.get_height()))
            self.Update()
            pygame.display.update()
            self.fpsclock.tick(self.FPS)

            if self.CoolDown > 0:
                self.CoolDown -= 1

            # so you can hold backspace to delete
            if (self.LookingForInput):
                BACKSPACEHELD = pygame.key.get_pressed()[pygame.K_BACKSPACE]
                if (BACKSPACEHELD):
                    LastBackspace += 0.25
                # if its been a second since the last backspace, delete the last character
                if (LastBackspace >= 1):
                    if (len(self.CurInput) > 0):
                        self.CurInput = self.CurInput[:-1]
                    LastBackspace = 0

            for event in pygame.event.get():
                if event.type == QUIT:
                    self.running = False

                if (self.LookingForInput):
                    CTRLHELD = pygame.key.get_mods() & pygame.KMOD_CTRL
                    SHIFTHELD = pygame.key.get_mods() & pygame.KMOD_SHIFT
                    if event.type == pygame.KEYDOWN:
                        # get the key and add it to self.CurInput
                        name = pygame.key.name(event.key)

                        if name == "space":
                            self.CurInput += " "
                        elif name in ["return", "enter"]:
                            self.LookingForInput = False
                            self.AfterInputFunction(self.CurInput)
                        elif name == "escape":
                            self.LookingForInput = False
                        elif name == "tab":
                            self.CurInput += "    "
                        elif CTRLHELD and name == "v":
                            try:
                                pastedstr = str(
                                    pyperclip.paste().replace("\n", ""))
                                self.CurInput += pastedstr
                                Log(f"Pasted: {pastedstr}")
                            except Exception as e:
                                Log(str(e))  # Log a error in case it fails
                                pass
                        elif len(name) == 1:
                            if SHIFTHELD:
                                # if the name doesnt contain a letter
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
                    boxlen = len(self.PopupBoxList[0][2])
                    if event.type == KEYDOWN:
                        if event.key == K_ESCAPE:
                            self.PopupBoxList.pop()

                        if event.key == K_RIGHT:
                            for btn in self.PopupBoxList[0][2]:
                                if btn == self.SelectedPopupButton:
                                    if self.PopupBoxList[0][2].index(btn) < boxlen - 1:
                                        self.SelectedPopupButton = self.PopupBoxList[0][2][self.PopupBoxList[0][2].index(
                                            btn) + 1]

                        elif event.key == K_LEFT:
                            for btn in self.PopupBoxList[0][2]:
                                if btn == self.SelectedPopupButton:
                                    if self.PopupBoxList[0][2].index(btn) > 0:
                                        self.SelectedPopupButton = self.PopupBoxList[0][2][self.PopupBoxList[0][2].index(
                                            btn) - 1]

                        elif event.key == K_SPACE or event.key == K_RETURN:
                            self.SelectedPopupButton.Function()
                            self.PopupBoxList.pop()

                    elif event.type == MOUSEBUTTONDOWN:
                        # if the mouse is over a button
                        for btn in self.PopupBoxList[0][2]:
                            if (btn.CurrentPosX < mousex < btn.CurrentPosX + btn.Width) and (btn.CurrentPosY < mousey < btn.CurrentPosY + btn.Height):
                                self.SelectedPopupButton = btn
                                self.SelectedPopupButton.Function()
                                self.PopupBoxList.pop()
                                break

                # Keyboard Navigation
                if (not self.LookingForInput):
                    if event.type == KEYDOWN:
                        if event.key in [K_ESCAPE]:
                            self.BackMenu()
                            continue

                        elif event.key in [K_SPACE]:
                            self.SelectAnimation(
                                self.SelectedButton, self.SelectedButton.selectanim)

                            if self.SelectedButton.Function:
                                if self.SelectedButton.IsAsync:
                                    threading.Thread(
                                        target=self.SelectedButton.Function).start()
                                else:
                                    self.SelectedButton.Function()

                            self.PlaySound(self.SelectedButton.selectsnd)
                            continue

                        elif event.key in [K_DOWN, K_s]:
                            if self.CurrentButtonIndex < len(self.CurrentMenuButtons) - 1:
                                self.CurrentButtonIndex += 1
                            else:
                                self.CurrentButtonIndex = 0

                        elif event.key in [K_UP, K_w]:
                            if self.CurrentButtonIndex > 0:
                                self.CurrentButtonIndex -= 1
                            else:
                                self.CurrentButtonIndex = len(
                                    self.CurrentMenuButtons) - 1

                        self.SelectedButton: ButtonTemplate = self.CurrentMenuButtons[
                            self.CurrentButtonIndex]
                        self.PlaySound(self.SelectedButton.HoverSound)

                # LMB
                # executes the button's function on left mouse click IF the mouse is above the button
                if event.type == pygame.MOUSEBUTTONDOWN:
                    if event.button == 1:
                        button = self.SelectedButton
                        if (mousex > button.CurrentPosX and mousex < button.CurrentPosX + button.Width) and (mousey > button.CurrentPosY and mousey < button.CurrentPosY + button.Height):
                            if self.SelectedButton.Function:
                                if self.SelectedButton.IsAsync:
                                    threading.Thread(
                                        target=self.SelectedButton.Function).start()
                                else:
                                    self.SelectedButton.Function()

                            self.SelectAnimation(
                                self.SelectedButton, self.SelectedButton.selectanim)

                            self.PlaySound(self.SelectedButton.selectsnd)

                ###############################
                # changes the `SelectedButton` and the `CurrentButtonsIndex` to the button the mouse is on
                if event.type == pygame.MOUSEMOTION:
                    for button in self.CurrentMenuButtons:
                        button: ButtonTemplate = button
                        # if the mouse is over the button
                        if (mousex > button.CurrentPosX and mousex < button.CurrentPosX + button.Width) and (mousey > button.CurrentPosY and mousey < button.CurrentPosY + button.Height):
                            # if the button isnt already selected
                            if button != self.SelectedButton:
                                # select the button
                                self.SelectedButton = button
                                # set current buttons index to the button
                                self.CurrentButtonIndex = self.CurrentMenuButtons.index(
                                    button)
                                # play the hover sound
                                self.PlaySound(self.hvrclksnd)

            ###############################
            # changes the color of the hovered button in the popup box
            if len(self.PopupBoxList) > 0:
                for button in self.PopupBoxList[0][2]:
                    button: ButtonTemplate = button
                    # if the mouse is over the button
                    if ((mousex > button.CurrentPosX and mousex < button.CurrentPosX + (button.Size / 25)) and (mousey > button.CurrentPosY and mousey < button.CurrentPosY + (button.Size / 50))):
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

    # Windows
    if (GVars.isWin):
        os.system("taskkill /f /im portal2.exe")

    # Linux and Steam Deck/SteamOS 3.0
    if (GVars.isLinux):
        os.system("killall -9 portal2_linux")

    # This waits to make sure the Portal 2 thread is dead
    # 1 second should be enough for it to die
    time.sleep(1)
    Log("Portal 2 has been shutdown...")

    # Make sure the P2MM ModFiles are unmounted from Portal 2
    if (GVars.configsData["Auto-Umount"]["value"]):
        Log("Unmounting P2MM's ModFiles from Portal 2...")
        UnmountScript(False)
        Ui.Error(Translations["unmounted_error"], 5, (125, 0, 125))
        Log("Unmounted P2MM's ModFiles from Portal 2...")

    Log("The P2MM launcher has been shutdown...")


def GetGamePath() -> None:
    tmpp = BF.TryFindPortal2Path()

    if tmpp:
        cfg.EditConfig("Portal2-Path", tmpp.strip())
        Log("Saved '" + tmpp.strip() + "' as the game path!")
        Ui.Error(Translations["game_path_error-founded"], 5, (255, 255, 75))
        VerifyGamePath(False)
        return

    def AfterInputGP(inp: str) -> None:
        cfg.EditConfig("Portal2-Path", inp.strip())
        Log(f"Changed Value of 'Portal2-Path' to '{inp.strip()}'")
        Ui.Error(Translations["game_path_error-saved"], 5, (75, 200, 75))
        VerifyGamePath(False)

    Ui.GetUserInput(AfterInputGP, Translations["game_path_enter_path"])


def VerifyGamePath(shouldgetpath: bool = True) -> bool:
    Log("Verifying game path...")
    gamepath = GVars.configsData["Portal2-Path"]["value"]

    if not os.path.exists(gamepath):
        Ui.Error(Translations["game_path-is-invalid"])

        if shouldgetpath:
            Ui.Error(
                Translations["game_path-attempt-to-fetch"], 5, (255, 255, 75))
            GetGamePath()

        return False
    Log("Game path is valid...")
    return True


def VerifyModFiles() -> bool:
    Log("Searching for mod files in: " + GVars.modFilesPath)

    if (os.path.isdir(GVars.modFilesPath)) and (os.path.exists(GVars.modFilesPath + "/p2mm.identifier")):
        Log("Mod files found!")
        return True

    Log("Mod files not found!")
    return False


def DEVMOUNT() -> None:
    try:
        # delete the old modfiles
        Log("DEV: Deleteing p2mm/ModFiles...")
        print(GVars.mainFolderPath + "/ModFiles")
        BF.DeleteFolder(GVars.mainFolderPath + "/ModFiles")
    except Exception:
        Log("Error deleting the old mod files, below is the error that caused this:")
        Log(traceback.format_exc())

    # copy the one in the current directory to the modpath
    Log("DEV: Copying over files from src/ModFiles...")
    BF.CopyFolder(cwd + "/ModFiles", GVars.mainFolderPath + "/ModFiles")


def MountModOnly() -> bool:
    cfg.ValidatePlayerKeys()

    if Ui.IsUpdating:
        Ui.Error(Translations["update_is-updating"], 5, (255, 75, 75))
        return False

    if not VerifyGamePath():
        return False

    Ui.Error(Translations["mounting_mod"], 5, (75, 255, 75))

    # Need to make sure the gamepath is in fact defined if not P2MM will not be run/mounted
    gamepath = GVars.configsData["Portal2-Path"]["value"]
    if ("undefined" in gamepath):
        Ui.Error(translations["mount_nopath_error"], 5, (255, 21, 0))
        return False

    # Check if both of Portal 2's DLC folders exist
    if not RG.CheckForRequiredDLC(gamepath):
        Ui.Error(Translations["mount_nodlc_error"], 5, (255, 21, 0))
        return False

    if (GVars.configsData["Dev-Mode"]["value"]):
        Ui.Error(Translations["devmode_is_active"], 5, (255, 180, 75))
        DEVMOUNT()
        Ui.Error(
            Translations["devmode_copied_from_local_repo"], 5, (75, 255, 75))

    if VerifyModFiles():
        DoEncrypt = GVars.configsData["Encrypt-Cvars"]["value"]
        RG.MountMod(gamepath, DoEncrypt)
        Ui.Error(Translations["mounted"], 5, (75, 255, 75))
        return True

    # If the they are not a developer and the mod files don't exist ask them to download the files from the repo
    if (os.path.exists(GVars.mainFolderPath + "/ModFiles")):
        BF.DeleteFolder(GVars.mainFolderPath + "/ModFiles")

    if not UP.haveInternet():
        def OkInput() -> None:
            Log("Downloading the latest mod files...")
            UpdateModFiles()

        OkButton = ButtonTemplate(
            Translations["error_ok"], OkInput, (75, 255, 75))
        Ui.Error(
            Translations["update_error_connection_problem"], 5, (255, 75, 75))
        Ui.PopupBox(Translations["update_error_connection_problem"],
                    Translations["no_internet_error"], OkButton)
        return False

    return True


def GetAvailableLanguages() -> list[str]:
    """Returns a list of all available translations.

    Returns
    -------
    list[str]
        List of languages available.
    """

    Log("searching for available languages")

    langs = []
    for file in os.listdir("Translations"):
        langs.append(file[:-5])

    customTranslationsPath = GVars.mainFolderPath + "/Translations"
    if os.path.exists(customTranslationsPath):
        for file in os.listdir(customTranslationsPath):
            langs.append(file[:-5])

    return langs


def LoadTranslations() -> dict:
    global Translations

    langPath = "Translations/" + \
        GVars.configsData["Active-Language"]["value"] + ".json"

    if not os.path.exists(langPath):
        langPath = GVars.mainFolderPath + "/" + langPath

    # Default to english if else failed
    if (not os.path.exists(langPath)):
        Log("[ERROR] Couldn't find translation file")
        cfg.EditConfig("Active-Language", "English")
        langPath = "Translations/English.json"

    Translations = json.load(open(langPath, "r", encoding="utf8"))


def UpdateModFiles() -> None:
    PreExit()
    Ui.Error(Translations["update_fetching"], 5000, (255, 150, 75))

    def UpdateThread() -> None:
        Log("Updating...")
        Ui.IsUpdating = True
        UP.DownloadNewFiles()
        Ui.Error(Translations["update_complete"], 5, (75, 255, 75))
        Ui.IsUpdating = False
        for thing in Ui.ErrorList:
            if thing[0] == Translations["update_fetching"]:
                Ui.ErrorList.remove(thing)

    threading.Thread(target=UpdateThread).start()


def UpdateModClient() -> None:
    PreExit()
    Ui.Error(Translations["updating_client"], 5000, (255, 150, 75))

    def UpdateThread() -> None:
        Log("Updating client...")
        Ui.IsUpdating = True

        if not UP.DownloadClient():
            Ui.Error(
                Translations["update_nolink_error"])
            return

        Ui.running = False
        Log("self.running set to false")

    threading.Thread(target=UpdateThread).start()


def RunGameScript() -> None:
    if MountModOnly():
        gamepath = GVars.configsData["Portal2-Path"]["value"]
        GVars.isGameActive = True
        RG.LaunchGame(gamepath)
        Ui.Error(Translations["game_launched"], 5, (75, 255, 75))
    else:
        Ui.Error(Translations["game_path_undefined_fetch"], 5)
        GetGamePath()


def UnmountScript(shouldgetpath: bool = True) -> None:
    Log("___Unmounting Mod___")
    VerifyGamePath(shouldgetpath)
    gamepath = GVars.configsData["Portal2-Path"]["value"]
    RG.DeleteUnusedDLCs(gamepath)
    RG.UnpatchBinaries(gamepath)
    Log("____DONE UNMOUNTING____")


def RestartClient(path: str = sys.executable) -> None:
    if (GVars.isLinux):
        permissioncommand = "chmod +x " + path
        os.system(permissioncommand)

    command = path
    subprocess.Popen(command, shell=True)
    Log("Restarting client")
    Ui.running = False

# checks if the client was downloaded by a previous version of itself


def IsNew() -> None:
    # Two arguements are passed when the client updates
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
    executable: str = os.path.abspath(sys.executable)
    os.rename(executable, sys.argv[2])
    RestartClient("\"" + sys.argv[2] + "\"")


def ClientUpdateBox(update: dict) -> None:
    YesButton = ButtonTemplate(
        Translations["error_yes"], UpdateModClient, (75, 200, 75))
    NoButton = ButtonTemplate(
        Translations["error_no"], activeColor=(255, 75, 75))

    Ui.PopupBox(update["name"], update["message"], [YesButton, NoButton])


def ModFilesUpdateBox() -> None:
    YesButton = ButtonTemplate(
        Translations["error_yes"], UpdateModFiles, (75, 200, 75))
    NoButton = ButtonTemplate(
        Translations["error_no"], activeColor=(255, 75, 75))

    Ui.PopupBox(Translations["update_available"],
                Translations["update_would_you_like_to"], [YesButton, NoButton])


def CheckForUpdates() -> bool:
    Log("Checking for updates...")
    clientUpdate = UP.CheckForNewClient()

    if clientUpdate["status"]:
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

    # checks if this is a dev or release build
    if sys.argv[0].endswith(".py"):
        Log("Running through Python! Not checking for updates.")
        return

    IsNew()  # Check for first time setup after update

    # remove old temp files
    if (os.path.exists(GVars.mainFolderPath + "/.temp")):
        BF.DeleteFolder(GVars.mainFolderPath + "/.temp")


def PostInitialize() -> None:
    # only check for updates if the user is not running from source
    if not sys.argv[0].endswith(".py"):
        CheckForUpdates()

    VerifyGamePath()

    def NewAfterFunction() -> None:
        Ui.Error(Translations["game_exited"], 5, (125, 0, 125))
        if (GVars.configsData["Auto-Umount"]["value"]):
            UnmountScript()
            Ui.Error(Translations["unmounted_error"], 5, (125, 0, 125))

    GVars.AfterFunction = NewAfterFunction

    if (GVars.resetConfig):
        Log("Config has been reset to default settings!")
        OkButton = ButtonTemplate(
            Translations["error_ok"], activeColor=(75, 255, 75), func=None)
        Ui.PopupBox(Translations["launcher_config_reset"],
                    Translations["launcher_had_to_reset"], [OkButton])


if __name__ == '__main__':
    # try:
    cwd = os.getcwd()
    Initialize()
    Ui = Gui(GVars.configsData["Dev-Mode"]["value"])
    PostInitialize()
    Ui.Main()
    # Called when a unexpected error results in a launcher crash
    # except Exception as e:
    #     Log("An error has occured: " + str(e))
