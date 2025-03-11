return {
   { 'tpope/vim-surround' },
   {
      'kristijanhusak/vim-dadbod-ui',
      dependencies = { 'tpope/vim-dadbod', lazy = true }
   },
   {
      'williamboman/mason.nvim',
      config = function()
         require('mason').setup()
      end
   },
   { 'mfussenegger/nvim-jdtls' },
   {
      'tpope/vim-eunuch',
      config = function()
         vim.keymap.set('n', '<leader>cp', ':Copy %:.<c-z> %:h<c-z>')
         vim.keymap.set('n', '<leader>mv', ':Move %:.<c-z> %:h<c-z>')
         vim.keymap.set('n', '<leader>rm', ':Delete %:.<c-z>')
      end
   },
   {
      'vimwiki/vimwiki',
      config = function()
         vim.g.vimwiki_list = { { path = '~/vimwiki/', syntax = 'markdown', ext = 'md' } }
         vim.g.vimwiki_global_ext = 0
         vim.g.vimwiki_ext2syntax = {}
      end
   },
}
