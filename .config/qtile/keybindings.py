from libqtile import extension, qtile
from libqtile.config import EzKey as Key
from libqtile.command import lazy

from variables import Config

keys = [
    # Qtile bindings
    Key("A-h", lazy.layout.left(), desc="Move focus left in stack pane"),
    Key("A-j", lazy.layout.down(), desc="Move focus down in stack pane"),
    Key("A-k", lazy.layout.up(), desc="Move focus up in stack pane"),
    Key("A-l", lazy.layout.right(), desc="Move focus right in stack pane"),
    Key("A-S-h", lazy.layout.shuffle_left(), desc="Move window down in current stack "),
    Key("A-S-j", lazy.layout.shuffle_down(), desc="Move window down in current stack "),
    Key("A-S-k", lazy.layout.shuffle_up(), desc="Move window up in current stack "),
    Key("A-S-l", lazy.layout.shuffle_right(), desc="Move window up in current stack "),
    Key("A-<Return>", lazy.spawn(Config.TERMINAL), desc="Launch terminal"),
    Key("A-<Tab>", lazy.next_layout(), desc="Toggle between layouts"),
    Key("A-w", lazy.window.kill(), desc="Kill focused window"),
    Key("A-S-r", lazy.restart(), desc="Restart qtile"),
    # Personal bindings
    Key("A-r", lazy.run_extension(extension.DmenuRun(**Config.DMENU_CONFIG))),
    Key(
        "<Print>",
        lazy.spawn(
            "scrot -s /tmp/screenshot.png -e " "'xclip -selection c -t image/png < $f'"
        ),
        desc="Launch scrot and copy screenshot to clipboard",
    ),
]
