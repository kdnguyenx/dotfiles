-- lua experimental module loader
vim.loader.enable()
-- load essential modules
require("me.options")
require("me.keymaps")
require("me.autocmds")
require("me.lsp")
-- add plugins using `git submodule add --depth=1 <repo> pack/plugins/start/<name>`
-- and update by `git submodule update --remote --rebase --recursive`
require("me.plugins.colors")
require("me.plugins.treesitter")
require("me.plugins.fzf")
