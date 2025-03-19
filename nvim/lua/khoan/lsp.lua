local M = {}
function M.make_cfg()
  return {
    on_attach = function(client, bufnr)
      -- enable inlay hint
      vim.lsp.inlay_hint.enable(true)
      -- vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })
      -- mappings.
      -- see `:help vim.lsp.*` for documentation on any of the below functions
      -- lsp navigation keymaps
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "single" }) end, { buffer = bufnr })
      vim.keymap.set("i", "<c-s>", function()
        vim.lsp.buf.signature_help({ border = "single", title = "help" })
      end, { buffer = bufnr })
      -- lsp actions
      vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = bufnr })
      vim.keymap.set("v", "ga", vim.lsp.buf.code_action, { buffer = bufnr })
      vim.keymap.set("n", "gR", vim.lsp.buf.rename, { buffer = bufnr })
      -- diagnostics keymaps
      vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = false }) end)
      vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = false }) end)
      -- diagnostics list
      vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist)
      vim.keymap.set("n", "<leader>dq", function()
        vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
      end)
      -- diagnostic signs
      vim.diagnostic.config({ virtual_text = true, underline = true, float = { border = "single", } })
    end,
    detached = true,
  }
end

return M
