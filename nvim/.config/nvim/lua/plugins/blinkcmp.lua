return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	dependencies = { 'rafamadriz/friendly-snippets' },
	event = "InsertEnter",
	cond = function() return not vim.g.native_lsp_autocomplete end,

	-- use a release tag to download pre-built binaries
	version = '1.*',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		sources = {
			default = { 'lsp', 'path', 'snippets' },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}
