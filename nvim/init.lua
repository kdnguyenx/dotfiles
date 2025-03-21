-- lua module loader
vim.loader.enable()
vim.g.mapleader = " "
-- load essential modules
require("khoarm.options")
require("khoarm.keymaps")
require("khoarm.autocmds")
require("khoarm.plugs")
