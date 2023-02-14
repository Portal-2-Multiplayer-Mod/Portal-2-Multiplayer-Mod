class DisplayText:
    def __init__(self, text: str, textColor: tuple = (155, 155, 155), posX: float = 0, posY: float = 0, endX: float = 100, size: float = 100):
        """Used to draw text only elements

        Parameters
        ----------
        text : str
            The text to draw

        textColor : tuple, optional
            The text color, by default (155, 155, 155)

        posX : float, optional
            The X position where the text should start, by default 0

        posY : float, optional
            The Y position where the text should start, by default 0

        endX : float, optional
            The X position where the text should end, by default 100

        size : float, optional
            The desired font size, by default 100
        """
        self.Text: str = text
        self.TextColor: tuple = textColor
        self.posX: float = posX
        self.StartX: float = posX
        self.EndX: float = endX
        self.PosY: float = posY
        self.Size: float = size
        self.Width: int = 0
        self.Height: int = 0
