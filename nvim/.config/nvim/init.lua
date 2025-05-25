-- requires neovim >=0.11
vim.g.mapleader = ' '

-- lazy.nvim plugin manager bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- plugins setup
require("lazy").setup("plugins")

-- some options
vim.defer_fn(function()
  vim.cmd("colorscheme kanagawa")
end, 1)
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.completeopt    = "menuone,noselect,popup"
vim.keymap.set("i", "<cr>", "pumvisible() ? '<C-y>' : '<cr>'", { expr = true })
vim.keymap.set("n", "-", "<cmd>Oil<cr>")
vim.keymap.set("n", "<tab>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<S-tab>", "<cmd>bprevious<cr>")

-- terminal setup
vim.keymap.set("n", "<leader>\\", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
end)

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
