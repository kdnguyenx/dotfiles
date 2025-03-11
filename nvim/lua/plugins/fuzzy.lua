return {
   'nvim-telescope/telescope.nvim',
   tag = '0.1.8',
   dependencies = { 'nvim-lua/plenary.nvim' },
   config = function()
      require('telescope').setup({
         defaults = { layout_strategy = 'vertical', layout_config = { width = 0.75, height = 0.8 }, },
      })
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files)
      vim.keymap.set('n', '<leader>s', builtin.git_files)
      vim.keymap.set('v', '<leader>f', [["0y:lua require('telescope.builtin').find_files({search_file = '<c-r>0'})<cr>]])
      vim.keymap.set('n', '<leader>F', function() builtin.find_files({ search_file = vim.fn.expand('<cword>') }) end)
      vim.keymap.set('n', '<leader>g', builtin.live_grep)
      vim.keymap.set('n', '<leader>G', function() builtin.grep_string({ search = vim.fn.expand('<cword>') }) end)
      vim.keymap.set('n', '<leader>b', builtin.buffers)
      vim.keymap.set('n', '<leader>o', builtin.resume)
   end
}
