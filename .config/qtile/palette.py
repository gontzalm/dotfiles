from enum import Enum


class Color(Enum):
    BACKGROUND = "1e1c31"
    FOREGROUND = "cbe1e7"
    BLACK = "141228"
    GRAY = "565575"
    WHITE = "ffffff"
    RED = "ff5458"
    GREEN = "62d196"
    YELLOW = "ffb378"
    BLUE = "65b2ff"
    MAGENTA = "906cff"
    CYAN = "63f2f1"
    BRIGHT_RED = "ff8080"
    BRIGHT_GREEN = "95ffa4"
    BRIGHT_YELLOW = "ffe9aa"
    BRIGHT_BLUE = "91ddff"
    BRIGHT_MAGENTA = "c991e1"
    BRIGHT_CYAN = "aaffe4"

    @property
    def hex(self):
        return self.value

    @property
    def fullhex(self):
        return f"#{self.value}"
