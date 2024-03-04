from Models.ButtonModel import Button


class PopupBox():
    def __init__(self, title: str, body: str, buttons: list[Button]):
        self.Title = title
        self.Body = body
        self.Buttons = buttons