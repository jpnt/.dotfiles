return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = { { "<leader>tf", "<cmd>Telescope find_files<cr>" },
        { "<leader>to", "<cmd>Telescope oldfiles<cr>" },
        { "<leader>tb", "<cmd>Telescope buffers<cr>" },
        { "<leader>tg", "<cmd>Telescope live_grep<cr>" } },
    dependencies = { "nvim-lua/plenary.nvim" },
}
