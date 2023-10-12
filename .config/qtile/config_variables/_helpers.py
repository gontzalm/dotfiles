from enum import Enum

from libqtile.config import EzKey as Key
from libqtile.config import Group
from libqtile.command import lazy


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
    def hex(self) -> str:
        return self.value

    @property
    def fullhex(self) -> str:
        return f"#{self.value}"


class GroupsGenerator:
    def __init__(self, group_list: list[tuple[str, dict]]) -> None:
        self.group_list = group_list

    def generate_groups(self) -> list[Group]:
        return [Group(name, **kwargs) for name, kwargs in self.group_list]

    def generate_keybindings(self) -> list[Key]:
        return [
            key
            for i, group in enumerate(self.group_list, 1)
            for key in (
                Key(f"A-{i}", lazy.group[group[0]].toscreen()),
                Key(f"A-S-{i}", lazy.window.togroup(group[0])),
            )
        ]
