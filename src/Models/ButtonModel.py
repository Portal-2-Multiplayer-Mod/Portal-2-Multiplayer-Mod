import pygame

class ButtonTemplate:
    def __init__(self,
                text: str,
                func,
                activeColor: tuple = (255, 255, 0),
                inactiveColor: tuple = (155, 155, 155),
                sizemult: float = 1,
                selectanim: str = "pop",  # The sound that is played when it is hovered over
                curanim: str = "",
                isAsync: bool = False,
                xpos: float = 16,
                ypos: float = 2,
                # Size "700" appears to be default size. Increasing over "7500" will start to make the launcher unstable.
                size: float = 700,
                ):

        self.Text:str = text
        self.Function = func
        if self.Function == None: self.Function = self.Empty
        self.SizeMultiplier = sizemult
        self.IsAsync: bool = isAsync
        self.RelativePosX: int = xpos
        self.RelativePosY: int = ypos
        self.Size = size

        #! A duct tape fix to prevent errors with mouse movement detection
        self.CurrentPosX: int = self.RelativePosX
        self.CurrentPosY: int = self.RelativePosY
        self.Width: int
        self.Height: int

        #* Cosmetics
        self.ActiveColor = activeColor
        self.InactiveColor = inactiveColor
        self.selectanim = selectanim
        self.curanim = curanim
        self.pwrsnd = pygame.mixer.Sound("GUI/assets/sounds/power.wav")
        self.pwrsnd.set_volume(0.25)
        self.blipsnd = pygame.mixer.Sound("GUI/assets/sounds/blip.wav")
        self.blipsnd.set_volume(0.25)
        self.selectsnd = self.pwrsnd
        self.HoverSound = self.blipsnd

    def Empty(self):
        return