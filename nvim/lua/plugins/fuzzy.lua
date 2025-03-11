return {
   'nvim-telescope/telescope.nvim',
   tag = '0.1.8',
   dependencies = { 'nvim-lua/plenary.nvim' },
   config = function()
      require('telescope').setup({
         defaults = {
            layout_strategy = 'bottom_pane',
            layout_config = {
               height = 0.41,
               preview_cutoff = 9999
            },
         },
      })
      -- keymaps
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files)
      vim.keymap.set('n', '<leader>ss', builtin.git_files)
      vim.keymap.set('v', '<leader>f', [["0y:lua require('telescope.builtin').find_files({search_file = '<c-r>0'})<cr>]])
      vim.keymap.set('n', '<leader>F', function() builtin.find_files({ search_file = vim.fn.expand('<cword>') }) end)
      vim.keymap.set('n', '<leader>j', builtin.jumplist)
      vim.keymap.set('n', '<leader>m', builtin.marks)
      vim.keymap.set('n', '<leader>g', builtin.live_grep)
      vim.keymap.set('v', '<leader>g', [["0y:lua require('telescope.builtin').grep_string({search = '<c-r>0'})<cr>]])
      vim.keymap.set('n', '<leader>G', function() builtin.grep_string({ search = vim.fn.expand('<cword>') }) end)
      vim.keymap.set('n', '<leader>b', builtin.buffers)
      vim.keymap.set('n', '<leader>o', builtin.resume)
   end
}
