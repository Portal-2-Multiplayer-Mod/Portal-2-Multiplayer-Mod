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
import Scripts.Configs as cfg
import Scripts.GlobalVariables as GVars
import Scripts.RunGame as RG
import Scripts.Updater as up
import Scripts.Workshop as workshop
from Scripts.BasicLogger import Log, StartLog
import Scripts.SaveSystem as SS

tk = ""
try:
    from tkinter import Tk

    tk = Tk()
    tk.withdraw()
except Exception as e:
    Log(str(e))

# set current directory to the directory of this file
os.chdir(os.path.dirname(os.path.abspath(__file__)))


class Gui:
    def __init__(self, devMode: bool) -> None:
        pygame.mixer.pre_init(channels=1)
        pygame.init()
        pygame.mixer.init()

        self.hvrclksnd = pygame.mixer.Sound("GUI/assets/sounds/hoverclick.wav")
        self.hvrclksnd.set_volume(0.05)


        #! public variables
        self.coolDown: int = 0
        self.CurInput: str = ""
        self.ERRORLIST: list = []
        self.InputPrompt: str = ""
        self.PlayersMenu: list = []
        self.directorymenu: list = []
        self.PopupBoxList: list = []
        self.LanguagesMenu: list = []
        self.IsUpdating: bool = False
        self.AfterInputFunction = None
        self.SettingsButtons: list = []
        self.SecAgo: float = time.time()
        self.selectedpopupbutton: self.ButtonTemplate
        self.LookingForInput: bool = False
        self.CurrentSelectedPlayer: int = 0
        self.Floaters: list[self.Floater] = []

    ###############################################################################
        self.screen = pygame.display.set_mode((1280, 720), RESIZABLE)
        self.fpsclock = pygame.time.Clock()
        self.devMode: bool = devMode
        self.running: bool = True
        self.FPS: int = 60

        # Define the name and image of the window
        pygame.display.set_caption('Portal 2: Multiplayer Mod Launcher')
        self.p2mmlogo = pygame.image.load("GUI/assets/images/p2mm64.png").convert_alpha()
        # cubes
        self.greenCube = pygame.image.load("GUI/assets/images/button.png").convert_alpha()
        self.angrycube = pygame.image.load("GUI/assets/images/angrycube.png").convert_alpha()
        self.goldencube = pygame.image.load("GUI/assets/images/goldencube.png").convert_alpha()
        pygame.display.set_icon(self.p2mmlogo)

        ###############################################################################

        self.DefineMainMenuButtons()
        self.DefineSettingsMenuButtons()
        self.DefineSavesButton()
        self.DefineWorkshopButtons()
        self.DefineManualMountingButtons()
        self.DefineResourcesButtons()
        self.DefineTestingMenuButtons()

        self.CurrentButtonsIndex: int = 0
        self.CurrentMenu: list = self.MainButtons
        self.SelectedButton: self.ButtonTemplate = self.CurrentMenu[self.CurrentButtonsIndex]

        for i in range(9):
            self.AddFloater(50, 50, 20, 75, 75)

    # surf = pygame.surface.Surface([int(W / 25) + int(H / 50), int(W / 25) + int(H / 50)])
    #     surf.set_colorkey((0, 0, 0))
    #     surf.fill((255, 255, 255))
    #     surf = pygame.transform.rotate(surf, 19)

    def PlaySound(self, sound: pygame.mixer.Sound) -> None:
        LauncherSFX = GVars.configData["LauncherSFX"]["value"] == "true"
        if LauncherSFX:
            pygame.mixer.Sound.play(sound)

    class Floater:
        def __init__(self, rot: float, surf: pygame.Surface, x: float, y: float, negrot: bool) -> None:
            self.rot: float = rot
            self.surf: pygame.Surface = surf
            self.x: float = x
            self.y: float = y
            self.negrot: bool = negrot

    def AddFloater(self, width: float, height: float, rot: float, x: float, y: float) -> None:
        surf = self.greenCube
        surf = pygame.transform.scale(surf, (width, height))
        surf = pygame.transform.rotate(surf, 0)

        negrot = random.randint(0, 1) == 1

        floater = self.Floater(rot, surf, x, y, negrot)

        self.Floaters.append(floater)

    # BUTTON CLASS
    class ButtonTemplate:
        def __init__(self,
                     text: str,
                     func=_void,
                     activeColor: tuple = (255, 255, 0),
                     inactiveColor: tuple = (155, 155, 155),
                     sizemult: float = 1,
                     selectanim: str = "pop",
                     curanim: str = "",
                     isasync: bool = False,
                     x: float = 0,
                     y: float = 0,
                     width: float = 1000,
                     height: float = 5000) -> None:
            
            self.text = text
            self.function = func
            self.activecolor = activeColor
            self.inactivecolor = inactiveColor
            self.sizemult = sizemult
            self.selectanim = selectanim
            self.curanim = curanim
            self.isasync = isasync
            self.pwrsnd = pygame.mixer.Sound("GUI/assets/sounds/power.wav")
            self.pwrsnd.set_volume(0.25)
            self.blipsnd = pygame.mixer.Sound("GUI/assets/sounds/blip.wav")
            self.blipsnd.set_volume(0.25)
            self.selectsnd = self.pwrsnd
            self.hoversnd = self.blipsnd
            self.x = x
            self.y = y
            self.width = width
            self.height = height

    #!############################
    #! Declaring buttons
    #!############################

    def DefineMainMenuButtons(self) -> None:
        self.Button_LaunchGame = self.ButtonTemplate(translations["play_button"], self.Button_LaunchGame_func, (50, 255, 120))
        self.Button_Settings = self.ButtonTemplate(translations["settings_button"], self.Button_Settings_func)
        self.Button_Saves = self.ButtonTemplate(translations["saves_button"], self.Button_Saves_func, (235, 172, 14))
        self.Button_Update = self.ButtonTemplate(translations["update_button"], self.Button_Update_func, (255, 0, 255), isasync=True)
        self.Button_ManualMode = self.ButtonTemplate(translations["manual_mounting_button"], self.Button_ManualMode_func)
        self.Button_Workshop = self.ButtonTemplate(translations["workshop_button"], self.Button_Workshop_func, (14, 216, 235))
        self.Button_ResourcesMenu = self.ButtonTemplate(translations["resources_button"], self.Button_ResourcesMenu_func, (75, 0, 255))
        self.Button_Exit = self.ButtonTemplate(translations["exit_button"], self.Button_Exit_func, (255, 50, 50), isasync=True, selectanim="none")

        self.MainButtons = [self.Button_LaunchGame, self.Button_Settings, self.Button_Saves, self.Button_Update,
                            self.Button_ManualMode, self.Button_Workshop, self.Button_ResourcesMenu]

        if self.devMode:
            self.Button_Test = self.ButtonTemplate("test", self.Button_Test_func)
            self.MainButtons.append(self.Button_Test)

        self.MainButtons.append(self.Button_Exit)
        # we don't need the back button in the main menu but i thought it will be better the declare it here
        self.Button_Back = self.ButtonTemplate(
            translations["back_button"], self.Button_Back_func)

    def DefineSettingsMenuButtons(self) -> None:
        self.Button_LauncherSettingsMenu = self.ButtonTemplate(
            translations["launcher_settings_button"], self.Button_LauncherSettingsMenu_func)
        self.Button_Portal2Settings = self.ButtonTemplate(
            translations["portal2_config_button"], self.Button_Portal2Settings_func)
        self.Button_AdminsMenu = self.ButtonTemplate(
            translations["player_button"], self.Button_AdminsMenu_func, (0, 255, 255))
        self.Button_LanguageMenu = self.ButtonTemplate(
            translations["languages_button"], self.Button_LanguageMenu_func, (175, 75, 0))

        self.SettingsMenus = [self.Button_LauncherSettingsMenu, self.Button_Portal2Settings,
                              self.Button_AdminsMenu, self.Button_LanguageMenu]

        if self.devMode:
            self.Button_HiddenSettings = self.ButtonTemplate(translations["hidden_config_button"], self.Button_HiddenSettings_func)
            self.SettingsMenus.append(self.Button_HiddenSettings)

        self.SettingsMenus.append(self.Button_Back)

    def DefineSavesButton(self) -> None:
        if SS.init():
            print("Running")
            self.Button_SaveSystemState = self.ButtonTemplate(
                translations["save_system_state_txt"],  
                activeColor = (21, 255, 0),
                width = 50,
                height = 50)
        else:
            print("Not running")
            self.Button_SaveSystemState = self.ButtonTemplate(
                translations["save_system_state_txt"],
                activeColor = (255, 21, 0),
                width = 100,
                height = 100)

        #This is old but it worked before, keeping it just in case i need it again
        #self.Button_SaveSystemState = self.ButtonTemplate(
        #    translations["save_system_state"] + SS.saveSystemEnabled)
        
        self.SavesMenu = [self.Button_SaveSystemState, self.Button_Back]

    def DefineWorkshopButtons(self) -> None:
        self.Button_GetWorkShopCommand = self.ButtonTemplate(
            translations["get_level_button"], self.Button_GetWorkShopCommand_func)

        self.WorkshopButtons = [
            self.Button_GetWorkShopCommand, self.Button_Back]

    def DefineManualMountingButtons(self) -> None:
        self.Button_ManualMount = self.ButtonTemplate(
            translations["mount_button"], self.Button_ManualMount_func, (50, 255, 120), isasync=True)
        self.Button_ManualUnmount = self.ButtonTemplate(
            translations["unmount_button"], self.Button_ManualUnmount_func, (255, 50, 50), isasync=True)

        self.ManualButtons = [self.Button_ManualMount,
                              self.Button_ManualUnmount, self.Button_Back]

    def DefineResourcesButtons(self) -> None:
        self.Button_GitHub = self.ButtonTemplate(
            translations["github_button"], self.Button_GitHub_func, (255, 255, 255), isasync=True)
        self.Button_Guide = self.ButtonTemplate(
            translations["guide_button"], self.Button_Guide_func, (35, 35, 50), isasync=True)
        self.Button_Discord = self.ButtonTemplate(
            translations["discord_server_button"], self.Button_Discord_func, (75, 75, 150), isasync=True)

        self.RecourcesButtons = [
            self.Button_GitHub, self.Button_Guide, self.Button_Discord, self.Button_Back]

    def DefineTestingMenuButtons(self) -> None:
        self.Button_InputField = self.ButtonTemplate(
            "User Input", self.Button_InputField_func)
        self.PopupBox_gui = self.ButtonTemplate(
            "Popup Box", self.PopupBox_test_func)
        self.Button_PrintToConsole = self.ButtonTemplate(
            "print to console", self.Button_PrintToConsole_func)

        self.TestingMenu = [self.Button_InputField, self.PopupBox_gui,
                            self.Button_PrintToConsole, self.Button_Back]

