return {
    "miroshQa/debugmaster.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = { { "<leader>d", mode = { "n", "v" }, desc = "Toggle DEBUG" } },
    config = function()
        local dm = require("debugmaster")
        vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
        vim.api.nvim_set_hl(0, "dCursor", { bg = "#FF2C2C" })
    end
}
