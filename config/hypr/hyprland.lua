-- https://wiki.hypr.land/Configuring/

require("monitors")
require("looknfeel")
require("workspaces")
require("bindings")
require("windowrules")
require("autostart")

-- Noctalia appends its own require unless this file contains require("noctalia").
local ok, noctalia = pcall(function() return require("noctalia") end)
if ok then
    noctalia.apply_theme()
end
