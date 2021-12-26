from palette import Colors


class Config:
    MOD_KEY = "A"
    TERMINAL = "alacritty"
    WM_NAME = "Qtile"
    GROUP_LIST = [
        ("\uf0ac", {"layout": "max"}),
        ("\uf085", {"layout": "monadtall"}),
        ("\uf121", {"layout": "monadtall"}),
        ("\uf27a", {"layout": "monadtall"}),
        ("\uf001", {"layout": "monadtall"}),
        ("\uf03d", {"layout": "max"}),
        ("\uf11b", {"layout": "max"}),
    ]
    MONAD = {
        "border_focus": Colors.magenta,
        "border_width": 2,
        "margin": 5,
    }
    BAR_SIZE = 30
    BAR = {
        "background": Colors.background,
        "opacity": 0.9,
    }
    DMENU = {
        "background": f"#{Colors.background}",
        "dmenu_prompt": "Run: ",
        "font": "Fira Code Nerd Font",
        "fontsize": 10,
        "foreground": f"#{Colors.white}",
        "selected_background": f"#{Colors.magenta}",
        "selected_foreground": f"#{Colors.white}",
    }


class WidgetsConfig:
    DEFAULT = {
        "font": "Fira Code Nerd Font",
        "fontsize": 12,
        "foreground": Colors.white,
        "padding": 5,
    }
    SEP = {
        "linewidth": 2,
        "size_percent": 50,
    }
    CURR_SCREEN = {
        "active_color": Colors.bright_green,
        "active_text": "\uf2d0",
        "inactive_color": Colors.bright_red,
        "inactive_text": "\uf2d4",
    }
    GROUP_BOX = {
        "active": Colors.white,
        "borderwidth": 4,
        "center_aligned": True,
        "disable_drag": True,
        "fontsize": 14,
        "highlight_method": "line",
        "inactive": Colors.grey,
        "margin_x": 0,
        "margin_y": 5,
        "other_current_screen_border": Colors.white,
        "other_screen_border": Colors.white,
        "padding_x": 7,
        "rounded": False,
        "this_current_screen_border": Colors.cyan,
        "this_screen_border": Colors.cyan,
    }
    LAYOUT = {
        "foreground": Colors.bright_magenta,
        "fmt": "\uf247  {}",
    }
    MEMORY_GRAPH = {
        "border_color": Colors.white,
        "border_width": 2,
        "fill_color": Colors.bright_blue,
        "graph_color": Colors.blue,
        "type": "linefill",
    }
    CPU_GRAPH = {
        "border_color": Colors.white,
        "border_width": 2,
        "fill_color": Colors.bright_red,
        "graph_color": Colors.red,
        "type": "linefill",
    }
    CPU_TEMP = {
        "fmt": "\uf2c9 {}",
        "foreground": Colors.bright_yellow,
        "tag_sensor": "Package id 0",
    }
    UPDATES = {
        "colour_have_updates": Colors.bright_red,
        "colour_no_updates": Colors.white,
        "distro": "Arch_checkupdates",
        "display_format": "\uf079 {updates}",
        "no_update_string": "\uf079 ",
        "update_interval": 60,
    }
    WLAN = {
        "foreground": Colors.white,
        "format": "{essid} {percent:2.0%}",
        "interface": "wlp2s0",
    }
    BATTERY = {
        "charge_char": "\uf0e7",
        "discharge_char": "\uf242 ",
        "foreground": Colors.bright_green,
        "format": "{char} {percent:2.0%} {hour:d}:{min:02d}",
        "low_foreground": Colors.red,
        "low_percentage": 0.2,
        "notify_below": 0.1,
    }
    CLOCK = {
        "foreground": Colors.bright_blue,
        "format": "%Y-%m-%d %a %H:%M",
    }
