hl.config({
    -- See the supports_hdr TODO in monitors.lua.
    render = { cm_auto_hdr = 0 },

    -- 2 leaves stale regions after a PBP/ultrawide switch. hyprwm/Hyprland#3740
    debug = { damage_tracking = 1 },

    general = {
        gaps_in     = 4,
        gaps_out    = 8,
        col = {
            active_border   = { colors = { "rgb(ca9ee6)", "rgb(8caaee)" }, angle = 45 },
            inactive_border = "rgb(414559)",
        },
        resize_on_border = true,
        allow_tearing    = true,
        layout = "dwindle",
    },

    decoration = {
        rounding = 8,
        shadow = {
            color = "rgba(232634ee)",
        },
        blur = {
            size   = 4,
            passes = 2,
        },
    },

    -- Splitting by aspect ratio always goes side-by-side at 4096px wide.
    dwindle = { smart_split = true },

    -- Orientation is set in monitors.lua.
    master = { slave_count_for_center_master = 1 },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },

    -- XWayland blurs at 1.25 scale
    xwayland = { force_zero_scaling = true },
})

hl.env("AQ_DRM_DEVICES", "/dev/dri/card1")
