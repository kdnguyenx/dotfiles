-- lua module loader
vim.loader.enable()
vim.g.mapleader = " "
-- load essential modules
require("khoan.options")
require("khoan.keymaps")
require("khoan.autocmds")
require("khoan.plugs")
