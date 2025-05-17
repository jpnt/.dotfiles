-- requires neovim >=0.11
vim.g.mapleader = ' '

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- plugin setup
require("lazy").setup({
  { "rebelot/kanagawa.nvim",       lazy = false },

  {
    "Darazaki/indent-o-matic",
    event = "BufReadPre",
  },

  {
    "mg979/vim-visual-multi",
    keys = "<C-n>",
  },

  {
    "lukas-reineke/lsp-format.nvim",
    event = "LspAttach",
    opts = {},
  },

  {
    "vladdoster/remember.nvim",
    event = "VeryLazy",
    opts = {},
  },

  { 'echasnovski/mini.statusline', version = '*', opts = {} },
  { 'echasnovski/mini-git',        version = '*', main = 'mini.git', opts = {} },
  { 'echasnovski/mini.diff',       version = '*', opts = {} },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = { { "<C-p>", "<cmd>Telescope find_files<cr>" },
      { "<C-o>",      "<cmd>Telescope oldfiles<cr>" },
      { "<leader>rg", "<cmd>Telescope live_grep<cr>" } },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle" },
    keys = { { "<leader>cc", "<cmd>OverseerRun<cr>" },
      { "<leader>cu", "<cmd>OverseerToggle<cr>" } },
    opts = {},
  },

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function() require("dap_config") end,
  },

  {
    "miroshQa/debugmaster.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = { { "<leader>d", mode = { "n", "v" }, desc = "Toggle DEBUG" } },
    config = function()
      local dm = require("debugmaster")
      vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
      vim.api.nvim_set_hl(0, "dCursor", { bg = "#FF2C2C" })
    end
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },
})

-- some options
vim.defer_fn(function()
  vim.cmd("colorscheme kanagawa")
end, 1)
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.completeopt    = "menuone,noselect,popup"
vim.keymap.set("i", "<cr>", "pumvisible() ? '<C-y>' : '<cr>'", { expr = true })

-- lsp setup (native)
vim.lsp.enable({ 'clangd', 'luals', 'pyright', 'gopls', 'rust-analyzer' })
vim.diagnostic.config({ virtual_lines = { current_line = true } })

vim.api.nvim_create_autocmd('LspAttach', {
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" }),
  vim.keymap.set("i", "<C-space>", function() vim.lsp.completion.get() end),

  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
    end

    require("lsp-format").on_attach(client, ev.buf)
  end,
})

-- terminal setup TODO
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.bo.number = false
    vim.bo.relativenumber = false
  end,
})
