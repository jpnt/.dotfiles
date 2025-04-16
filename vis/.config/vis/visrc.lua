require("vis")
local plugged = (function() -- bootstrap vis-plugged
  if not pcall(require, "plugins/vis-plugged") then
    os.execute("git clone -q https://github.com/jpnt/vis-plugged " ..
      (os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config") ..
      "/vis/plugins/vis-plugged")
  end
  return require("plugins/vis-plugged")
end)()

local tab_settings = {
  javascript = 2,
  typescript = 2,
  lua = 2,
  yaml = 2,
  python = 4,
  rust = 4,
}

plugged.add_plugin("https://github.com/lutobler/vis-commentary")
plugged.add_plugin("https://git.sr.ht/~mcepl/vis-fzf-open")
plugged.add_plugin("https://github.com/jpnt/vis-shout")
plugged.add_plugin("https://github.com/kupospelov/vis-ctags")
plugged.add_plugin("https://github.com/fischerling/vis-lspc")
-- plugged.add_plugin("https://github.com/jpnt/vis-autopairs")
plugged.require_all_plugins()

vis.events.subscribe(vis.events.INIT, function()
  vis:command("set theme twodark")
  -- vis:command("set theme base16-ashes")
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
  vis:command("set autoindent on")
  vis:command("set number")
  vis:command("set relativenumbers")

  local tabwidth = tab_settings[win.syntax or ""]
  if tabwidth then
    vis:command("set expandtab on")
    vis:command("set tabwidth " .. tabwidth)
  end
end)

vis.events.subscribe(vis.events.FILE_SAVE_PRE, function(file, path)
  if not path then return end
  local ext = path:match("^.+(%..+)$")
  if ext and (ext == ".rs" or ext == ".go" or ext == ".py" or ext == ".lua") then
    vis:command("lspc-format")
  end
end)
