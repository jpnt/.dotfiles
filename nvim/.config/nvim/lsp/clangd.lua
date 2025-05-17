return {
    cmd = { 'clangd', '--background-index' },
    root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt' },
    filetypes = { 'c', 'cpp' },
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    }
}
