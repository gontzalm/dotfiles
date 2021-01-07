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

from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

MOD = "mod1"
TERMINAL = "alacritty"

# Challenger Deep Colors
COLORS = {
    "background":     "1e1c31",
    "foreground":     "cbe1e7",
    "black":          "141228",
    "red":            "ff5458",
    "green":          "62d196",
    "yellow":         "ffb378",
    "blue":           "65b2ff",
    "magenta":        "906cff",
    "cyan":           "63f2f1",
    "white":          "a6b3cc",
    "bright_black":   "565575",
    "bright_red":     "ff8080",
    "bright_green":   "95ffa4",
    "bright_yellow":  "ffe9aa",
    "bright_blue":    "91ddff",
    "bright_magenta": "c991e1",
    "bright_cyan":    "aaffe4",
    "bright_white":   "cbe3e7",
}

# Keybindings
keys = [
    # Switch between windows in current stack pane
    Key([MOD], "j", lazy.layout.down(),
        desc="Move focus down in stack pane"),
    Key([MOD], "k", lazy.layout.up(),
        desc="Move focus up in stack pane"),

    # Move windows up or down in current stack
    Key([MOD, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down in current stack "),
    Key([MOD, "shift"], "k", lazy.layout.shuffle_up(),
        desc="Move window up in current stack "),

    # Launch terminal
    Key([MOD], "Return", lazy.spawn(TERMINAL), desc="Launch terminal"),

    Key([MOD], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([MOD], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([MOD, "shift"], "r", lazy.restart(), desc="Restart qtile"),
    Key([MOD, "shift"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([MOD], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
]

# Groups
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
        # Switch to another group
        Key([MOD], str(i), lazy.group[group.name].toscreen(),
            desc=f"Switch to group {group.name}"),

        # Send to another group
        Key([MOD, "shift"], str(i), lazy.window.togroup(group.name),
            desc=f"Switch to & move focused window to group {group.name}"),
    ])

# Layouts
monad_config = {
    "border_focus": COLORS["cyan"],
    "border_width": 2,
    "margin": 5,
}

layouts = [
    layout.MonadTall(**monad_config),
    layout.MonadWide(**monad_config),
    layout.Max(),
    layout.Matrix()
]

# Widgets
widget_defaults = {
    "font": "Fira Code Nerd Font",
    "fontsize": 12,
    "foreground": COLORS["foreground"],
    "padding": 5,
}

extension_defaults = widget_defaults.copy()

curr_screen_config = {
    "active_color": COLORS["bright_green"],
    "active_text": "\uf2d0",
    "inactive_color": COLORS["bright_red"],
    "inactive_text": "\uf2d4",
}

group_box_config = {
    "active": COLORS["cyan"],
    "borderwidth": 4,
    "disable_drag": True,
    "fontsize": 14,
    "highlight_method": "line",
    "inactive": COLORS["bright_black"],
    "margin_x": 0,
    "margin_y": 5,
    "other_current_screen_border": COLORS["background"],
    "other_screen_border": COLORS["background"],
    "padding_x": 5,
    "rounded": False,
    "this_current_screen_border": COLORS["bright_yellow"] ,
    "this_screen_border": COLORS["bright_yellow"],
}

layout_config = {
    "foreground": COLORS["magenta"],
}

updates_config = {
    "colour_have_updates": COLORS["bright_red"],
    "colour_no_updates": COLORS["bright_green"],
    "distro": "Arch_checkupdates",
    "display_format": "\uf079 {updates}",
    "no_update_string": "\uf079",
    "update_interval": 60, 
}

# key_layout_config = {
    # "configured_keyboards": ["us", "es"],
    # "foreground": COLORS["blue"],
    # "option": "grp:lwin_toggle",
# }

clock_config = {
    "foreground": COLORS["blue"],
    "format": "%Y-%m-%d %a %H:%M",
}

# Screens
bar_config = {
    "background": COLORS["background"],
    "opacity": 0.9,
}

primary_bar = bar.Bar(
    [
        widget.CurrentScreen(**curr_screen_config),
        widget.Spacer(length=4),
        widget.GroupBox(**group_box_config),
        widget.Prompt(),
        widget.WindowName(),
        widget.CurrentLayout(**layout_config),
        widget.Sep(height_percent=60),
        widget.CheckUpdates(**updates_config),
        widget.Sep(height_percent=60),
        # widget.Sep(height_percent=60),
        # widget.KeyboardLayout(),
        widget.Systray(),
        # widget.CPU(),
        # widget.Memory(),
        widget.Clock(**clock_config),
        # widget.CPUGraph(),
    ],
    30,
    **bar_config,
)

secondary_bar = bar.Bar(
    [
        widget.CurrentScreen(**curr_screen_config),
        widget.Spacer(length=4),
        widget.GroupBox(**group_box_config),
        widget.WindowName(),
        widget.Clock(**clock_config),
    ],
    30,
    **bar_config,
)

screens = [
    Screen(
        top=primary_bar,
    ),
    Screen(
        top=secondary_bar,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([MOD], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([MOD], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([MOD], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
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
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "Qtile"
