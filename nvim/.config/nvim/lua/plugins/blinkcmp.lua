return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	dependencies = { 'rafamadriz/friendly-snippets' },
	event = "InsertEnter",

	-- use a release tag to download pre-built binaries
	version = '1.*',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- keymap = { preset = 'enter' },

		sources = {
			default = { 'lsp', 'path', 'snippets' },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}
