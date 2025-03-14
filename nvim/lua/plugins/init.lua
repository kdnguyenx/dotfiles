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
    require("plugins.colors"),
    require("plugins.fuzzy"),
    require("plugins.treesitter"),
    require("plugins.git"),
    require("plugins.lsp"),
    require("plugins.trouble"),
    require("plugins.utils"),
  },
  -- configure any other settings here. see the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "default" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
