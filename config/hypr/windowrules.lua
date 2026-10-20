hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

hl.window_rule({
    name      = "tsugite-scratchpad",
    match     = { class = "^FFPWA-01KK5FDAGQ0CBSMS3YVHQK17R8$" },
    workspace = "special:tsugite",
})

hl.window_rule({
    name   = "fzf-popups",
    match  = { title = "^(Keybinds|Captures)$" },
    float  = true,
    size   = "1100 750",
    center = true,
})

hl.window_rule({
    name  = "float-dialogs",
    match = { modal = true },
    float  = true,
    center = true,
})

hl.window_rule({
    name   = "minecraft-windowed",
    match  = { initial_class = "^(Minecraft.*)$" },
    idle_inhibit    = "fullscreen",
    immediate       = true,
    no_blur   = true,
    no_shadow = true,
    no_anim   = true,
})
