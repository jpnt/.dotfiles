vim9script
var lspOpts = {
	autoComplete: true,
	autoHighlightDiags: true,
	completionMatcher: 'fuzzy',
	diagSignErrorText: 'E>',
	diagSignWarningText: 'W>',
	diagSignInfoText: 'I>',
	diagSignHintText: 'H>',
	# showDiagOnStatusLine: true,
	semanticHighlight: true,
}
autocmd User LspSetup call LspOptionsSet(lspOpts)

var lspServers = [
	{
		name: 'clangd',
		filetype: ['c', 'cpp', 'h', 'hpp'],
		path: '/bin/clangd',
		args: ['--background-index']
	},
	{
		name: 'gopls',
		filetype: ['go'],
		path: '/bin/gopls',
		args: ['serve']
	}
]
autocmd User LspSetup call LspAddServer(lspServers)

nnoremap <Leader>ca :LspCodeAction<CR>
nnoremap <Leader>D :LspGotoTypeDef<CR>
nnoremap gd :LspGotoDefinition<CR>
nnoremap gi :LspGotoImpl<CR>
