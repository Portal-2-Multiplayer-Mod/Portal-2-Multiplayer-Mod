import pygame


class Floater:
    """Used to define the falling sprites"""

    def __init__(self, rotaion: float, surface: pygame.Surface, posX: float, posY: float, negativeRotation: bool) -> None:
        """Sets the values of the sprite

        Parameters
        ----------
        rotaion : float
            The start rotation of the sprite.

        surface : pygame.Surface
            The asset to use for the srpite.

        posX : float
            The X position where it should start falling from.

        posY : float
            The Y position where it should start falling from.

        negativeRotation : bool
            If it should rotate in the oposite direction.
        """

        self.Rotation: float = rotaion
        self.Surface: pygame.Surface = surface
        self.PosX: float = posX
        self.PosY: float = posY
        self.NegativeRotation: bool = negativeRotation
