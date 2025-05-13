-- lua module loader
vim.loader.enable()
-- load essential modules
require("me.options")
require("me.keymaps")
require("me.autocmds")
require("me.plugs")
-- config lsp
require("me.lsp").lsp_config()
