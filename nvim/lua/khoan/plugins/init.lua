-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    require("khoan.plugins.colors"),
    require("khoan.plugins.fuzzy"),
    require("khoan.plugins.treesitter"),
    require("khoan.plugins.git"),
    require("khoan.plugins.lsp"),
    require("khoan.plugins.utils"),
  },
  -- configure any other settings here. see the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "default" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
