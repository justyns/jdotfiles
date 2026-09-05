Name = "tmux"
NamePretty = "Tmux Sessions"
Icon = "utilities-terminal"
Description = "attach or kill a tmux session"
SearchName = true
Cache = false

function GetEntries()
    local entries = {}

    local handle = io.popen(
        "tmux list-sessions -F '#{session_name}\t#{session_windows}\t#{?session_attached,attached,detached}' 2>/dev/null")
    if handle then
        for line in handle:lines() do
            local name, windows, attached = line:match("^([^\t]+)\t([^\t]+)\t(.+)$")
            if name then
                table.insert(entries, {
                    Text = name,
                    Subtext = windows .. " windows, " .. attached,
                    Value = name,
                    Icon = "utilities-terminal",
                    Actions = {
                        attach = "ghostty -e tmux attach -d -t %VALUE%",
                        kill = "tmux kill-session -t %VALUE%",
                    },
                })
            end
        end
        handle:close()
    end

    table.insert(entries, {
        Text = "New session",
        Subtext = #entries .. " running",
        Value = "",
        Icon = "list-add",
        Actions = { attach = "ghostty -e tmux new-session" },
    })

    return entries
end
