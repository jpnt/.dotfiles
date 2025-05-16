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
  "lewis6991/gitsigns.nvim",

  "mg979/vim-visual-multi",

  "rebelot/kanagawa.nvim",

  "Darazaki/indent-o-matic",

  { "lukas-reineke/lsp-format.nvim", opts = {} },

  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, { noremap = true })
      vim.keymap.set("n", "<C-o>", builtin.oldfiles, { noremap = true })
      vim.keymap.set("n", "<leader>rg", builtin.live_grep, { noremap = true })
    end
  },

  {
    "stevearc/overseer.nvim",
    opts = {},
    config = function()
      vim.keymap.set("n", "<leader>rr", "<cmd>OverseerRun<cr>")
      vim.keymap.set("n", "<leader>rt", function() require("overseer").toggle() end)
    end
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dap_config")
    end
  },

  {
    "miroshQa/debugmaster.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dm = require("debugmaster")
      vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
      vim.keymap.set("t", "<C-/>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
      vim.api.nvim_set_hl(0, "dCursor", { bg = "#FF2C2C" })
      dm.plugins.cursor_hl.enabled = true
      dm.plugins.ui_auto_toggle.enabled = true
    end

  },
})

-- basic options
vim.cmd "colorscheme kanagawa"
vim.opt.number = true
vim.opt.relativenumber = true

-- lsp setup
vim.lsp.enable({ 'clangd', 'luals' })

vim.diagnostic.config({ virtual_lines = { current_line = true } })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
    end

    require("lsp-format").on_attach(client, ev.buf)
  end,
})
