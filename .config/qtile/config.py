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
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
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

mod = "mod1"
terminal = guess_terminal()

# Keybindings
keys = [
    # Switch between windows in current stack pane
    Key([mod], "j", lazy.layout.down(),
        desc="Move focus down in stack pane"),
    Key([mod], "k", lazy.layout.up(),
        desc="Move focus up in stack pane"),

    # Move windows up or down in current stack
    Key([mod, "control"], "j", lazy.layout.shuffle_down(),
        desc="Move window down in current stack "),
    Key([mod, "control"], "k", lazy.layout.shuffle_up(),
        desc="Move window up in current stack "),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(),
        desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "r", lazy.spawncmd(),
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
        Key([mod], str(i), lazy.group[group.name].toscreen(),
            desc=f"Switch to group {group.name}"),

        # Send to another group
        Key([mod, "shift"], str(i), lazy.window.togroup(group.name),
            desc=f"Switch to & move focused window to group {group.name}"),
    ])

# Layouts
monad_config = {
    "border_focus": "5100ff",
    "border_width": 1,
    "margin": 4,
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
    "padding": 5,
}

extension_defaults = widget_defaults.copy()

group_box_config = {
    "active": "ffffff",
    "background": "000000",
    "borderwidth": 4,
    "disable_drag": True,
    "fontsize": 14,
    "highlight_method": "line",
    "inactive": "bfcbdb",
    "margin_x": 0,
    "margin_y": 5,
    "other_current_screen_border": "000000",
    "other_screen_border": "000000",
    "padding_x": 5,
    "rounded": False,
    "this_current_screen_border": "5100ff",
    "this_screen_border": "5100ff",
}

# Screens
bar_config = {
    "background": "#000000",
    "opacity": 0.8,
}

wname_padding = 15

primary_bar = bar.Bar(
    [
        widget.CurrentScreen(),
        widget.GroupBox(**group_box_config),
        widget.Prompt(),
        widget.WindowName(padding=wname_padding),
        widget.CurrentLayout(),
        widget.Sep(height_percent=60),
        widget.Systray(),
        # widget.CPU(),
        # widget.Memory(),
        widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
        # widget.Sep(height_percent=60),
        # widget.CPUGraph(),
    ],
    30,
    **bar_config,
)

secondary_bar = bar.Bar(
    [
        widget.CurrentScreen(),
        widget.GroupBox(**group_box_config),
        widget.WindowName(padding=wname_padding),
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
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
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
