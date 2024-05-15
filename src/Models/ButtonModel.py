import pygame


class Button:

    def __init__(self,
                    text: str,  # The text for the button
                    func=None,  # What the button will do when the user clicks it
                    # The color of the button when the user hovers the cursor over it
                    activeColor: tuple = (255, 255, 0),
                    # The color that the button will be when the user doesn't hover over it
                    inactiveColor: tuple = (155, 155, 155),
                    sizeMultiplier: int = 1,
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
                    # Size "38" is the default size. Increasing over "7500" will start to make the launcher unstable.
                    size: float = 38,
                    ) -> None:

        self.Text = text
        self.function = func
        self.ActiveColor = activeColor
        self.InactiveColor = inactiveColor
        self.SizeMultiplier = sizeMultiplier
        self.ClickAnimation = clickAnimation
        self.CurrentAnimation = currentAnimation
        self.isAsync = isAsync

        self.ClickSound = pygame.mixer.Sound("GUI/sounds/click.wav")
        self.ClickSound.set_volume(0.25)
        self.HoverSound = pygame.mixer.Sound("GUI/sounds/blip.wav")
        self.HoverSound.set_volume(0.25)

        self.xPos = xPos
        self.yPos = yPos
        self.X = x
        self.Y = y
        self.Width = width
        self.Height = height
        self.Size = size