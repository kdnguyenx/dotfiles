local M = {}

function M.make_cfg()
   return {
      on_attach = function(client, bufnr)
         -- enalbe inlay hint and autocompletion
         vim.lsp.inlay_hint.enable(true)
         vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })

         -- mappings.
         -- see `:help vim.lsp.*` for documentation on any of the below functions

         -- lsp navigation keymaps
         vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end,
            { desc = '[g]o to [i]mplementation', buffer = bufnr })
         vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end,
            { desc = '[g]o to [r]eferences', buffer = bufnr })

         -- lsp actions
         vim.keymap.set('n', 'ga', function() vim.lsp.buf.code_action() end,
            { desc = '[g]et lsp code [a]ction', buffer = bufnr })
         vim.keymap.set('v', 'ga', function() vim.lsp.buf.code_action() end,
            { desc = '[g]et lsp code [a]ction', buffer = bufnr })
         vim.keymap.set('n', 'gR', function() vim.lsp.buf.rename() end,
            { desc = '[g]o [R]ename symbols', buffer = bufnr })

         -- diagnostic keymaps
         vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = false }) end,
            { desc = 'prev [d]iagnostic' })
         vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = false }) end,
            { desc = 'next [d]iagnostic' })
         vim.keymap.set('n', '<leader>dl', function()
            local diagnostics = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } })
            vim.diagnostic.setloclist(vim.diagnostic.toqflist(diagnostics))
         end, { desc = 'add buffer [d]iagnostics to location [l]ist' })

         -- diagnostic signs
         vim.diagnostic.config({ virtual_text = true, underline = true, float = false })
      end,
      detached = true,
   }
end

return M
