vim9script

# https://github.com/yegappan/lsp
# https://github.com/saccarosium/yegappan-lsp-settings
# https://github.com/neovim/nvim-lspconfig

packadd lsp

autocmd User LspSetup g:LspOptionsSet({ignoreMissingServer: true})

# completion: LSP's own auto-popup is used by default (autoComplete: true).
# to instead feed LSP completions through autocomplete.vim's native
# 'autocomplete'/'complete' pipeline, use this and add the 'o' flag to
# 'complete' in autocomplete.vim:
# autocmd User LspSetup g:LspOptionsSet({autoComplete: false, omniComplete: true})

# one dict per server, see :h lsp-server-add for all supported keys
var servers: list<dict<any>> = [
  {
    name: 'gopls',
    filetype: ['go', 'gomod', 'gowork', 'gotmpl'],
    path: 'gopls',
    args: ['serve'],
  },
  {
    name: 'rust-analyzer',
    filetype: ['rust'],
    path: 'rust-analyzer',
    args: [],
    syncInit: true,
  },
]

autocmd User LspSetup g:LspAddServer(servers)

# buffer-local mappings, only while a server is actually attached
autocmd User LspAttached {
  nnoremap <buffer> <silent> gd <Cmd>LspGotoDefinition<CR>
  nnoremap <buffer> <silent> gr <Cmd>LspShowReferences<CR>
  nnoremap <buffer> <silent> K  <Cmd>LspHover<CR>
  nnoremap <buffer> <silent> [d <Cmd>LspDiag prev<CR>
  nnoremap <buffer> <silent> ]d <Cmd>LspDiag next<CR>
  nnoremap <buffer> <silent> <leader>e <Cmd>LspDiag current<CR>
  nnoremap <buffer> <silent> <leader>rn <Cmd>LspRename<CR>
  nnoremap <buffer> <silent> <leader>ca <Cmd>LspCodeAction<CR>
}

autocmd User LspDetached {
  silent! nunmap <buffer> gd
  silent! nunmap <buffer> gr
  silent! nunmap <buffer> K
  silent! nunmap <buffer> [d
  silent! nunmap <buffer> ]d
  silent! nunmap <buffer> <leader>e
  silent! nunmap <buffer> <leader>rn
  silent! nunmap <buffer> <leader>ca
}
