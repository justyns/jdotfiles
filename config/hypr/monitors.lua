-- Samsung LC49G95T (Odyssey G9 49")
-- I switch between picture-by-picture and full screen often
--
--   full ultrawide  5120x1440 @ scale 1.25 -> 4096x1152 logical
--   PBP             2560x1440 @ scale 1.0

local OUTPUT = "DP-3"
local ULTRAWIDE_MIN_WIDTH = 5000

local function configure(ultrawide)
    hl.monitor({
        output   = OUTPUT,
        mode     = ultrawide and "5120x1440@120" or "2560x1440@120",
        scale    = ultrawide and 1.25 or 1.0,
        position = "auto",
        -- Clamp SDR on the wide-gamut panel.
        cm = "srgb",
        -- TODO: try supports_hdr = 0 + render.cm_auto_hdr = 1 for games (hyprwm/Hyprland#9064).
        supports_hdr = -1,
        vrr      = 3,
    })

    -- PBP's 2560px is too narrow for a centre master plus two columns.
    -- The master layout ignores mfact in 0.56.2.
    hl.config({ master = { orientation = ultrawide and "center" or "right" } })
end

-- In PBP the panel stops offering the full-width mode
local function panel_is_ultrawide()
    local mon = hl.get_monitor(OUTPUT)
    if not mon then
        return true
    end
    for _, mode in ipairs(mon.available_modes) do
        if mode.width >= ULTRAWIDE_MIN_WIDTH then
            return true
        end
    end
    return false
end

configure(panel_is_ultrawide())

hl.on("monitor.layout_changed", function()
    configure(panel_is_ultrawide())
end)
