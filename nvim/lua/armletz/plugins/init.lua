-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- setup lazy.nvim
require('lazy').setup({
  -- import your plugins
  spec = {
    require('armletz.plugins.colors'),
    require('armletz.plugins.fuzzy'),
    require('armletz.plugins.treesitter'),
    require('armletz.plugins.git'),
    require('armletz.plugins.lsp'),
    require('armletz.plugins.utils'),
  },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
