import pygame


class Button:

    def __init__(self,
                    text: str,  # The text for the button
                    func=None,  # What the button will do when the user clicks it
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