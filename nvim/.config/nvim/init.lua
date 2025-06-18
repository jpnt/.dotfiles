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

vim.lsp.enable({
  "clangd",
  "luals",
  "tsls",
  "pyright",
  "gopls",
  "rust-analyzer",
})

vim.diagnostic.config({
  virtual_lines = { current_line = true },
})
