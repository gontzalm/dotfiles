from libqtile import extension
from libqtile.config import EzKey as Key
from libqtile.command import lazy

from variables import Config

keys = [
    # qtile bindings
    Key(
        f"{Config.MOD_KEY}-h", lazy.layout.left(), desc="Move focus left in stack pane"
    ),
    Key(
        f"{Config.MOD_KEY}-j", lazy.layout.down(), desc="Move focus down in stack pane"
    ),
    Key(f"{Config.MOD_KEY}-k", lazy.layout.up(), desc="Move focus up in stack pane"),
    Key(
        f"{Config.MOD_KEY}-l",
        lazy.layout.right(),
        desc="Move focus right in stack pane",
    ),
    Key(
        f"{Config.MOD_KEY}-S-h",
        lazy.layout.shuffle_left(),
        desc="Move window down in current stack ",
    ),
    Key(
        f"{Config.MOD_KEY}-S-j",
        lazy.layout.shuffle_down(),
        desc="Move window down in current stack ",
    ),
    Key(
        f"{Config.MOD_KEY}-S-k",
        lazy.layout.shuffle_up(),
        desc="Move window up in current stack ",
    ),
    Key(
        f"{Config.MOD_KEY}-S-l",
        lazy.layout.shuffle_right(),
        desc="Move window up in current stack ",
    ),
    Key(
        f"{Config.MOD_KEY}-<Return>",
        lazy.spawn(Config.TERMINAL),
        desc="Launch terminal",
    ),
    Key(f"{Config.MOD_KEY}-<Tab>", lazy.next_layout(), desc="Toggle between layouts"),
    Key(f"{Config.MOD_KEY}-w", lazy.window.kill(), desc="Kill focused window"),
    Key(f"{Config.MOD_KEY}-S-r", lazy.restart(), desc="Restart qtile"),
    Key(f"{Config.MOD_KEY}-r", lazy.run_extension(extension.DmenuRun(**Config.DMENU))),
    # personal bindings
    Key(
        "<Print>",
        lazy.spawn(
            "scrot -s /tmp/screenshot.png -e " "'xclip -selection c -t image/png < $f'"
        ),
        desc="Launch scrot and copy screenshot to clipboard",
    ),
]
