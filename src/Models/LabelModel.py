class Label:
    def __init__(self, text: str, color: tuple = (155, 155, 155), xPos: float = 0, yPos: float = 0, xStart: float = 0, xEnd: float = 100, size: float = 26) -> None:
        """ Basic Label model

        Parameters
        ----------
        text : str
            text to display.

        color : tuple, optional
            color in rgb, by default (155, 155, 155)

        xPos : float, optional
            position on the X axis, by default 0

        yPos : float, optional
            position on the Y axis, by default 0

        xStart : float, optional
            god knows what, by default 0

        xEnd : float, optional
            god knows what, by default 100

        size : float, optional
            size of the text
        """

        self.Text = text
        self.Color = color
        self.xPos = xPos
        self.xStart = xStart
        self.xEnd = xEnd
        self.yPos = yPos
        self.Size = size
