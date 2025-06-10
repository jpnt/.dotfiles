-- init.lua — requires Neovim >= 0.11

vim.g.mapleader = ' '

-- ╭──────────────────────────────────────╮
-- │ Plugin manager bootstrap (lazy.nvim) │
-- ╰──────────────────────────────────────╯
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- ╭────────────────────────────╮
-- │ Options & UI configuration │
-- ╰────────────────────────────╯
vim.defer_fn(function()
  vim.cmd("colorscheme kanagawa")
end, 1)

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.completeopt = "menuone,noselect,popup"

-- ╭─────────────────╮
-- │ General keymaps │
-- ╰─────────────────╯

vim.keymap.set("n", "-", "<cmd>Oil<CR>", {
  desc = "Open Oil file explorer",
})

vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", {
  desc = "Next buffer",
})

vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", {
  desc = "Previous buffer",
})

vim.keymap.set("n", "<leader>\\", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
end, {
  desc = "Open vertical terminal below",
})

-- ╭──────────────────╮
-- │ Native LSP setup │
-- ╰──────────────────╯
vim.lsp.enable({ "clangd", "luals", "pyright", "gopls", "rust-analyzer" })

vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
      buffer = bufnr,
      desc = "Go to Definition",
    })

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
      buffer = bufnr,
      desc = "Code Action",
    })

    require("lsp-format").on_attach(client, bufnr)
  end,
})
