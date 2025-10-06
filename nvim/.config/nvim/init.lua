-- nvim 0.12 required
local vim = vim
vim.loader.enable()
-- Options
vim.o.cursorline              = true
vim.o.number                  = true
vim.o.termguicolors           = true
vim.o.relativenumber          = true
vim.o.ignorecase              = true
vim.o.smartcase               = true
vim.o.signcolumn              = "yes"
vim.o.wrap                    = false
vim.o.scrolloff               = 8
vim.o.sidescrolloff           = 8
vim.o.completeopt             = "menu,menuone,noselect"
vim.g.mapleader               = ' '
vim.g.netrw_keepdir           = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_ruby_provider    = 0

-- Plugin manager
vim.pack.add({
  { src = "https://github.com/echasnovski/mini.icons" },
  { src = "https://github.com/echasnovski/mini.base16" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/echasnovski/mini.comment" },
  { src = "https://github.com/echasnovski/mini.ai" },
  { src = "https://github.com/echasnovski/mini.surround" },
  { src = "https://github.com/echasnovski/mini.tabline" },
  { src = "https://github.com/echasnovski/mini.notify" },
  { src = "https://github.com/echasnovski/mini.statusline" },
  { src = "https://github.com/echasnovski/mini.diff" },
  { src = "https://github.com/echasnovski/mini.sessions" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/tpope/vim-dispatch" },
  { src = "https://github.com/tpope/vim-projectionist" },
  { src = "https://github.com/tpope/vim-vinegar" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/NMAC427/guess-indent.nvim" },
  { src = "https://github.com/vladdoster/remember.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/dstein64/vim-startuptime" },
  { src = "https://github.com/mg979/vim-visual-multi" },
  { src = "https://codeberg.org/mfussenegger/nvim-jdtls" },
  { src = "https://codeberg.org/mfussenegger/nvim-dap.git" },
})

require("remember")

-- Theme
require("mini.base16").setup({
  palette = {
    base00 = "#2E3440",
    base01 = "#3B4252",
    base02 = "#434C5E",
    base03 = "#4C566A",
    base04 = "#D8DEE9",
    base05 = "#E5E9F0",
    base06 = "#ECEFF4",
    base07 = "#ECEFF4",
    base08 = "#BF616A",
    base09 = "#D08770",
    base0A = "#EBCB8B",
    base0B = "#A3BE8C",
    base0C = "#88C0D0",
    base0D = "#81A1C1",
    base0E = "#B48EAD",
    base0F = "#D08770",
  },
})

-- Plugin config/enable
vim.schedule(function() -- Do not lock
  require("mini.icons").setup()
  require("mini.pick").setup()
  require("mini.ai").setup()
  require("mini.surround").setup()
  require("mini.tabline").setup()
  require("mini.statusline").setup()
  require("mini.diff").setup()
  require("mini.sessions").setup()
  vim.notify = require("mini.notify").make_notify()

  require("luasnip.loaders.from_vscode").lazy_load()
  require("guess-indent").setup()
end)

-- Keymaps
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>")
vim.keymap.set("n", "-", "<cmd>Lex 25<CR>")
vim.keymap.set("n", "<leader>\\", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
end)

vim.keymap.set('n', '<leader>f', '<cmd>Pick files<CR>')
vim.keymap.set('n', '<leader>g', '<cmd>Pick grep_live<CR>')
vim.keymap.set('n', '<leader>h', '<cmd>Pick help<CR>')
vim.keymap.set("n", "<leader>cc", '<cmd>Dispatch ')
vim.keymap.set('n', '<leader>ss', '<cmd>lua MiniSessions.select()<cr>')
vim.keymap.set('n', '<leader>sw', function()
  local folder_name = vim.fn.getcwd():match("([^/]+)$")
  require('mini.sessions').write(folder_name)
end)
vim.keymap.set({ 'i', 's' }, '<C-e>', function()
  local luasnip = require("luasnip")
  if luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  end
end)

vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

-- LSP (Language Server Protocol)
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  once = true,
  callback = function()
    -- vim.lsp.config is handled by nvim-lspconfig plugin
    vim.lsp.enable({
      "clangd", "lua_ls", "ts_ls", "pyright",
      "gopls", "rust_analyzer", "zls", "typst_lsp", "jdtls"
    })
  end
})

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
    vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, { buffer = bufnr })
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr })
  end,
})
