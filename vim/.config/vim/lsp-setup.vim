vim9script
var lspOpts = {
	autoComplete: true,
	autoHighlightDiags: true,
	completionMatcher: 'fuzzy',
	diagSignErrorText: 'E>',
	diagSignWarningText: 'W>',
	diagSignInfoText: 'I>',
	diagSignHintText: 'H>',
	showDiagWithSign: true,
	showDiagInPopup: true,
	hoverInPreview: true,
	semanticHighlight: true,
	useBufferCompletion: true,
	useQuickfixForLocations: true,
}

autocmd User LspSetup call LspOptionsSet(lspOpts)

var lspServers = [
	{
		name: 'clangd',
		filetype: ['c', 'cpp'],
		path: '/bin/clangd',
		args: ['--background-index']
	}
]

autocmd User LspSetup call LspAddServer(lspServers)
