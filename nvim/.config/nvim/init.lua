-- nvim 0.12 required
local vim = vim
-- Options
vim.loader.enable()
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

-- Diagnostic line
vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

-- Plugin manager
vim.pack.add({
  { src = "https://github.com/echasnovski/mini.icons" },
  { src = "https://github.com/echasnovski/mini.base16" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/echasnovski/mini.comment" },
  { src = "https://github.com/echasnovski/mini.ai" },
  { src = "https://github.com/echasnovski/mini.surround" },
  { src = "https://github.com/echasnovski/mini.tabline" },
  { src = "https://github.com/echasnovski/mini.statusline" },
  { src = "https://github.com/echasnovski/mini.diff" },
  { src = "https://github.com/echasnovski/mini.sessions" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/tpope/vim-projectionist" },
  { src = "https://github.com/tpope/vim-vinegar" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/NMAC427/guess-indent.nvim" },
  { src = "https://github.com/vladdoster/remember.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/dstein64/vim-startuptime" },
  { src = "https://github.com/dstein64/nvim-scrollview" },
  { src = "https://github.com/mg979/vim-visual-multi" },
  { src = "https://github.com/romus204/referencer.nvim" },
  { src = "https://github.com/slint-ui/vim-slint" },
  { src = "https://github.com/dhananjaylatkar/cscope_maps.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },
})

-- Theme
require("mini.base16").setup({
  palette = {
    base00 = "#1d1f21", -- background
    base01 = "#282a2e", -- lighter background (status, sidebar)
    base02 = "#373b41", -- selection background
    base03 = "#969896", -- comments, invisibles
    base04 = "#b4b7b4", -- dark foreground (status)
    base05 = "#c5c8c6", -- default foreground
    base06 = "#e0e0e0", -- light foreground
    base07 = "#ffffff", -- lighter foreground
    base08 = "#cc6666", -- red (variables, errors)
    base09 = "#de935f", -- orange (numbers, constants)
    base0A = "#f0c674", -- yellow (classes, highlights)
    base0B = "#b5bd68", -- green (strings)
    base0C = "#8abeb7", -- cyan (support, special)
    base0D = "#81a2be", -- blue (functions)
    base0E = "#b294bb", -- purple (keywords)
    base0F = "#a3685a", -- brown (deprecated, warnings)
  },
})

-- Plugins that have to load early
require("remember")
require("guess-indent").setup()

-- Plugins that can be scheduled to load later
vim.schedule(function()
  require("mini.icons").setup()
  require("mini.pick").setup()
  require("mini.ai").setup()
  require("mini.surround").setup()
  require("mini.tabline").setup()
  require("mini.statusline").setup()
  require("mini.diff").setup()
  require("mini.sessions").setup()

  require("luasnip.loaders.from_vscode").lazy_load()
  require("referencer").setup({ enable = true })
  require("cscope_maps").setup()
  require("fidget").setup()
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

-- Keymaps that use plugins
vim.keymap.set('n', '<leader>f', '<cmd>Pick files<CR>')
vim.keymap.set('n', '<leader>g', '<cmd>Pick grep_live<CR>')
vim.keymap.set('n', '<leader>h', '<cmd>Pick help<CR>')
vim.keymap.set('n', '<leader>b', '<cmd>Pick buffers<CR>')

vim.keymap.set('n', '<leader>sw', function()
  local folder_name = vim.fn.getcwd():match("([^/]+)$")
  require('mini.sessions').write(folder_name)
end)
vim.keymap.set('n', '<leader>ss', '<cmd>lua MiniSessions.select()<CR>')

vim.keymap.set({ 'i', 's' }, '<C-e>', function()
  local luasnip = require("luasnip")
  if luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  end
end)

-- LSP (Language Server Protocol)
-- https://neovim.io/doc/user/lsp.html
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  once = true,
  callback = function()
    -- vim.lsp.config is handled by nvim-lspconfig plugin
    -- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
    vim.lsp.enable({
      "clangd",
      "lua_ls",
      "vtsls",
      "pyright",
      "gopls",
      "rust_analyzer",
      "zls",
      "jdtls",
      "slint_lsp",
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
    -- LSP keymaps
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr })
  end,
})
