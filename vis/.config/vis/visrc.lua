require("vis")
local plugged = (function() -- bootstrap vis-plugged
  if not pcall(require, "plugins/vis-plugged") then
    os.execute("git clone -q https://github.com/jpnt/vis-plugged " ..
      (os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config") ..
      "/vis/plugins/vis-plugged")
  end
  return require("plugins/vis-plugged")
end)()

-- better api required!!!
--     search automatically in plugins folder!
--     add_plugins(table)
--     better naming. config/enable? just like in nvim lsp?
--        EXAMPLE
--        require("plugged") -> will search vis/plugins/*/init.lua
--        plugged.config(plugin url, github and gitlab doesnt need full url)
--        plugged.enable(specific plugin)
--        plugged.enable_all()
--     plugged-lock.json for controlled plugin deps
--     better print/logs
-- nvim is so good rn that i dont want to spend time on this for the time being. i will keep this as a note.

plugged.add_plugin("https://github.com/lutobler/vis-commentary")
plugged.add_plugin("https://git.sr.ht/~mcepl/vis-fzf-open")
plugged.add_plugin("https://github.com/fischerling/vis-lspc")
plugged.add_plugin("https://github.com/jpnt/vis-shout")
plugged.add_plugin("https://github.com/jpnt/vis-autopairs")
plugged.add_plugin("https://github.com/seifferth/vis-editorconfig") -- requires: editorconfig-core-lua
--plugged.add_plugin("https://github.com/jpnt/vis-recentf") -- SLOWS DOWN!!! only read after pressing Ctrl-P !!!
plugged.require_all_plugins()

vis.events.subscribe(vis.events.INIT, function()
  vis:command("set theme twodark")
  vis:map(vis.modes.NORMAL, '<C-o>', ':recentf<Enter>')
  vis:map(vis.modes.NORMAL, '<C-p>', ':fzf<Enter>')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
  vis:command("set number")
  vis:command("set relativenumbers")
  vis:command("set autoindent on")
end)

vis.events.subscribe(vis.events.FILE_SAVE_PRE, function(file, path)
  if not path then return end
  vis:command("lspc-format") -- TODO: if lsp available, then format
  return true
end)
