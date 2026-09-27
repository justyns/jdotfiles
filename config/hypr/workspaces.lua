for i = 1, 5 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "DP-3",
        persistent = true,
        default = i == 1,
        layout = i <= 3 and "master" or nil,
    })
end

hl.workspace_rule({ workspace = "special:scratch", on_created_empty = "ghostty" })

-- Site ULID from `firefoxpwa profile list`. The window class is FFPWA-<ULID>.
hl.workspace_rule({
    workspace = "special:tsugite",
    on_created_empty = "firefoxpwa site launch 01KK5FDAGQ0CBSMS3YVHQK17R8",
})

hl.workspace_rule({
    workspace = "special:agents",
    on_created_empty = "ghostty -e tmux new-session -A -s agents",
})

-- forge is via mosh/ssh, it's my remote dev vm
hl.workspace_rule({
    workspace = "special:forge",
    on_created_empty = "ghostty -e mosh forge -- tmux new-session -A -s agents",
})
