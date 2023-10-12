from pathlib import Path

from config_variables._helpers import Color


class Config:
    MOD_KEY = "A"
    TERMINAL = "alacritty"
    WM_NAME = "Qtile"
    AUTOSTART_SCRIPT = Path("~/.config/qtile/autostart.sh").expanduser()
    GROUP_LIST = [
        ("\uf0ac", {"layout": "max"}),
        ("\uf120", {"layout": "monadtall"}),
        ("\uf121", {"layout": "max"}),
        ("\uf27a", {"layout": "max"}),
        ("\uf001", {"layout": "monadtall"}),
        ("\uf03d", {"layout": "max"}),
        ("\uf11b", {"layout": "max"}),
    ]
    BAR_SIZE = 30
    BAR = {
        "background": Color.BACKGROUND.hex,
        "margin": 5,
        "opacity": 0,
    }


class LayoutsConfig:
    MAX = {"margin": 5}
    MONAD = {
        "border_focus": Color.MAGENTA.hex,
        "border_width": 2,
        "margin": 5,
    }


class WidgetsConfig:
    DEFAULT = {
        "font": "SFMono NerdFont Mono",
        "fontsize": 13,
        "foreground": Color.WHITE.hex,
        "padding": 5,
    }
    SEP = {
        "linewidth": 2,
        "size_percent": 50,
    }
    CURR_SCREEN = {
        "active_color": Color.BRIGHT_GREEN.hex,
        "active_text": "\uf2d0",
        "inactive_color": Color.BRIGHT_RED.hex,
        "inactive_text": "\uf2d4",
    }
    GROUP_BOX = {
        "active": Color.WHITE.hex,
        "borderwidth": 5,
        "center_aligned": True,
        "disable_drag": True,
        "fontsize": 22,
        "highlight_method": "line",
        "inactive": Color.GRAY.hex,
        "margin_x": 0,
        "margin_y": 5,
        "other_current_screen_border": Color.WHITE.hex,
        "other_screen_border": Color.WHITE.hex,
        "padding_x": 7,
        "rounded": False,
        "this_current_screen_border": Color.MAGENTA.hex,
        "this_screen_border": Color.MAGENTA.hex,
    }
    LAYOUT = {
        "foreground": Color.BRIGHT_MAGENTA.hex,
        "fmt": "\uf247  {}",
    }
    MEMORY_GRAPH = {
        "border_color": Color.WHITE.hex,
        "border_width": 2,
        "fill_color": Color.BRIGHT_BLUE.hex,
        "graph_color": Color.BLUE.hex,
        "type": "linefill",
    }
    CPU_GRAPH = {
        "border_color": Color.WHITE.hex,
        "border_width": 2,
        "fill_color": Color.BRIGHT_RED.hex,
        "graph_color": Color.RED.hex,
        "type": "linefill",
    }
    CPU_TEMP = {
        "fmt": "\uf2c9 {}",
        "foreground": Color.BRIGHT_YELLOW.hex,
        "tag_sensor": "Package id 0",
    }
    UPDATES = {
        "colour_have_updates": Color.BRIGHT_RED.hex,
        "colour_no_updates": Color.WHITE.hex,
        "distro": "Arch_checkupdates",
        "display_format": "\uf079 {updates}",
        "fontsize": 14,
        "no_update_string": "\uf079 ",
        "update_interval": 60,
    }
    WLAN = {
        "foreground": Color.WHITE.hex,
        "format": "{essid} {percent:2.0%}",
        "interface": "wlp2s0",
    }
    BATTERY = {
        "charge_char": "\uf0e7",
        "discharge_char": "\uf242 ",
        "foreground": Color.BRIGHT_GREEN.hex,
        "format": "{char} {percent:2.0%} {hour:d}:{min:02d}",
        "low_foreground": Color.RED.hex,
        "low_percentage": 0.2,
        "notify_below": 0.1,
    }
    CLOCK = {
        "foreground": Color.BRIGHT_BLUE.hex,
        "format": "%Y-%m-%d %a %H:%M",
    }
