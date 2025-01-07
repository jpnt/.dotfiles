require("vis")
plugged = require("plugins/vis-plugged")
--require("plugins/vis-autopairs") -- need to fix closing bracket edge case
--require("plugins/vis-bracketpaste") -- copy from vim bracketpaste
--require("plugins/vis-format") -- copy format plugin from neovim

plugged.add_plugin("https://github.com/lutobler/vis-commentary")
plugged.add_plugin("https://git.sr.ht/~mcepl/vis-fzf-open")
plugged.add_plugin("https://github.com/jpnt/vis-shout")
plugged.add_plugin("https://github.com/kupospelov/vis-ctags")
plugged.require_all_plugins()

vis.events.subscribe(vis.events.INIT, function()
	vis:command("set theme base16-gruvbox-dark-medium")
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command("set autoindent on")
	vis:command("set number")
	vis:command("set relativenumbers")

	local filetype = win.syntax or ""

	if filetype == "javascript" or filetype == "typescript" then
		vis:command("set expandtab on")
		vis:command("set tabwidth 2")
	elseif filetype == "python" or filetype == "rust" then
		vis:command("set expandtab on")
		vis:command("set tabwidth 4")
	end
end)
