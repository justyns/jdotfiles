-- Git repos under ~/dev. Open in a terminal, editor, or file manager.
Name = "projects"
NamePretty = "Projects"
Icon = "folder-development"
Description = "git repos in ~/dev"
SearchName = true
Cache = true

local DEV = os.getenv("HOME") .. "/dev"

function GetEntries()
    local entries = {}

    local handle = io.popen("fd -H -t d '^\\.git$' '" .. DEV .. "' --max-depth 3 2>/dev/null")
    if not handle then
        return entries
    end

    for line in handle:lines() do
        local dir = line:gsub("/%.git/?$", "")
        local name = dir:match("([^/]+)$")
        table.insert(entries, {
            Text = name,
            Subtext = dir:gsub("^" .. os.getenv("HOME"), "~"),
            Value = dir,
            Icon = "folder-development",
            Actions = {
                terminal = "ghostty --working-directory=%VALUE%",
                editor = "ghostty --working-directory=%VALUE% -e nvim",
                files = "dolphin %VALUE%",
                copypath = "wl-copy -n %VALUE%",
            },
        })
    end
    handle:close()

    table.sort(entries, function(a, b) return a.Text < b.Text end)
    return entries
end
