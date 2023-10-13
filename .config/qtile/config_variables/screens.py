from libqtile import bar, qtile, widget
from libqtile.config import Screen

from config_variables._helpers import Helpers
from config_variables.conf import Config, WidgetsConfig

# WIDGETS
widget_defaults = WidgetsConfig.DEFAULT
SEP = widget.Sep(**WidgetsConfig.SEP)
SPACER = widget.Spacer(length=bar.STRETCH)
CLOCK = widget.Clock(**WidgetsConfig.CLOCK)

# BARS AND SCREENS
primary_bar = bar.Bar(
    [
        widget.GroupBox(**WidgetsConfig.GROUP_BOX),
        widget.CurrentLayout(**WidgetsConfig.LAYOUT),
        SPACER,
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
        CLOCK,
    ],
    Config.BAR_SIZE,
    **Config.BAR,
)

connected_monitors = len(qtile.core.outputs)
screens = [
    Screen(
        bottom=primary_bar if i == 0 else secondary_bar,
        wallpaper=Helpers.get_random_wallpaper(),
        wallpaper_mode="fill",
    )
    for i in range(connected_monitors)
]
