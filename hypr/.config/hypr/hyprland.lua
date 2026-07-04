local terminal = "ghostty"
local menu = "tofi-drun -c ~/.config/tofi/config --drun-launch=true"
local mod = "ALT"

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.on("hyprland.start", function()
    hl.exec_cmd("dunst")
    hl.exec_cmd("systemctl --user start plasma-polkit-agent")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprlock")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("pypr")
    hl.exec_cmd("kanshi")
    hl.exec_cmd("trayscale --hide-window")
end)

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgb(8aadf4)", "rgb(24273A)", "rgb(24273A)", "rgb(8aadf4)" }, angle = 45 },
            inactive_border = { colors = { "rgb(24273A)", "rgb(24273A)", "rgb(24273A)", "rgb(24273A)" }, angle = 45 },
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 0.75,
        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    input = {
        kb_layout  = "us",
        kb_options = "caps:swapescape",
        follow_mouse = 1,
        sensitivity = 0.5,
        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + W", hl.dsp.window.close())
hl.bind(mod .. " + P", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + ESCAPE", hl.dsp.exec_cmd("wlogout"))

hl.bind(mod .. " + E", hl.dsp.exec_cmd("pypr-client toggle yazi"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("pypr-client toggle bluetooth"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("pypr-client toggle network"))

hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -m"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true })

hl.workspace_rule({ workspace = "1", default_name = "web" })
hl.workspace_rule({ workspace = "2", default_name = "chat" })
hl.workspace_rule({ workspace = "3", default_name = "dev" })
hl.workspace_rule({ workspace = "4", default_name = "music" })
hl.workspace_rule({ workspace = "5", default_name = "other" })

hl.window_rule({
    name  = "supress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "pyprland-scratchpads",
    match = { class = "^(pypr\\..*|io.github.kaii_lb.Overskride|org.netrs.ui)$" },
    opacity = "0.90 0.90",
    rounding = 15,
    border_size = 2,
    border_color = "rgba(89b4faee) rgba(f38ba8ee) 45deg",
    dim_around = true,
})
