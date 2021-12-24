from libqtile.config import EzKey as Key
from libqtile.config import Group
from libqtile.command import lazy


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
