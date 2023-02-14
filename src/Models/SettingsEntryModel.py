import pygame

from Scripts.BasicLogger import Log
import Scripts.Configs as cfg
import Scripts.GlobalVariables as GVars


class curkeyButton:
    def __init__(self, key: str, outerSelf, menuName: str, translations: dict[str]):

        self.Translations = translations
        self.MenuName = menuName
        self.OuterSelf = outerSelf
        self.Value = GVars.configsData[key]["value"]
        self.IsAsync = False

        self.Text = str(self.Value)
        self.MaxTextLength = 10

        if len(self.Text) > self.MaxTextLength:
            self.Text = self.Text[:self.MaxTextLength] + "..."

        self.Text = self.Translations["name"] + ": " + self.Text
        self.Property = key
        self.ActiveColor = (255, 255, 0)
        self.InactiveColor = (155, 155, 155)
        self.SizeMultiplier = 1
        self.Size = 700
        self.RelativePosX = 16
        self.RelativePosY = 2

        #! A duct tape fix to prevent errors with mouse movement detection
        self.CurrentPosX = 16
        self.CurrentPosY = 2
        self.Width = 28
        self.Height = 14

        #* Cosmetics
        self.selectanim = "pop"
        self.selectsnd = pygame.mixer.Sound("GUI/assets/sounds/power.wav")
        self.selectsnd.set_volume(0.25)
        self.hoversnd = pygame.mixer.Sound("GUI/assets/sounds/blip.wav")
        self.hoversnd.set_volume(0.25)
        self.curanim = ""

    def whileSelectedfunction(self, outerSelf) -> None:
        outerSelf.BlitDescription(
            self.Translations["description"], 75, 590, (130, 130, 255))
        outerSelf.BlitDescription(
            self.Translations["warning"], 75, 625, (255, 50, 50))

    def Function(self) -> None:
        if type(self.Value) is bool:
            if self.Value == False:
                cfg.EditConfig(self.Property, True)
            # default to false to avoid errors
            else:
                cfg.EditConfig(self.Property, False)
        else:
            def AfterInputGenericSetConfig(inp: str) -> None:
                cfg.EditConfig(self.Property, inp.strip())
                Log(f"Saved '{inp.strip()}' to config {self.Property}")
                self.OuterSelf.Error(
                    self.Translations["error_saved"], 5, (75, 200, 75))

                self.OuterSelf.RefreshSettingsMenu(self.MenuName)
            self.OuterSelf.GetUserInputPYG(
                AfterInputGenericSetConfig, self.Translations["prompt"], self.Value)
