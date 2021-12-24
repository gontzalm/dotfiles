from libqtile.config import EzKey as Key
from libqtile.config import Group
from libqtile.command import lazy


class GroupsGenerator:
    GROUP_LIST = [
        ("\uf0ac", {"layout": "max"}),
        ("\uf085", {"layout": "monadtall"}),
        ("\uf121", {"layout": "monadtall"}),
        ("\uf27a", {"layout": "monadtall"}),
        ("\uf001", {"layout": "monadtall"}),
        ("\uf03d", {"layout": "max"}),
        ("\uf11b", {"layout": "max"}),
    ]

    def generate_groups(self) -> list[Group]:
        return [Group(name, **kwargs) for name, kwargs in self.GROUP_LIST]

    def generate_keybindings(self) -> list[Key]:
        return [
            key
            for i, group in enumerate(self.GROUP_LIST, 1)
            for key in (
                Key(f"A-{i}", lazy.group[group[0]].toscreen()),
                Key(f"A-S-{i}", lazy.window.togroup(group[0])),
            )
        ]
