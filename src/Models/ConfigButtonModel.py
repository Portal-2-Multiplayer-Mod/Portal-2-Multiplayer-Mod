import pygame
import Scripts.GlobalVariables as GVars
import Scripts.Configs as CFG

from Scripts.BasicLogger import Log


class ConfigButton:

    isAsync = False

    def __init__(self, key: str, outerSelf, menu: str, translations: dict[str]) -> None:

        self.Key = key
        self.Menu = menu
        self.OuterSelf = outerSelf
        self.Translations = translations

        self.Value = GVars.configData[key]["value"]

        self.text = str(self.Value)
        maxTextLength = 10

        if len(self.text) > maxTextLength:
            self.text = self.text[:maxTextLength] + "..."

        self.text = translations[key] + ": " + self.text
        self.KeyObject = GVars.configData[key]

        # * customizations
        self.ActiveColor = (255, 255, 0)
        self.InactiveColor = (155, 155, 155)
        self.sizeMultiplier = 1
        self.size = 700
        self.xPos = 16
        self.yPos = 2

        # A duct tape fix to prevent errors with mouse movement detection
        self.x = 16
        self.y = 2
        self.width = 28
        self.height = 14

        self.ClickAnimation = "pop"
        self.CurrentAnimation = ""
        self.ClickSound = pygame.mixer.Sound("GUI/sounds/click.wav")
        self.ClickSound.set_volume(0.25)
        self.HoverSound = pygame.mixer.Sound("GUI/sounds/blip.wav")
        self.HoverSound.set_volume(0.25)

    def Hovered(self, outerSelf) -> None:
        #! trust me we need 2 try/catch clauses -cabiste

        try:
            outerSelf.DrawLabel(
                self.Translations[self.Key+"-description"], 75, 590, (130, 130, 255))
        except:
            outerSelf.DrawLabel(
                self.KeyObject["description"], 75, 590, (130, 130, 255))
            pass

        try:
            outerSelf.DrawLabel(
                self.Translations[self.Key+"-warning"], 75, 625, (255, 50, 50))
        except:
            outerSelf.DrawLabel(
                self.KeyObject["warning"], 75, 625, (255, 50, 50))
            pass

    def function(self) -> None:
        if type(self.Value) is bool:
            CFG.EditConfig(self.Key, not self.Value)

        else:

            self.OuterSelf.ChangeMenu(self.OuterSelf.BlankButton, append=True)

            try:
                self.OuterSelf.GetUserInput(
                    self.SetConfig, self.Translations[self.Key+"-prompt"], self.Value)
            except:
                self.OuterSelf.GetUserInput(
                    self.SetConfig, self.KeyObject["prompt"], self.Value)

        self.OuterSelf.RefreshSettingsMenu(self.Menu)

    def SetConfig(self, inp: str) -> None:
        CFG.EditConfig(self.Key, inp.strip())
        Log(f"Saved '{inp.strip()}' to as value to: {self.Key}")
        self.OuterSelf.CreateToast(self.Translations["saved_toast"], 5, (75, 200, 75))
        self.OuterSelf.BackMenu()