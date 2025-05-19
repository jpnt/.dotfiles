return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = { { "<C-p>", "<cmd>Telescope find_files<cr>" },
        { "<C-o>",      "<cmd>Telescope oldfiles<cr>" },
        { "<leader>rg", "<cmd>Telescope live_grep<cr>" } },
    dependencies = { "nvim-lua/plenary.nvim" },
}
