-- lua module loader
vim.loader.enable()
-- load essential modules
require("me.options")
require("me.keymaps")
require("me.autocmds")
require("me.plugs")
-- config language servers
require("me.lsp")
