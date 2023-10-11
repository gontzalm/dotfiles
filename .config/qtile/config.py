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

import subprocess

from libqtile import bar, hook, layout, widget
from libqtile.config import Match, Screen

from helpers import GroupsGenerator
from keybindings import keys
from variables import Config, WidgetsConfig


# GROUPS
groups_generator = GroupsGenerator(Config.GROUP_LIST)
groups = groups_generator.generate_groups()
keys.extend(groups_generator.generate_keybindings())

# LAYOUTS
layouts = [
    layout.MonadTall(**Config.MONAD),
    layout.MonadWide(**Config.MONAD),
    layout.Max(),
    layout.Matrix(),
]

# WIDGETS
SEP = widget.Sep(**WidgetsConfig.SEP)
SPACER = widget.Spacer(length=4)
CLOCK = widget.Clock(**WidgetsConfig.CLOCK)

# BARS AND SCREENS
primary_bar = bar.Bar(
    [
        widget.GroupBox(**WidgetsConfig.GROUP_BOX),
        widget.WindowName(),
        widget.CurrentLayout(**WidgetsConfig.LAYOUT),
        SEP,
        widget.MemoryGraph(**WidgetsConfig.MEMORY_GRAPH),
        SEP,
        widget.CPUGraph(**WidgetsConfig.CPU_GRAPH),
        SEP,
        widget.ThermalSensor(**WidgetsConfig.CPU_TEMP),
        SEP,
        widget.CheckUpdates(**WidgetsConfig.UPDATES),
        SEP,
        widget.Wlan(**WidgetsConfig.WLAN),
        SEP,
        widget.Battery(**WidgetsConfig.BATTERY),
        SEP,
        widget.Systray(),
        CLOCK,
    ],
    Config.BAR_SIZE,
    **Config.BAR,
)

secondary_bar = bar.Bar(
    [
        widget.GroupBox(**WidgetsConfig.GROUP_BOX),
        widget.WindowName(),
        CLOCK,
    ],
    Config.BAR_SIZE,
    **Config.BAR,
)

screens = [
    Screen(
        bottom=primary_bar,
    ),
    Screen(
        bottom=secondary_bar,
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
wmname = Config.WM_NAME


# AUTOSTART
@hook.subscribe.startup_once
def autostart() -> None:
    subprocess.run(str(Config.AUTOSTART_SCRIPT))
