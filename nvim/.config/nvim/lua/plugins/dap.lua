return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    local dap = require("dap")

    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
      name = "lldb"
    }

    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      name = "gdb"
    }

    dap.configurations.cpp = {
      {
        name = "Launch with GDB",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        args = {},
      },
      {
        name = "Launch with LLDB",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        args = {},
      },
    }

    dap.configurations.c = dap.configurations.cpp
  end,
}
