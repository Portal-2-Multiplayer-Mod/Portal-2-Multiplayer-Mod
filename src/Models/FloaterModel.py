import pygame


class Floater:
    def __init__(self, surface: pygame.Surface, x: float, y: float, negativeRotation: bool) -> None:
        """Defines a floating cube

        Parameters
        ----------
        surface : pygame.Surface
            _description_
        x : float
            _description_
        y : float
            _description_
        negativeRotation : bool
            _description_
        """

        self.Rotation: float = 1
        self.Surface: pygame.Surface = surface
        self.x: float = x
        self.y: float = y
        self.NegativeRotation: bool = negativeRotation
