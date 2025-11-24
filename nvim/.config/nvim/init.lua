-- nvim >=0.11 required
local vim                 = vim
local opt                 = vim.opt
local g                   = vim.g

-- Options
opt.guicursor             = "n-v-i-c:block-Cursor"
opt.wrap                  = true
opt.linebreak             = true
opt.cursorline            = true
opt.number                = true
opt.relativenumber        = true
opt.ignorecase            = true
opt.smartcase             = true
opt.signcolumn            = "yes"
opt.scrolloff             = 8
opt.sidescrolloff         = 8
opt.completeopt           = "menu,menuone,noselect"

g.mapleader               = " "
g.netrw_keepdir           = 0
g.loaded_python3_provider = 0
g.loaded_node_provider    = 0
g.loaded_perl_provider    = 0
g.loaded_ruby_provider    = 0

-- Diagnostic line
vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

-- Colorscheme
vim.cmd.colorscheme("retrobox")

-- Plugin manager
local plu = require("plu")
plu.add({
  {
    src = "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- https://neovim.io/doc/user/lsp.html
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
  },
  {
    src = "echasnovski/mini.pick",
    keys = { "<leader>f", "<leader>g", "<leader>b" },
    config = function()
      local pick = require("mini.pick")
      vim.keymap.set('n', '<leader>f', pick.builtin.files)
      vim.keymap.set('n', '<leader>g', pick.builtin.grep_live)
      vim.keymap.set('n', '<leader>b', pick.builtin.buffers)
    end,
  },
  { src = "echasnovski/mini.statusline" },
  { src = "echasnovski/mini.tabline" },
  { src = "echasnovski/mini.icons" },
  { src = "echasnovski/mini.ai" },
  { src = "echasnovski/mini.surround" },
  { src = "echasnovski/mini.diff" },
  { src = "tpope/vim-fugitive",         lazy = false },
  { src = "tpope/vim-projectionist",    lazy = false },
  { src = "tpope/vim-vinegar",          lazy = false },
  { src = "tpope/vim-dispatch",         lazy = false },
  { src = "vladdoster/remember.nvim",   lazy = false },
  { src = "dstein64/vim-startuptime",   lazy = false },
  { src = "dstein64/nvim-scrollview",   lazy = false },
  { src = "mg979/vim-visual-multi",     lazy = false },
  { src = "slint-ui/vim-slint",         lazy = false },
  {
    src = "romus204/referencer.nvim",
    config = function()
      require("referencer").setup({ enable = true })
    end
  },
  {
    src = "saghen/blink.cmp",
    version = "v1.7.0",
    event = "InsertEnter",
    config = function()
      require("blink.cmp").setup({
        completion = { documentation = { auto_show = true } }
      })
    end
  },
  {
    src = "stevearc/conform.nvim",
    version = "v9.1.0",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          c = { "clang-format" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end
  },
  {
    src = "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
      require("fidget").setup()
    end
  },
})
plu.setup()

-- Plugins that have to load early
require("remember")

-- Only display numbers on active windows
vim.api.nvim_create_autocmd({ "WinEnter" }, {
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = true
  end,
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})

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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    -- Native inlay hints
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- LSP keymaps
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
  end,
})
