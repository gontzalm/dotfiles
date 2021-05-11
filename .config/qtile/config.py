# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, MODify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


import platform
from libqtile import bar, layout, widget
from libqtile.config import Group, Screen
from libqtile.config import EzKey as Key
from libqtile.lazy import lazy

# VARIABLES
TERMINAL = "alacritty"
COLORS = {
    "background": "1e1c31",
    "foreground": "cbe1e7",
    "black": "141228",
    "red": "ff5458",
    "green": "62d196",
    "yellow": "ffb378",
    "blue": "65b2ff",
    "magenta": "906cff",
    "cyan": "63f2f1",
    "white": "a6b3cc",
    "bright_black": "565575",
    "bright_red": "ff8080",
    "bright_green": "95ffa4",
    "bright_yellow": "ffe9aa",
    "bright_blue": "91ddff",
    "bright_magenta": "c991e1",
    "bright_cyan": "aaffe4",
    "bright_white": "cbe3e7",
    "pure_white": "ffffff",
}
MONAD_CONFIG = {
    "border_focus": COLORS["blue"],
    "border_width": 2,
    "margin": 5,
}
WIDGETS_CONFIG = {
    "font": "Fira Code Nerd Font",
    "fontsize": 12,
    "foreground": COLORS["pure_white"],
    "padding": 5,
}
CURR_SCREEN_WIDGET_CONFIG = {
    "active_color": COLORS["bright_green"],
    "active_text": "\uf2d0",
    "inactive_color": COLORS["bright_red"],
    "inactive_text": "\uf2d4",
}
GROUP_BOX_WIDGET_CONFIG = {
    "active": COLORS["pure_white"],
    "borderwidth": 4,
    "center_aligned": True,
    "disable_drag": True,
    "fontsize": 14,
    "highlight_method": "line",
    "inactive": COLORS["bright_black"],
    "margin_x": 0,
    "margin_y": 5,
    "other_current_screen_border": COLORS["bright_white"],
    "other_screen_border": COLORS["bright_white"],
    "padding_x": 7,
    "rounded": False,
    "this_current_screen_border": COLORS["cyan"] ,
    "this_screen_border": COLORS["cyan"],
}
PROMPT_WIDGET_CONFIG = {
    "cursor_color": COLORS["cyan"],
    "foreground": COLORS["cyan"],
    "prompt": "\uf120  "
}
LAYOUT_WIDGET_CONFIG = {
    "foreground": COLORS["bright_green"],
    "fmt": "\uf247  {}",
}
UPDATES_WIDGET_CONFIG = {
    "colour_have_updates": COLORS["bright_red"],
    "colour_no_updates": COLORS["pure_white"],
    "distro": "Arch_checkupdates",
    "display_format": "\uf079 {updates}",
    "no_update_string": "\uf079",
    "update_interval": 60,
}
CPU_WIDGET_CONFIG = {
    "format": "\uf2db {freq_current} GHz \uf0e4  {load_percent} %",
    "foreground": COLORS["bright_magenta"],
}
CPU_TEMP_WIDGET_CONFIG = {
    "fmt": "\uf2c9 CPU {}",
    "foreground": COLORS["bright_yellow"],
    "tag_sensor": "Tdie",
}
GPU_TEMP_WIDGET_CONFIG = {
    "fmt": "GPU {}",
    "foreground": COLORS["bright_yellow"],
    "tag_sensor": "edge",
}
CLOCK_WIDGET_CONFIG = {
    "foreground": COLORS["bright_blue"],
    "format": "%Y-%m-%d %a %H:%M",
}
SEP_CONFIG = {
    "linewidth": 2,
    "size_percent": 50,
}
BAR_CONFIG = {
    "background": COLORS["background"],
    "opacity": 0.9,
}

