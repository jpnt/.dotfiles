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
  },
  -- disable LSP auto formatting
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
}
