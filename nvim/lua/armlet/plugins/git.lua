return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>dt', '<cmd>Gvdiffsplit!<cr>')
      vim.api.nvim_create_autocmd('filetype', {
        pattern = 'fugitive',
        group = vim.api.nvim_create_augroup('armletfugitive', { clear = true }),
        callback = function()
          vim.cmd.resize(20)
          vim.keymap.set('n', '<leader>p', function()
            vim.cmd.Git('pull --rebase')
          end, { buffer = true });
        end,
      })
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '┃' },
          change = { text = '┃' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '┃' },
          untracked = { text = '┆' },
        },
        signs_staged = {
          add = { text = '┃' },
          change = { text = '┃' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '┃' },
          untracked = { text = '┆' },
        },
      }
    end
  },
}