# KEYBINDINGS
keys = [
    # Qtile bindings
    Key("A-h", lazy.layout.left(), desc="Move focus left in stack pane"),
    Key("A-j", lazy.layout.down(), desc="Move focus down in stack pane"),
    Key("A-k", lazy.layout.up(), desc="Move focus up in stack pane"),
    Key("A-l", lazy.layout.right(), desc="Move focus right in stack pane"),
    Key(
        "A-S-h",
        lazy.layout.shuffle_left(),
        desc="Move window down in current stack "
    ),
    Key(
        "A-S-j",
        lazy.layout.shuffle_down(),
        desc="Move window down in current stack "
    ),
    Key(
        "A-S-k",
        lazy.layout.shuffle_up(),
        desc="Move window up in current stack "
    ),
    Key(
        "A-S-l",
        lazy.layout.shuffle_right(),
        desc="Move window up in current stack "
    ),
    Key("A-<Return>", lazy.spawn(TERMINAL), desc="Launch terminal"),
    Key("A-<Tab>", lazy.next_layout(), desc="Toggle between layouts"),
    Key("A-w", lazy.window.kill(), desc="Kill focused window"),
    Key("A-S-r", lazy.restart(), desc="Restart qtile"),
    Key("A-r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Personal bindings
    Key("<Print>",
        lazy.spawn("scrot -s /tmp/screenshot.png -e "
                   "'xclip -selection c -t image/png < $f'"),
        desc="Launch scrot and copy screenshot to clipboard",
    ),
]

# GROUPS
group_list = [
    ("\uf0ac", {"layout": "max"}),
    ("\uf085", {"layout": "monadtall"}),
    ("\uf121", {"layout": "monadtall"}),
    ("\uf27a", {"layout": "monadtall"}),
    ("\uf001", {"layout": "monadtall"}),
    ("\uf03d", {"layout": "max"}),
    ("\uf11b", {"layout": "max"}),
]

groups = [Group(name, **kwargs) for name, kwargs in group_list]

for i, group in enumerate(groups, 1):
    keys.extend([
        Key(
            f"A-{i}",
            lazy.group[group.name].toscreen(),
            desc=f"Switch to group {group.name}"
        ),
        Key(
            f"A-S-{i}",
            lazy.window.togroup(group.name),
            desc=f"Switch to & move focused window to group {group.name}"
        ),
    ])

# LAYOUTS
layouts = [
    layout.MonadTall(**MONAD_CONFIG),
    layout.MonadWide(**MONAD_CONFIG),
    layout.Max(),
    layout.Matrix()
]

# WIDGETS
widget_defaults = WIDGETS_CONFIG
extension_defaults = WIDGETS_CONFIG
SEP = widget.Sep(**SEP_CONFIG)
SPACER = widget.Spacer(length=4)
CLOCK = widget.Clock(**CLOCK_WIDGET_CONFIG)

# BARS AND SCREENS
if platform.node() == "archlinux":
    # BARS
    primary_bar = bar.Bar(
        [
            widget.CurrentScreen(**CURR_SCREEN_WIDGET_CONFIG),
            SPACER,
            widget.GroupBox(**GROUP_BOX_WIDGET_CONFIG),
            widget.Prompt(**PROMPT_WIDGET_CONFIG),
            widget.WindowName(),
            widget.CurrentLayout(**LAYOUT_WIDGET_CONFIG),
            SEP,
            widget.CheckUpdates(**UPDATES_WIDGET_CONFIG),
            SEP,
            widget.CPU(**CPU_WIDGET_CONFIG),
            SEP,
            widget.ThermalSensor(**CPU_TEMP_WIDGET_CONFIG),
            widget.ThermalSensor(**GPU_TEMP_WIDGET_CONFIG),
            SEP,
            widget.Systray(),
            # widget.Memory(),
            CLOCK,
        ],
        30,
        **BAR_CONFIG,
    )

    secondary_bar = bar.Bar(
        [
            widget.CurrentScreen(**CURR_SCREEN_WIDGET_CONFIG),
            SPACER,
            widget.GroupBox(**GROUP_BOX_WIDGET_CONFIG),
            widget.WindowName(),
            CLOCK,
        ],
        30,
        **BAR_CONFIG,
    )

    # SCREENS
    screens = [
        Screen(
            top=primary_bar,
        ),
        Screen(
            top=secondary_bar,
        ),
    ]
else: # miair13
    # BARS
    bar = bar.Bar(
        [
            widget.CurrentScreen(**CURR_SCREEN_WIDGET_CONFIG),
            SPACER,
            widget.GroupBox(**GROUP_BOX_WIDGET_CONFIG),
            widget.Prompt(**PROMPT_WIDGET_CONFIG),
            widget.WindowName(),
            widget.CurrentLayout(**LAYOUT_WIDGET_CONFIG),
            SEP,
            widget.CheckUpdates(**UPDATES_WIDGET_CONFIG),
            SEP,
            widget.CPU(**CPU_WIDGET_CONFIG),
            SEP,
            widget.Systray(),
            widget.BatteryIcon(),
            SEP,
            widget.Wlan(),
            # widget.Memory(),
            CLOCK,
        ],
        30,
        **BAR_CONFIG,
    )

    # SCREENS
    screens = [
        Screen(
            top=bar,
        ),
    ]

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
wmname = "Qtile"
