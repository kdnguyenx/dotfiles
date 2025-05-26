-- lua experimental module loader
vim.loader.enable()
-- load essential modules
require("me.options")
require("me.keymaps")
require("me.autocmds")
require("me.lsp")
-- add plugins using `git submodule add --depth=1 <repo> pack/<name>/start/<name>`
-- and update by `git submodule update --remote --rebase`
require("me.plugins.colors")
require("me.plugins.fugitive")
require("me.plugins.treesitter")
require("me.plugins.fzf")
