-- nvim 0.12 required
local vim             = vim
-- Options
vim.o.number          = true
vim.o.relativenumber  = true
vim.o.ignorecase      = true
vim.o.smartcase       = true
vim.o.signcolumn      = "yes"
vim.o.wrap            = false
vim.o.scrolloff       = 8
vim.o.sidescrolloff   = 8
vim.o.completeopt     = "menu,menuone,noselect"
vim.g.mapleader       = ' '
vim.g.netrw_liststyle = 3 -- tree view by default

-- Plugin manager
vim.pack.add({
  { src = "https://github.com/echasnovski/mini.icons" },
  { src = "https://github.com/echasnovski/mini.base16" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/echasnovski/mini.comment" },
  { src = "https://github.com/echasnovski/mini.surround" },
  { src = "https://github.com/echasnovski/mini.tabline" },
  { src = "https://github.com/echasnovski/mini.notify" },
  { src = "https://github.com/echasnovski/mini.statusline" },
  { src = "https://github.com/echasnovski/mini.diff" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/NMAC427/guess-indent.nvim" },
  { src = "https://github.com/vladdoster/remember.nvim" },
})

-- Plugin config/enable
require("mini.icons").setup()
require("mini.pick").setup()
require("mini.surround").setup()
require("mini.tabline").setup()
require("mini.statusline").setup()
require("mini.diff").setup()
require("guess-indent").setup()
require("remember")

require("mini.notify").setup()
vim.notify = require("mini.notify").make_notify()

require("nvim-treesitter.configs").setup({
  auto_install = true, highlight = { enable = true },
})

require("mini.base16").setup({
  palette = {
    base00 = "#000000",
    base01 = "#161b22",
    base02 = "#21262d",
    base03 = "#484f58",
    base04 = "#6e7681",
    base05 = "#c9d1d9",
    base06 = "#ecf2f8",
    base07 = "#ffffff",
    base08 = "#ff7b72",
    base09 = "#d29922",
    base0A = "#e3b341",
    base0B = "#7ee787",
    base0C = "#79c0ff",
    base0D = "#a5d6ff",
    base0E = "#d2a8ff",
    base0F = "#ffa198",
  },
})

-- Keymaps
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>g', ':Pick grep_live<CR>')
vim.keymap.set("n", "-", "<cmd>Ex<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>")
vim.keymap.set("n", "<leader>\\", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
end)

-- LSP
vim.lsp.enable({
  "clangd",
  "lua_ls",
  "ts_ls",
  "pyright",
  "gopls",
  "rust_analyzer",
  "zls",
})

vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

-- Autocmd
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr  = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- native LSP completion (omnifunc + <C-Space>)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

      vim.keymap.set("i", "<C-Space>", function()
        vim.lsp.completion.get()
      end, { buffer = bufnr })
    end

    -- LSP specific keymaps
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr })
  end,
})
