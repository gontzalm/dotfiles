from libqtile.config import EzKey as Key
from libqtile.config import KeyChord
from libqtile.command import lazy

from config_variables.conf import Config
from config_variables.groups import group_keys

mod_key_no_ez = next(v for k, v in Key.modifier_keys.items() if k == Config.MOD_KEY)

keys = [
    Key(
        f"{Config.MOD_KEY}-h",
        lazy.layout.left(),
        desc="Move focus left in stack pane.",
    ),
    Key(
        f"{Config.MOD_KEY}-j",
        lazy.layout.down(),
        desc="Move focus down in stack pane.",
    ),
    Key(
        f"{Config.MOD_KEY}-k",
        lazy.layout.up(),
        desc="Move focus up in stack pane.",
    ),
    Key(
        f"{Config.MOD_KEY}-l",
        lazy.layout.right(),
        desc="Move focus right in stack pane.",
    ),
    Key(
        f"{Config.MOD_KEY}-S-h",
        lazy.layout.shuffle_left(),
        desc="Move window down in current stack.",
    ),
    Key(
        f"{Config.MOD_KEY}-S-j",
        lazy.layout.shuffle_down(),
        desc="Move window down in current stack.",
    ),
    Key(
        f"{Config.MOD_KEY}-S-k",
        lazy.layout.shuffle_up(),
        desc="Move window up in current stack.",
    ),
    Key(
        f"{Config.MOD_KEY}-S-l",
        lazy.layout.shuffle_right(),
        desc="Move window up in current stack.",
    ),
    Key(
        f"{Config.MOD_KEY}-<Return>",
        lazy.spawn(Config.TERMINAL),
        desc="Launch terminal.",
    ),
    Key(
        f"{Config.MOD_KEY}-<Tab>",
        lazy.next_layout(),
        desc="Toggle between layouts.",
    ),
    Key(
        f"{Config.MOD_KEY}-w",
        lazy.window.kill(),
        desc="Kill focused window.",
    ),
    Key(
        f"{Config.MOD_KEY}-S-r",
        lazy.reload_config(),
        desc="Reload config.",
    ),
    Key(
        f"{Config.MOD_KEY}-r",
        lazy.spawn("fuzzel"),
        desc="Run fuzzel.",
    ),
    Key(
        f"{Config.MOD_KEY}-p",
        lazy.spawn("slurp | grim -g - - | wl-copy", shell=True),
        desc="Screenshot a region and copy it to the clipboard.",
    ),
    Key(f"{Config.MOD_KEY}-b", lazy.widget["bluetooth"].scroll_up()),
    Key(f"{Config.MOD_KEY}-S-b", lazy.widget["bluetooth"].click()),
]

keys.extend(group_keys)
