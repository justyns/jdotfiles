local mod = "SUPER"

-- Descriptions are prefixed with the current group, which the keybinds cheatsheet uses for its tabs.
local group

-- Dispatchers by description, for the cheatsheet to run with `hyprctl dispatch 'keybind_actions["..."]'`.
keybind_actions = {}

local function bind(key, dispatcher, description, opts)
    opts = opts or {}
    opts.description = group .. ": " .. description
    if not opts.mouse then
        keybind_actions[opts.description] = dispatcher
        -- hypr-usage-log records this event.
        local action = dispatcher
        dispatcher = function()
            hl.dispatch(hl.dsp.event("bind>>" .. key .. "\t" .. opts.description))
            hl.dispatch(action)
        end
    end
    hl.bind(key, dispatcher, opts)
end

group = "Apps"
bind(mod .. " + RETURN", hl.dsp.exec_cmd("ghostty"), "Terminal")
-- Launcher prefix p/pe opens repos and t opens tmux sessions.
bind(mod .. " + SPACE", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"), "Launcher")
bind(mod .. " + CTRL + E", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher /emo"), "Emoji picker")
bind(mod .. " + CTRL + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"), "Clipboard history")
bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("noctalia msg panel-toggle wallpaper"), "Wallpaper picker")
bind(mod .. " + SLASH", hl.dsp.exec_cmd("keybinds"), "Show this cheatsheet")

group = "Windows"
bind(mod .. " + Q", hl.dsp.window.close(), "Close window")
bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }), "Toggle floating")
bind(mod .. " + P", hl.dsp.window.pseudo(), "Toggle pseudo-tiling")
bind(mod .. " + F", hl.dsp.window.fullscreen(), "Fullscreen")
bind(mod .. " + BACKSLASH", hl.dsp.layout("togglesplit"), "Toggle split direction")
bind(mod .. " + M", hl.dsp.exec_cmd("hypr-master-toggle"), "Centre window, or send it back")

bind(mod .. " + MINUS", hl.dsp.window.resize({ x = -80, y = 0, relative = true }), "Narrow window", { repeating = true })
bind(mod .. " + EQUAL", hl.dsp.window.resize({ x = 80, y = 0, relative = true }), "Widen window", { repeating = true })
bind(mod .. " + SHIFT + MINUS", hl.dsp.window.resize({ x = 0, y = -80, relative = true }), "Shorten window", { repeating = true })
bind(mod .. " + SHIFT + EQUAL", hl.dsp.window.resize({ x = 0, y = 80, relative = true }), "Heighten window", { repeating = true })

bind(mod .. " + left", hl.dsp.focus({ direction = "left" }), "Focus left")
bind(mod .. " + right", hl.dsp.focus({ direction = "right" }), "Focus right")
bind(mod .. " + up", hl.dsp.focus({ direction = "up" }), "Focus up")
bind(mod .. " + down", hl.dsp.focus({ direction = "down" }), "Focus down")

bind(mod .. " + H", hl.dsp.focus({ direction = "left" }), "Focus left")
bind(mod .. " + L", hl.dsp.focus({ direction = "right" }), "Focus right")
bind(mod .. " + K", hl.dsp.focus({ direction = "up" }), "Focus up")
bind(mod .. " + J", hl.dsp.focus({ direction = "down" }), "Focus down")

bind("ALT + TAB", hl.dsp.exec_cmd("noctalia msg window-switcher next"), "Next window")
bind("ALT + SHIFT + TAB", hl.dsp.exec_cmd("noctalia msg window-switcher prev"), "Previous window")

bind(mod .. " + mouse:272", hl.dsp.window.drag(), "Drag window", { mouse = true })
bind(mod .. " + mouse:273", hl.dsp.window.resize(), "Resize window", { mouse = true })

group = "Workspaces"
for i = 1, 10 do
    local key = i % 10
    bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }), "Go to workspace " .. i)
    bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), "Move window to workspace " .. i)
end

bind(mod .. " + TAB", hl.dsp.focus({ workspace = "previous" }), "Last visited workspace")
bind(mod .. " + N", hl.dsp.focus({ workspace = "emptynm" }), "First empty workspace")

bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "r+1" }), "Next workspace")
bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "r-1" }), "Previous workspace")

group = "Scratchpads"
bind(mod .. " + S", hl.dsp.exec_cmd("hypr-scratch toggle scratch"), "Toggle scratchpad")
bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratch" }), "Send window to scratchpad")
bind(mod .. " + D", hl.dsp.exec_cmd("hypr-scratch toggle tsugite"), "Toggle Tsugite")
bind(mod .. " + T", hl.dsp.exec_cmd("hypr-scratch toggle tsugite"), "Toggle Tsugite")
bind(mod .. " + A", hl.dsp.exec_cmd("hypr-scratch toggle agents"), "Toggle agents (local and forge)")
bind(mod .. " + SHIFT + A", hl.dsp.exec_cmd("hypr-scratch toggle agents ghostty.forge"), "Toggle agents, focusing forge")
bind(mod .. " + O", hl.dsp.exec_cmd("hypr-scratch pop"), "Pop scratchpad window into tiling, or send it back")

group = "Capture"
bind("PRINT", hl.dsp.exec_cmd("noctalia msg screenshot-region"), "Screenshot a region")
bind("SHIFT + PRINT", hl.dsp.exec_cmd("screenshot-window"), "Screenshot the focused window")
bind("CTRL + PRINT", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"), "Screenshot the monitor")
bind(mod .. " + PRINT", hl.dsp.exec_cmd("screenrec"), "Record a region, or stop")
bind(mod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("screenrec window"), "Record the focused window, or stop")
bind(mod .. " + CTRL + PRINT", hl.dsp.exec_cmd("captures"), "Browse recent captures")

group = "System"
bind(mod .. " + X", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"), "Control centre")
bind(mod .. " + Z", hl.dsp.exec_cmd("noctalia msg settings-open"), "Noctalia settings")
bind(mod .. " + SHIFT + M", hl.dsp.exec_cmd("noctalia msg panel-toggle session"), "Session menu")
bind(mod .. " + ESCAPE", hl.dsp.exec_cmd("noctalia msg session lock"), "Lock the screen")

group = "Media"
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), "Volume up", { locked = true, repeating = true })
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), "Volume down", { locked = true, repeating = true })
bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), "Mute", { locked = true })
bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), "Mute microphone", { locked = true })

bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), "Next track", { locked = true })
bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), "Play/pause", { locked = true })
bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), "Play/pause", { locked = true })
bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), "Previous track", { locked = true })
