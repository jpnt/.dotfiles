local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
  callback = function(ev)
    local bufnr  = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- native LSP completion (omnifunc + <C-Space>), if you opted in
    if vim.g.native_lsp_autocomplete and client
        and client.supports_method("textDocument/completion")
    then
      vim.keymap.set("i", "<C-Space>", function()
        vim.lsp.completion.get()
      end, {
        buffer = bufnr,
        desc = "Trigger Completion",
      })
    end

    -- LSP specific keymaps, only enabled if LSP is enabled
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
      buffer = bufnr,
      desc   = "Go to Definition",
    })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
      buffer = bufnr,
      desc   = "Code Action",
    })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
      buffer = bufnr,
      desc   = "LSP Rename",
    })

    -- format on save
    require("lsp-format").on_attach(client, bufnr)
  end,
})
