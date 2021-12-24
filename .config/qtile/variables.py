from palette import Colors


class Config:
    TERMINAL = "alacritty"
    MONAD_CONFIG = {
        "border_focus": Colors.blue,
        "border_width": 2,
        "margin": 5,
    }
    BAR_CONFIG = {
        "background": Colors.background,
        "opacity": 0.9,
    }
    DMENU_CONFIG = {
        "background": f"#{Colors.background}",
        "dmenu_prompt": "Run: ",
        "font": "Fira Code Nerd Font",
        "fontsize": 10,
        "foreground": f"#{Colors.white}",
        "selected_background": f"#{Colors.magenta}",
        "selected_foreground": f"#{Colors.white}",
    }


class WidgetsConfig:
    DEFAULT_CONFIG = {
        "font": "Fira Code Nerd Font",
        "fontsize": 12,
        "foreground": Colors.white,
        "padding": 5,
    }
    CURR_SCREEN_WIDGET_CONFIG = {
        "active_color": Colors.bright_green,
        "active_text": "\uf2d0",
        "inactive_color": Colors.bright_red,
        "inactive_text": "\uf2d4",
    }
    GROUP_BOX_WIDGET_CONFIG = {
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
    LAYOUT_WIDGET_CONFIG = {
        "foreground": Colors.bright_green,
        "fmt": "\uf247  {}",
    }
    UPDATES_WIDGET_CONFIG = {
        "colour_have_updates": Colors.bright_red,
        "colour_no_updates": Colors.white,
        "distro": "Arch_checkupdates",
        "display_format": "\uf079 {updates}",
        "no_update_string": "\uf079 ",
        "update_interval": 60,
    }
    CPU_WIDGET_CONFIG = {
        "format": "\uf2db {freq_current} GHz \uf0e4  {load_percent} %",
        "foreground": Colors.bright_magenta,
    }
    CPU_TEMP_WIDGET_CONFIG = {
        "fmt": "\uf2c9 CPU {}",
        "foreground": Colors.bright_yellow,
        "tag_sensor": "Tdie",
    }
    GPU_TEMP_WIDGET_CONFIG = {
        "fmt": "GPU {}",
        "foreground": Colors.bright_yellow,
        "tag_sensor": "edge",
    }
    WLAN_WIDGET_CONFIG = {
        "format": "{essid} {percent:2.0%}",
        "interface": "wlp2s0",
    }
    CLOCK_WIDGET_CONFIG = {
        "foreground": Colors.bright_blue,
        "format": "%Y-%m-%d %a %H:%M",
    }
    SEP_CONFIG = {
        "linewidth": 2,
        "size_percent": 50,
    }
