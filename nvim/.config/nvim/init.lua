-- global variables
vim.g.mapleader = ' '
vim.g.native_lsp_autocomplete = false

-- bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
vim.lsp.enable({
  "clangd",
  "lua_ls",
  "ts_ls",
  "pyright",
  "gopls",
  "rust_analyzer",
})

vim.diagnostic.config({
  virtual_lines = { current_line = true },
})
