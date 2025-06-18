local map = vim.keymap.set

-- Explorer
map("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil" })

-- Buffers
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })

-- Terminal
map("n", "<leader>\\", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
end, {
  desc = "Open vertical terminal below",
})
