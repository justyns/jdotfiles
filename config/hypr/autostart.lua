local env = {
    QT_QPA_PLATFORMTHEME = "qt6ct",
    XCURSOR_THEME = "catppuccin-frappe-blue-cursors",
    XCURSOR_SIZE = "24",
    HYPRCURSOR_THEME = "catppuccin-frappe-blue-cursors",
    HYPRCURSOR_SIZE = "24",
    -- Fixes KDE's empty "Open With" menu. Run kbuildsycoca6 --noincremental after changing.
    XDG_MENU_PREFIX = "plasma-",
}

local home_bin = os.getenv("HOME") .. "/bin"
local path = os.getenv("PATH")
if not (":" .. path .. ":"):find(":" .. home_bin .. ":", 1, true) then
    env.PATH = home_bin .. ":" .. path
end

local assignments = {}
for name, value in pairs(env) do
    hl.env(name, value)
    table.insert(assignments, name .. "='" .. value .. "'")
end

hl.on("hyprland.start", function()
    hl.exec_cmd(
        "systemctl --user set-environment " .. table.concat(assignments, " ")
            .. " && systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE"
            .. " && systemctl --user start hyprland-session.target"
    )
    hl.exec_cmd("noctalia --daemon")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- TODO: where am I supposed to add auto-start apps to?
    hl.exec_cmd("/opt/1Password/1password --silent")
end)

hl.on("hyprland.shutdown", function()
    os.execute("systemctl --user stop hyprland-session.target")
end)
