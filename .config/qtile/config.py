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
from libqtile.config import Match, Screen

from helpers import GroupsGenerator
from keybindings import keys
from variables import Config, WidgetsConfig


# create groups and exend keybindings
groups_generator = GroupsGenerator(Config.GROUP_LIST)
groups = groups_generator.generate_groups()
keys.extend(groups_generator.generate_keybindings())

# LAYOUTS
layouts = [
    layout.MonadTall(**Config.MONAD_CONFIG),
    layout.MonadWide(**Config.MONAD_CONFIG),
    layout.Max(),
    layout.Matrix(),
]

# WIDGETS
widget_defaults = WidgetsConfig.DEFAULT_CONFIG
SEP = widget.Sep(**WidgetsConfig.SEP_CONFIG)
SPACER = widget.Spacer(length=4)
CLOCK = widget.Clock(**WidgetsConfig.CLOCK_WIDGET_CONFIG)

# BARS AND SCREENS
secondary_bar = bar.Bar(
    [
        widget.CurrentScreen(**WidgetsConfig.CURR_SCREEN_WIDGET_CONFIG),
        SPACER,
        widget.GroupBox(**WidgetsConfig.GROUP_BOX_WIDGET_CONFIG),
        widget.WindowName(),
        CLOCK,
    ],
    30,
    **Config.BAR_CONFIG,
)

# set different primary_bar for PC and laptop
if platform.node() == "archlinux":
    primary_bar = bar.Bar(
        [
            widget.CurrentScreen(**WidgetsConfig.CURR_SCREEN_WIDGET_CONFIG),
            SPACER,
            widget.GroupBox(**WidgetsConfig.GROUP_BOX_WIDGET_CONFIG),
            widget.WindowName(),
            widget.CurrentLayout(**WidgetsConfig.LAYOUT_WIDGET_CONFIG),
            SEP,
            widget.CheckUpdates(**WidgetsConfig.UPDATES_WIDGET_CONFIG),
            SEP,
            widget.CPU(**WidgetsConfig.CPU_WIDGET_CONFIG),
            SEP,
            widget.ThermalSensor(**WidgetsConfig.CPU_TEMP_WIDGET_CONFIG),
            widget.ThermalSensor(**WidgetsConfig.GPU_TEMP_WIDGET_CONFIG),
            SEP,
            widget.Systray(),
            # widget.Memory(),
            CLOCK,
        ],
        30,
        **Config.BAR_CONFIG,
    )

else:  # miair13
    primary_bar = bar.Bar(
        [
            widget.CurrentScreen(**WidgetsConfig.CURR_SCREEN_WIDGET_CONFIG),
            SPACER,
            widget.GroupBox(**WidgetsConfig.GROUP_BOX_WIDGET_CONFIG),
            widget.WindowName(),
            widget.CurrentLayout(**WidgetsConfig.LAYOUT_WIDGET_CONFIG),
            SEP,
            widget.CheckUpdates(**WidgetsConfig.UPDATES_WIDGET_CONFIG),
            SEP,
            widget.CPU(**WidgetsConfig.CPU_WIDGET_CONFIG),
            SEP,
            SPACER,
            widget.BatteryIcon(),
            SEP,
            widget.Wlan(**WidgetsConfig.WLAN_WIDGET_CONFIG),
            SEP,
            widget.Systray(),
            CLOCK,
        ],
        30,
        **Config.BAR_CONFIG,
    )

screens = [
    Screen(
        top=primary_bar,
    ),
    Screen(
        top=secondary_bar,
    ),
]

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
wmname = "Qtile"
