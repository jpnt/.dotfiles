require("vis")
local plugged = (function() if not pcall(require, "plugins/vis-plug") then
	os.execute("git clone -q https://github.com/jpnt/vis-plugged " ..
	(os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config") ..
	"/vis/plugins/vis-plugged") -- bootstrap vis-plugged
end return require("plugins/vis-plugged") end)()

plugged.add_plugin("https://github.com/lutobler/vis-commentary")
plugged.add_plugin("https://git.sr.ht/~mcepl/vis-fzf-open")
plugged.add_plugin("https://github.com/jpnt/vis-shout")
plugged.add_plugin("https://github.com/kupospelov/vis-ctags")
plugged.add_plugin("https://github.com/fischerling/vis-lspc")
plugged.add_plugin("https://github.com/jpnt/vis-bracketedpaste")
-- require("plugins/vis-autopairs") -- fix closing bracket edge case
-- require("plugins/vis-format") -- copy format plugin from neovim

vis.events.subscribe(vis.events.INIT, function()
	vis:command("set theme base16-gruvbox-dark-medium")
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command("set autoindent on")
	vis:command("set number")
	vis:command("set relativenumbers")

	local filetype = win.syntax or ""
	if filetype == "javascript" or filetype == "typescript"
	or filetype == "yaml"  then
		vis:command("set expandtab on")
		vis:command("set tabwidth 2")
	elseif filetype == "python" or filetype == "rust" then
		vis:command("set expandtab on")
		vis:command("set tabwidth 4")
	end
end)

plugged.require_all_plugins()