#######################################################################

    def gradientRect(self, window: pygame.Surface, left_colour: tuple, right_colour: tuple, target_rect: pygame.Rect) -> None:
        colour_rect = pygame.Surface((2, 2))  # tiny! 2x2 bitmap
        pygame.draw.line(colour_rect, left_colour, (0, 0),
                         (0, 1))  # left colour line
        pygame.draw.line(colour_rect, right_colour, (1, 0),
                         (1, 1))  # right colour line
        colour_rect = pygame.transform.smoothscale(
            colour_rect, (target_rect.width, target_rect.height))  # stretch!
        window.blit(colour_rect, target_rect)

    def BackMenu(self) -> None:
        if len(self.directorymenu) > 0:
            self.ChangeMenu(self.directorymenu.pop(), False)

    # the button to go to the previous menu
    def Button_Back_func(self) -> None:
        self.BackMenu()

    def RefreshSettingsMenu(self, menu: str) -> None:
        self.SettingsButtons.clear()

        class curkeyButton:
            def __init__(self, key: str, outerSelf: Gui) -> None:
                self.text = GVars.configData[key]["value"]
                self.mlen = 10
                if len(self.text) > self.mlen:
                    self.text = self.text[:self.mlen] + "..."
                self.text = key + ": " + self.text
                self.cfgkey = key
                self.cfgvalue = GVars.configData[key]["value"]
                self.keyobj = GVars.configData[key]
                self.activecolor = (255, 255, 0)
                self.inactivecolor = (155, 155, 155)
                self.sizemult = 1
                self.outerSelf = outerSelf

            def whileSelectedfunction(self, outerSelf: Gui) -> None:
                outerSelf.BlitDescription(self.keyobj["description"], self.outerSelf.SelectedButton.x,
                                          self.outerSelf.SelectedButton.y + (self.outerSelf.SelectedButton.height * 1), (130, 130, 255))
                outerSelf.BlitDescription(self.keyobj["warning"], self.outerSelf.SelectedButton.x, self.outerSelf.SelectedButton.y + (
                    self.outerSelf.SelectedButton.height * 1.25), (255, 50, 50))

            selectanim = "pop"
            selectsnd = pygame.mixer.Sound("GUI/assets/sounds/power.wav")
            selectsnd.set_volume(0.25)
            hoversnd = pygame.mixer.Sound("GUI/assets/sounds/blip.wav")
            hoversnd.set_volume(0.25)
            curanim = ""

            def function(self) -> None:
                if self.cfgvalue == "true" or self.cfgvalue == "false":
                    if self.cfgvalue == "false":
                        cfg.EditConfig(self.cfgkey, "true")
                    # default to false to avoid errors
                    else:
                        cfg.EditConfig(self.cfgkey, "false")
                    self.outerSelf.RefreshSettingsMenu(menu)
                else:
                    def AfterInputGenericSetConfig(inp: str) -> None:
                        cfg.EditConfig(self.cfgkey, inp.strip())
                        Log("Saved '" + inp.strip() +
                            "' to config " + self.cfgkey)
                        self.outerSelf.Error(
                            translations["error_saved"], 5, (75, 200, 75))
                        self.outerSelf.RefreshSettingsMenu(menu)

                    self.outerSelf.GetUserInputPYG(
                        AfterInputGenericSetConfig, self.keyobj["prompt"], self.cfgvalue)

            isasync = False

        for key in GVars.configData:
            if GVars.configData[key]["menu"] == menu:
                Log(str(key) + ": " + str(GVars.configData[key]["value"]))
                self.SettingsButtons.append(curkeyButton(key, self))
        self.SettingsButtons.append(self.Button_Back)

    def RefreshPlayersMenu(self) -> None:
        cfg.ValidatePlayerKeys()

        self.PlayersMenu.clear()
        PlayerKey = GVars.configData["Players"]["value"][self.CurrentSelectedPlayer]
        print(PlayerKey)

        # displays and changes the player name
        def Button_PlayerName_func() -> None:
            def AfterInputPlayerName(inp: str) -> None:
                Log("Saving player name: "+inp)
                cfg.EditPlayer(self.CurrentSelectedPlayer, name=inp.strip())
                self.Error(translations["error_saved"], 5, (75, 200, 75))
                self.RefreshPlayersMenu()

            self.GetUserInputPYG(
                AfterInputPlayerName, translations["players_enter_username"], PlayerKey["name"])

        Button_PlayerName = self.ButtonTemplate(
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

                cfg.EditPlayer(self.CurrentSelectedPlayer, steamId=inp)
                self.Error(translations["error_saved"], 5, (75, 200, 75))
                self.RefreshPlayersMenu()

            self.GetUserInputPYG(
                AfterInputSteamID, "Enter A SteamID", PlayerKey["steamid"])

        Button_PlayerSteamId = self.ButtonTemplate(
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
                cfg.EditPlayer(self.CurrentSelectedPlayer, level=str(int(inp)))
                self.Error(translations["error_saved"], 5, (75, 200, 75))
                Log("Saving admin level as " + str(inp))
                self.RefreshPlayersMenu()

            self.GetUserInputPYG(
                AfterInputAdminLevel, translations["players_admin-enter-admin-level"], PlayerKey["adminlevel"])

        Button_AdminLevel = self.ButtonTemplate(
            translations["players_admin_level"] + PlayerKey["adminlevel"], Button_AdminLevel_func, (255, 255, 120))

        # changes the view to the next player
        def Button_NextPlayer_func() -> None:

            if self.CurrentSelectedPlayer < len(GVars.configData["Players"]["value"]) - 1:
                Log("Next player")
                self.CurrentSelectedPlayer += 1
            else:
                Log("No more players")
                self.CurrentSelectedPlayer = 0

            self.RefreshPlayersMenu()
            self.ChangeMenu(self.PlayersMenu, False)

        Button_NextPlayer = self.ButtonTemplate(
            translations["players_next_button"], Button_NextPlayer_func, (255, 255, 120))

       # adds a player to the list
        def Button_AddPlayer_func() -> None:

            Log("Adding blank player...")
            GVars.configData["Players"]["value"].append(cfg.defaultplayerarray)
            cfg.WriteConfigFile(GVars.configData)
            Log(str(len(GVars.configData["Players"]["value"]) - 1))
            self.CurrentSelectedPlayer = len(
                GVars.configData["Players"]["value"]) - 1
            self.RefreshPlayersMenu()

        Button_AddPlayer = self.ButtonTemplate(
            translations["players_add_player"], Button_AddPlayer_func, (120, 255, 120))

        # deletes a player from the list
        def Button_DeletePlayer_func() -> None:

            if len(GVars.configData["Players"]["value"]) <= 1:
                self.Error(
                    translations["players_error_must_be_at_least_one_player"], 5, (255, 50, 50))
                return

            Log("Deleting player...")
            cfg.DeletePlayer(self.CurrentSelectedPlayer)
            self.CurrentSelectedPlayer -= 1
            self.RefreshPlayersMenu()

        Button_DeletePlayer = self.ButtonTemplate(
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

    # launches the game

    def Button_LaunchGame_func(self) -> None:
        if self.coolDown > 0:
            return

        self.coolDown = int(3 * 60)
        RunGameScript()

    # switches to the settings menu

    def Button_Settings_func(self) -> None:
        self.ChangeMenu(self.SettingsMenus)

    # switches to the saves menu
    def Button_Saves_func(self) -> None:
        self.ChangeMenu(self.SavesMenu)

    # launcher update button

    def Button_Update_func(self) -> None:
        if self.coolDown > 0:
            return

        self.coolDown = int(3 * 60)

        if not CheckForUpdates():
            self.Error(
                translations["update_already_up_to_date"], 5, (200, 75, 220))

    # switches to the manual mod un/mounting menu

    def Button_ManualMode_func(self) -> None:
        self.ChangeMenu(self.ManualButtons)

    # switches to the workshop menu

    def Button_Workshop_func(self) -> None:
        self.ChangeMenu(self.WorkshopButtons)

    # switches to the resources menu (github, discord etc...)

    def Button_ResourcesMenu_func(self) -> None:
        self.ChangeMenu(self.RecourcesButtons)

    # it closes the game

    def Button_Exit_func(self) -> None:
        self.running = False

    #!############################
    #! SETTINGS BUTTONS FUNCTIONS
    #!############################

    # switches to the launcher specific settings

    def Button_LauncherSettingsMenu_func(self) -> None:
        self.RefreshSettingsMenu("launcher")
        self.ChangeMenu(self.SettingsButtons)

    # switches to the portal 2 sepcific settings

    def Button_Portal2Settings_func(self) -> None:
        self.RefreshSettingsMenu("portal2")
        self.ChangeMenu(self.SettingsButtons)

    # switches to the player menu where you can add admins

    def Button_AdminsMenu_func(self) -> None:
        self.RefreshPlayersMenu()
        self.ChangeMenu(self.PlayersMenu)

    # switches to the language menu where you can pick a language for the launcher

    def Button_LanguageMenu_func(self) -> None:
        # for choosing a languages
        self.LanguageButton()
        self.ChangeMenu(self.LanguagesMenu)

    # shows the hidden settings (dev settings)

    def Button_HiddenSettings_func(self) -> None:
        self.RefreshSettingsMenu("hidden")
        self.ChangeMenu(self.SettingsButtons)

    #!############################
    #! MANUAL MODE BUTTONS FUNCTIONS
    #!############################

    # a button for manual mounting

    def Button_ManualMount_func(self) -> None:
        if self.coolDown > 0:
            return

        self.coolDown = int(3 * 60)
        MountModOnly()

    # a button for manual unmounting

    def Button_ManualUnmount_func(self) -> None:
        if self.coolDown > 0:
            return

        self.coolDown = int(3 * 60)
        UnmountScript()

    #!############################
    #! WORKSHOP BUTTONS FUNCTIONS
    #!############################

    # get's the id from a map's url then copies the changelevel command to the clipboard

    def Button_GetWorkShopCommand_func(self) -> None:
        def AfterInput(input: str):
            map = workshop.MapFromSteamID(input)

            if map is not None:
                pyperclip.copy("changelevel " + map)
                self.Error(
                    translations["workshop_changelevel_command"], 3, (255, 0, 255))
                self.Error(
                    translations["workshop_copied_to_clipboard"], 3, (0, 255, 0))
                return

            self.Error(translations["workshop_map_not_found"])
            self.Error(
                translations["workshop_sentence0_sure-you-are-sub"], 6, (255, 255, 0))
            self.Error(
                translations["workshop_sentence0_to-map-and-play-it"], 6, (255, 255, 0))
            self.Error(
                translations["workshop_sentence0_least-once"], 6, (255, 255, 0))

        self.GetUserInputPYG(AfterInput, translations["workshop_link"])

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
        self.ChangeMenu(self.TestingMenu)


#! END OF BUTTON FUNCTIONS


    def ChangeMenu(self, menu: list, append: bool = True) -> None:
        if append:
            self.directorymenu.append(self.CurrentMenu)

        self.CurrentMenu = menu

        if self.CurrentButtonsIndex >= len(menu):
            self.CurrentButtonsIndex = len(menu) - 1

        self.SelectedButton = self.CurrentMenu[self.CurrentButtonsIndex]

    ####################

    # input field
    def Button_InputField_func(self) -> None:
        def AfterInput(input) -> None:
            self.Error("Input: " + input, 3, (255, 255, 0))
        self.GetUserInputPYG(AfterInput)

    #######################

    # this is a test for the popup box

    def PopupBox_test_func(self) -> None:
        def YesInput() -> None:
            self.Error(translations["error_yes"], 3, (75, 255, 75))

        def NoInput() -> None:
            self.Error(translations["error_no"], 3, (255, 75, 75))

        Button_Confirm = self.ButtonTemplate(
            translations["error_yes"], YesInput, (75, 200, 75))
        Button_Decline = self.ButtonTemplate(
            translations["error_no"], NoInput, (255, 75, 75))
        self.PopupBox("Are You A Mogus?", "have you done 1 sussy thing \n and or have done a VENT, SUS?",
                      [Button_Confirm, Button_Decline])

    def Button_PrintToConsole_func(self) -> None:
        print(GVars.modPath)
        print(GVars.configPath)

    ################################

    def SelectAnimation(self, btn: ButtonTemplate, anim: str) -> None:
        if anim == "pop":
            btn.curanim = "pop1"

    def RunAnimation(self, button: ButtonTemplate, anim: str) -> None:
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

    def BlitDescription(self, txt: str, x: float = None, y: float = None, clr: tuple = (255, 255, 255)) -> None:
        if x is None:
            x = self.screen.get_width() / 16
        if y is None:
            y = self.screen.get_height() / 16

        try:
            if (len(txt) > 0):
                text1 = pygame.font.Font("GUI/assets/fonts/pixel.ttf", int(int(
                    int((int(self.screen.get_width() / 25) + int(self.screen.get_height() / 50)) / 1)) / (len(txt) / 10))).render(txt, True, clr)
                if not (self.LookingForInput):
                    self.screen.blit(text1, (x, y))
        except Exception as e:
            Log(str(e))

    def GetUserInputPYG(self, afterfunc=None, prompt: str = "", preinput: str = "") -> None:
        Log("Getting user input...")
        self.LookingForInput = True
        self.CurInput = preinput
        self.InputPrompt = prompt
        self.AfterInputFunction = afterfunc
        Log("AfterInputFunction: " + str(self.AfterInputFunction))

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

        self.selectedpopupbutton = buttons[0]

        PopupBox = [title, text, buttons]  # TITLE, TEXT, BUTTONS
        Log("Creating popup box... Tile: " + str(title) +
            " Text: " + text + " Buttons: " + str(buttons))
        self.PopupBoxList.append(PopupBox)

    # the language button (english, french etc...)
    def Button_Language_func(self) -> None:
        lang: str = self.LanguagesMenu[self.CurrentButtonsIndex].text.replace(
            "→ ", "")
        Log("Language set: " + lang)
        cfg.EditConfig("activeLanguage", lang)
        LoadTranslations()
        self.__init__(self.devMode)
        self.Error(translations["language_error0_language_update"])

    def LanguageButton(self) -> None:
        self.LanguagesMenu.clear()
        Languages = GetAvailableLanguages()
        for language in Languages:
            if GVars.configData["activeLanguage"]["value"] == language:
                language = "→ " + language

            self.LanguagesMenu.append(self.ButtonTemplate(
                language, self.Button_Language_func, (150, 150, 255)))

        self.LanguagesMenu.append(self.Button_Back)

    ###############################################################################

    def Update(self) -> None:
        BT = Gui.ButtonTemplate.__init__
        W = self.screen.get_width()
        H = self.screen.get_height()
        fntdiv: int = 32
        fntsize = int(W / fntdiv)
        mindiv = int(fntdiv / 1.25)

        # DEBUG

        # tempsurf = pygame.font.Font("GUI/assets/fonts/pixel.ttf", int(int((int(W / 25) + int(H / 50)) / 1.5))).render("CuM", True, (255, 100, 255))
        # screen.blit(tempsurf, (mousex - tempsurf.get_width()/2, mousey - tempsurf.get_height()/2))

        # MENU 2 ELECTRIC BOOGALOO
        # loop through all buttons
        indx = 0
        for button in self.CurrentMenu:
            indx += 1
            clr = (0, 0, 0)
            button.width = BT.width
            button.height = BT.width
            size = int((button.width / 25) + (button.height /50))
            if button == self.SelectedButton:
                clr = button.activecolor
            else:
                clr = button.inactivecolor
            self.RunAnimation(button, button.curanim)
            #text1 = pygame.font.Font("GUI/assets/fonts/pixel.ttf",
                                     #int((int(W / 25) + int(H / 50)) / 1.5)).render(button.text,True, clr)
            
            text1 = pygame.font.Font("GUI/assets/fonts/pixel.ttf", size).render(button.text, True, clr)

            if not (self.LookingForInput):
                self.screen.blit(
                    text1, (W / 16, (H / 2 - (text1.get_height() / 2)) * (indx / 5)))
            button.x = W / 16
            button.y = (H / 2 - (text1.get_height() / 2)) * (indx / 5)
            #button.width = text1.get_width()
            #button.height = text1.get_height()
            
            

        # BACKGROUND
        for floater in self.Floaters:
            surf = floater.surf
            if (self.SelectedButton.text == translations["unmount_button"] or self.SelectedButton.text == translations["exit_button"]):
                surf = self.angrycube
            if (self.SelectedButton.text == translations["back_button"]):
                surf = self.goldencube
            surf = pygame.transform.scale(surf, (W / 15, W / 15))
            surf = pygame.transform.rotate(surf, floater.rot)
            center = surf.get_rect().center
            LauncherCubes = GVars.configData["LauncherCubes"]["value"] == "true"
            if (LauncherCubes):
                self.screen.blit(
                    surf, (floater.x - center[0], floater.y - center[1]))
            if floater.negrot:
                floater.rot -= (1 + random.randint(0, 2))
            else:
                floater.rot += (1 + random.randint(0, 2))
            if (self.SelectedButton.text == translations["back_button"]):
                floater.x -= W / 60
                if floater.x < (floater.surf.get_width() * -2):
                    floater.y = random.randint(0, H)
                    floater.x = (floater.surf.get_width() * 2) + \
                        (random.randint(W, W * 2)) * 1
                    floater.negrot = random.randint(0, 1) == 1
            elif (self.SelectedButton.text == translations["unmount_button"] or self.SelectedButton.text == translations["exit_button"]):
                floater.y -= H / 60
                if floater.y < (floater.surf.get_height() * -2):
                    floater.y = (floater.surf.get_height() * 2) + \
                        (random.randint(H, H * 2))
                    floater.x = random.randint(0, W)
                    floater.negrot = random.randint(0, 1) == 1
            else:
                floater.y += H / 60
                if floater.y > (H + floater.surf.get_height() * 2):
                    floater.y = (floater.surf.get_height() * -2) + \
                        (random.randint(0, H)) * -1
                    floater.x = random.randint(0, W)
                    floater.negrot = random.randint(0, 1) == 1

        # Put assets/images/keys.png on the top right corner of the screen
        keys = pygame.image.load("GUI/assets/images/keys.png").convert_alpha()
        keys = pygame.transform.scale(keys, (W / 10, W / 10))
        self.screen.blit(keys, ((W / 1.05) - keys.get_width(), H / 15))

        # MENU

        self.SelectedButton = self.CurrentMenu[self.CurrentButtonsIndex]

        # OVERLAY

        indx = 0
        for error in self.ERRORLIST[::-1]:
            indx += 1
            errortext = pygame.font.Font("GUI/assets/fonts/pixel.ttf", int(int(W / 60) + int(H / 85))).render(error[0],
                                                                                                              True,
                                                                                                              error[2])
            self.screen.blit(
                errortext, (W / 30, ((errortext.get_height() * indx) * -1) + (H / 1.05)))

        # every 1 second go through each error and remove it if it's been there for more than 1 second
        if (time.time() - self.SecAgo) > 1:
            for error in self.ERRORLIST:
                if (error[1] < 0):
                    self.ERRORLIST.remove(error)
                error[1] -= 1
            self.SecAgo = time.time()

        try:
            # if self.CurrentMenu == setti
            self.SelectedButton.whileSelectedfunction(self)

        except Exception as e:
            # Log(str(e))
            pass

        # DRAW POPUP BOX
        if len(self.PopupBoxList) > 0:
            sz = 1.25

            # draw a white box that is half the width and height of the screen
            boxbackground = pygame.Surface((W / sz, W / (sz * 2)))
            boxbackground.fill((255, 255, 255))
            boxbackground.set_alpha(175)
            self.screen.blit(boxbackground, (W / 2 - (boxbackground.get_width() / 2),
                                             H / 2 - (boxbackground.get_height() / 2)))

            bw = boxbackground.get_width()
            bh = boxbackground.get_height()
            bx = W / 2 - (bw / 2)
            by = H / 2 - (bh / 2)

            # put the title in the box
            boxtitle = pygame.font.Font("GUI/assets/fonts/pixel.ttf", fntsize).render(self.PopupBoxList[0][0], True,
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
                    "GUI/assets/fonts/pixel.ttf", int(fntsize / 1.5)).render(line, True, (0, 0, 0))
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
                buttonsurf = pygame.surface.Surface(
                    ((bw / amtob) / 1.2, (bh / 5)))
                if (button == self.selectedpopupbutton):
                    buttonsurf.fill(button.activecolor)
                else:
                    buttonsurf.fill(button.inactivecolor)
                surfw = buttonsurf.get_width()
                surfh = buttonsurf.get_height()
                surfx = bx + (bw / amtob) * indx + \
                    (bw / amtob) / 2 - (surfw / 2)
                surfy = by + bh - (bh / 4)
                button.x = surfx
                button.y = surfy
                button.width = surfw
                button.height = surfh
                self.screen.blit(buttonsurf, (surfx, surfy))

                text = pygame.font.Font("GUI/assets/fonts/pixel.ttf", int(fntsize / 1.5)).render(button.text, True,
                                                                                                 (255, 255, 255))
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
                    "GUI/assets/fonts/pixel.ttf", fntsize).render(lines[i], True, (255, 255, 175))
                self.screen.blit(InputText, (W / 2 - (InputText.get_width() / 2), (
                    (((H / 2) - (InputText.get_height() * 1.25)) + ((text1.get_height() * 1.25) * i))) - (
                    (((text1.get_height() * 1.25) * (len(lines) / 2))))))

            surf1 = pygame.Surface((W / 1.5, W / 100))
            surf1.fill((255, 255, 255))
            surf2 = pygame.Surface((W / 1.5, W / 100))
            blitpos = (
                (W / 2) - (surf2.get_width() / 2), (H / 2) + ((InputText.get_height() * 1.725) * ((len(lines) / 2) - 1)))
            self.screen.blit(surf1, blitpos)

            surfInputPrompt = pygame.font.Font("GUI/assets/fonts/pixel.ttf", fntsize).render(self.InputPrompt, True,
                                                                                             (255, 255, 255))
            # blit it right below the surf1
            self.screen.blit(surfInputPrompt, (blitpos[0] + (surf1.get_width() / 2) - (surfInputPrompt.get_width() / 2),
                                               blitpos[1] + surfInputPrompt.get_height()))

    ###############################################################################

    def Main(self) -> None:
        LastBackspace = 0
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

            if self.coolDown > 0:
                self.coolDown -= 1

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

                # INPUT BOX INPUT
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
                                str1 = str(tk.selection_get(
                                    selection="CLIPBOARD")).replace("\n", "")
                                Log(f"Pasted: {str1}")
                                self.CurInput += str1
                            except Exception as e:
                                Log(str(e))  # always log the error
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

                # POPUP BOX INPUT
                if len(self.PopupBoxList) > 0:
                    boxlen = len(self.PopupBoxList[0][2])
                    if event.type == KEYDOWN:
                        if event.key == K_ESCAPE:
                            self.PopupBoxList.pop()

                        if event.key == K_RIGHT:
                            for btn in self.PopupBoxList[0][2]:
                                if btn == self.selectedpopupbutton:
                                    if self.PopupBoxList[0][2].index(btn) < boxlen - 1:
                                        self.selectedpopupbutton = self.PopupBoxList[0][2][self.PopupBoxList[0][2].index(
                                            btn) + 1]

                        elif event.key == K_LEFT:
                            for btn in self.PopupBoxList[0][2]:
                                if btn == self.selectedpopupbutton:
                                    if self.PopupBoxList[0][2].index(btn) > 0:
                                        self.selectedpopupbutton = self.PopupBoxList[0][2][self.PopupBoxList[0][2].index(
                                            btn) - 1]

                        elif event.key == K_SPACE or event.key == K_RETURN:
                            self.selectedpopupbutton.function()
                            self.PopupBoxList.pop()

                    elif event.type == MOUSEBUTTONDOWN:
                        # if the mouse is over a button
                        for btn in self.PopupBoxList[0][2]:
                            if (btn.x < mousex < btn.x + btn.width) and (btn.y < mousey < btn.y + btn.height):
                                self.selectedpopupbutton = btn
                                self.selectedpopupbutton.function()
                                self.PopupBoxList.pop()
                                break

                # NORMAL INPUT
                if event.type == KEYDOWN:
                    if event.key in [K_ESCAPE, K_BACKSPACE]:
                        self.BackMenu()
                    elif event.key in [K_DOWN, K_s]:
                        if self.CurrentButtonsIndex < len(self.CurrentMenu) - 1:
                            self.CurrentButtonsIndex += 1
                            self.SelectedButton = self.CurrentMenu[self.CurrentButtonsIndex]
                            self.PlaySound(self.SelectedButton.hoversnd)
                        else:
                            self.CurrentButtonsIndex = 0
                            self.SelectedButton = self.CurrentMenu[self.CurrentButtonsIndex]
                            self.PlaySound(self.SelectedButton.hoversnd)
                    elif event.key in [K_UP, K_w]:
                        if self.CurrentButtonsIndex > 0:
                            self.CurrentButtonsIndex -= 1
                            self.SelectedButton = self.CurrentMenu[self.CurrentButtonsIndex]
                            self.PlaySound(self.SelectedButton.hoversnd)
                        else:
                            self.CurrentButtonsIndex = len(
                                self.CurrentMenu) - 1
                            self.SelectedButton = self.CurrentMenu[self.CurrentButtonsIndex]
                            self.PlaySound(self.SelectedButton.hoversnd)
                    elif event.key in [K_SPACE, K_RETURN, K_KP_ENTER]:
                        self.SelectAnimation(
                            self.SelectedButton, self.SelectedButton.selectanim)
                        if self.SelectedButton.function:
                            if self.SelectedButton.isasync:
                                threading.Thread(
                                    target=self.SelectedButton.function).start()
                            else:
                                self.SelectedButton.function()

                        self.PlaySound(self.SelectedButton.selectsnd)

                # LMB
                # executes the button's function on left mouse click IF the mouse is above the button
                if event.type == pygame.MOUSEBUTTONDOWN:
                    if event.button == 1:
                        button = self.SelectedButton
                        if (mousex > button.x and mousex < button.x + button.width) and (mousey > button.y and mousey < button.y + button.height):
                            if self.SelectedButton.function:
                                if self.SelectedButton.isasync:
                                    threading.Thread(
                                        target=self.SelectedButton.function).start()
                                else:
                                    self.SelectedButton.function()

                            self.SelectAnimation(
                                self.SelectedButton, self.SelectedButton.selectanim)

                            self.PlaySound(self.SelectedButton.selectsnd)

                ###############################
                # changes the `SelectedButton` and the `CurrentButtonsIndex` to the button the mouse is on
                if event.type == pygame.MOUSEMOTION:
                    for button in self.CurrentMenu:
                        # if the mouse is over the button
                        if (mousex > button.x and mousex < button.x + button.width) and (mousey > button.y and mousey < button.y + button.height):
                            # if the button isnt already selected
                            if button != self.SelectedButton:
                                # select the button
                                self.SelectedButton = button
                                # set current buttons index to the button
                                self.CurrentButtonsIndex = self.CurrentMenu.index(
                                    button)
                                # play the hover sound
                                self.PlaySound(self.hvrclksnd)

            ###############################
            # changes the color of the hovered button in the popup box
            if len(self.PopupBoxList) > 0:
                for button in self.PopupBoxList[0][2]:
                    # if the mouse is over the button
                    if (mousex > button.x and mousex < button.x + button.width) and (mousey > button.y and mousey < button.y + button.height):
                        if button != self.selectedpopupbutton:
                            self.selectedpopupbutton = button
                            self.PlaySound(button.hoversnd)

        PreExit()

        pygame.quit()
        os._exit(0)


# !######################################################
# !                       Logic
# !######################################################

def PreExit() -> None:
    # windows
    if (GVars.iow):
        os.system("taskkill /f /im portal2.exe")

    # linux
    if (GVars.iol):
        os.system("killall -9 portal2_linux")

    # this is to make sure the portal 2 thread is dead
    # 1 second should be enough for it to die
    time.sleep(1)
    if (GVars.configData["AutoUnmount"]["value"] == "true"):
        UnmountScript(False)
        Ui.Error(translations["unmounted_error"], 5, (125, 0, 125))


def GetGamePath() -> None:
    tmpp = BF.TryFindPortal2Path()

    if tmpp:
        cfg.EditConfig("portal2path", tmpp.strip())
        Log("Saved '" + tmpp.strip() + "' as the game path!")
        Ui.Error(translations["game_path_error-founded"], 5, (255, 255, 75))
        VerifyGamePath()
        return

    def AfterInputGP(inp) -> None:
        cfg.EditConfig("portal2path", inp.strip())
        Log("Saved '" + inp.strip() + "' as the game path!")
        Ui.Error(translations["game_path_error-saved"], 5, (75, 200, 75))
        VerifyGamePath()

    Ui.GetUserInputPYG(AfterInputGP, translations["game_path_enter_path"])


def VerifyGamePath(shouldgetpath: bool = True) -> bool:
    Log("Verifying game path...")
    gamepath = GVars.configData["portal2path"]["value"]

    if ((os.path.exists(gamepath)) != True) or (os.path.exists(gamepath + GVars.nf + "portal2_dlc2") != True):
        Ui.Error(translations["game_path-is-invalid"])

        if shouldgetpath:
            Ui.Error(
                translations["game_path-attempt-to-fetch"], 5, (255, 255, 75))
            GetGamePath()

        return False
    return True


def VerifyModFiles() -> bool:
    modFilesPath = GVars.modPath + GVars.nf + "ModFiles" + \
        GVars.nf + "Portal 2" + GVars.nf + "install_dlc"
    Log("Searching for mod files in: " + modFilesPath)
    if (os.path.exists(modFilesPath)) and (os.path.exists(modFilesPath + GVars.nf + "32playermod.identifier")):
        Log("Mod files found!")
        return True

    Log("Mod files not found!")
    return False


def UseFallbacks(gamepath: str) -> None:
    # copy the "FALLBACK" folder to the modpath "GVars.modPath + GVars.nf + "ModFiles""
    BF.CopyFolder(cwd + GVars.nf + "FALLBACK" + GVars.nf +
                  "ModFiles", GVars.modPath + GVars.nf + "ModFiles")
    DoEncrypt = GVars.configData["EncryptCvars"]["value"] == "true"
    RG.MountMod(gamepath, DoEncrypt)
    Ui.Error(translations["mount_complete"], 5, (75, 255, 75))
    RG.LaunchGame(gamepath)


def DEVMOUNT() -> None:
    try:
        # delete the old modfiles
        BF.DeleteFolder(GVars.modPath + GVars.nf + "ModFiles")
    except Exception as e:
        Log("Error deleting mod files in dev mount")
        Log(str(e))

    # copy the one in the current directory to the modpath
    BF.CopyFolder(cwd + GVars.nf + "ModFiles",
                  GVars.modPath + GVars.nf + "ModFiles")


def MountModOnly() -> bool:
    cfg.ValidatePlayerKeys()

    if Ui.IsUpdating:
        Ui.Error(translations["update_is-updating"], 5, (255, 75, 75))
        return False

    if not VerifyGamePath():
        return False

    Ui.Error(translations["mounting_mod"], 5, (75, 255, 75))

    gamepath = GVars.configData["portal2path"]["value"]

    if (GVars.configData["developer"]["value"] == "true"):
        Ui.Error(translations["devmod_is_active"], 5, (255, 180, 75))
        DEVMOUNT()
        Ui.Error(
            translations["devmod_copied_from_local_repo"], 5, (75, 255, 75))

    if (VerifyModFiles()):
        DoEncrypt = GVars.configData["EncryptCvars"]["value"] == "true"
        RG.MountMod(gamepath, DoEncrypt)
        Ui.Error(translations["mounted"], 5, (75, 255, 75))
        return True

    # if the he's not a developer and the mod files don't exist ask him to download the files from the repo
    if (os.path.exists(GVars.modPath + GVars.nf + "ModFiles")):
        BF.DeleteFolder(GVars.modPath + GVars.nf + "ModFiles")

    if not up.haveInternet():
        Ui.Error(
            translations["update_error_connection_problem"], 5, (255, 75, 75))
        UseFallbacks(gamepath)
        Ui.Error(translations["mounted"], 5, (75, 255, 75))
        return True

    def YesInput() -> None:
        Log("User agreed to download the mod files! Fetching mod...")
        UpdateModFiles()

    YesButton = Ui.ButtonTemplate(
        translations["error_yes"], YesInput, (75, 200, 75))
    NoButton = Ui.ButtonTemplate(
        translations["game_files_use_fallbacks"], 0, (255, 75, 75))

    Ui.PopupBox(translations["game_files_fetch_game"],
                translations["game_files_no_cached_files"], [YesButton, NoButton])

    return True


def GetAvailableLanguages() -> list[str]:
    Log("searching for available languages")
    langs = []
    for file in os.listdir("languages"):
        langs.append(file[:-5])
    customTranslationsPath = GVars.modPath + GVars.nf + "languages"
    if os.path.exists(customTranslationsPath):
        for file in os.listdir(customTranslationsPath):
            langs.append(file[:-5])

    return langs


def LoadTranslations() -> dict:
    global translations
    langPath = "languages/" + \
        GVars.configData["activeLanguage"]["value"] + ".json"

    if not os.path.exists(langPath):
        langPath = GVars.modPath + GVars.nf + "languages/" + \
            GVars.configData["activeLanguage"]["value"] + ".json"

    if not os.path.exists(langPath):
        cfg.EditConfig("activeLanguage",
                       cfg.DefaultConfigFile["activeLanguage"]["value"])
        langPath = "languages/" + \
            GVars.configData["activeLanguage"]["value"] + ".json"

    translations = json.load(open(langPath, "r", encoding="utf8"))


def UpdateModFiles() -> None:
    PreExit()
    Ui.Error(translations["update_fetching"], 5000, (255, 150, 75))

    def UpdateThread() -> None:
        Log("Updating...")
        Ui.IsUpdating = True
        up.DownloadNewFiles()
        Ui.Error(translations["update_complete"], 5, (75, 255, 75))
        Ui.IsUpdating = False
        for thing in Ui.ERRORLIST:
            if thing[0] == translations["update_fetching"]:
                Ui.ERRORLIST.remove(thing)

    thread = threading.Thread(target=UpdateThread)
    thread.start()


def UpdateModClient() -> None:
    PreExit()
    Ui.Error(translations["updating_client"], 5000, (255, 150, 75))

    def UpdateThread() -> None:
        Log("Updating client...")
        Ui.IsUpdating = True

        if not up.DownloadClient():
            Ui.Error(
                "Couldn't find the download link \nplease visit our github to update")
            return

        Ui.running = False
        Log("self.running set to false")

    thread = threading.Thread(target=UpdateThread)
    thread.start()


def RunGameScript() -> None:
    if MountModOnly():
        gamepath = GVars.configData["portal2path"]["value"]
        RG.LaunchGame(gamepath)
        Ui.Error(translations["game_launched"], 5, (75, 255, 75))


def UnmountScript(shouldgetpath: bool = True) -> None:
    Log("___Unmounting Mod___")
    VerifyGamePath(shouldgetpath)
    gamepath = GVars.configData["portal2path"]["value"]
    RG.DeleteUnusedDlcs(gamepath)
    RG.UnpatchBinaries(gamepath)
    Log("____DONE UNMOUNTING____")


def RestartClient(path: str = sys.executable) -> None:
    if (GVars.iol):
        permissioncommand = "chmod +x " + path
        os.system(permissioncommand)

    command = path
    subprocess.Popen(command, shell=True)
    Log("Restarting client")
    Ui.running = False

# checks if the client was downloaded by a previous version of itself


def IsNew() -> None:
    # we pass 2 arguments when we update the client
    # 1- the word "updated"
    # 2- the path of the previous version
    # argument 0 is always the command to start the app so we don't need that

    if len(sys.argv) != 3:
        return

    if (sys.argv[1] != "updated") or (not os.path.exists(sys.argv[2])):
        return

    Log("This is first launch after a successful update")

    Log("Deleting old client...")
    os.remove(sys.argv[2])

    # this will rename the new clien to the old client's name
    Log("Renaming new client...")
    os.rename(GVars.executable, sys.argv[2])
    RestartClient("\"" + sys.argv[2] + "\"")


def ClientUpdateBox(update: dict) -> None:
    YesButton = Ui.ButtonTemplate(
        translations["error_yes"], UpdateModClient, (75, 200, 75))
    NoButton = Ui.ButtonTemplate(
        translations["error_no"], activeColor=(255, 75, 75))

    Ui.PopupBox(update["name"], update["message"], [YesButton, NoButton])


def ModFilesUpdateBox() -> None:
    YesButton = Ui.ButtonTemplate(
        translations["error_yes"], UpdateModFiles, (75, 200, 75))
    NoButton = Ui.ButtonTemplate(
        translations["error_no"], activeColor=(255, 75, 75))

    Ui.PopupBox(translations["update_available"],
                translations["update_would_you_like_to"], [YesButton, NoButton])


def CheckForUpdates() -> bool:
    Log("Checking for updates...")
    clientUpdate = up.CheckForNewClient()

    if clientUpdate["status"]:
        ClientUpdateBox(clientUpdate)
        return True

    if up.CheckForNewFiles():
        ModFilesUpdateBox()
        return True

    return False


def Initialize() -> None:
    # Load the global variables
    GVars.init()
    # do the fancy log thing
    StartLog()
    # load the config file into memmory
    GVars.LoadConfig()
    # load the client's translations
    LoadTranslations()
    # Starts up the custom save system
    SS.init()

    # checks if this is debug or release mode
    if sys.argv[0].endswith(".py"):
        Log("Running through Python! Not checking for updates.")
        return

    IsNew()  # Check for first time setup after update
    # time.sleep(1) # i have no idea why did i add sleep here

    # remove old temp files
    if (os.path.exists(GVars.modPath + GVars.nf + ".temp")):
        BF.DeleteFolder(GVars.modPath + GVars.nf + ".temp")


def PostInitialize() -> None:
    # only check for updates if the user is not running from source
    if not sys.argv[0].endswith(".py"):
        CheckForUpdates()

    VerifyGamePath(False)

    def NewAfterFunction() -> None:
        Ui.Error(translations["game_exited"], 5, (125, 0, 125))
        if (GVars.configData["AutoUnmount"]["value"] == "true"):
            UnmountScript()
            Ui.Error(translations["unmounted_error"], 5, (125, 0, 125))

    GVars.AfterFunction = NewAfterFunction

    if (GVars.hadtoresetconfig):
        Log("Config has been reset to default settings!")
        OkButton = Ui.ButtonTemplate(
            translations["error_ok"], activeColor=(75, 255, 75))
        Ui.PopupBox(translations["launcher_config_reset"],
                    translations["launcher_had_to_reset"], [OkButton])


if __name__ == '__main__':
    try:
        cwd = os.getcwd()
        Initialize()
        Ui = Gui(GVars.configData["developer"]["value"] == "true")
        PostInitialize()
        Ui.Main()
    except Exception as e:
        traceback.print_exc()
        #Log("Exception encountered: " + str(e))
