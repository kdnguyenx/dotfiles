-- enables the experimental lua module loader
vim.loader.enable()
-- enable mouse mode
vim.opt.mouse = "a"
vim.opt.regexpengine = 2
-- don't show the mode, since it's already in the status line
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.wrap = false
-- make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.title = true
-- case-insensitive searching unless \c or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-- sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = "⇀ ", trail = "·", eol = "¬", nbsp = "␣" }
vim.opt.showbreak = "↪"
vim.opt.list = true
-- set default indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
-- do not save temporary files.
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.undofile = true
-- preview substitutions live, as you type
vim.opt.inccommand = "split"
vim.opt.startofline = false
vim.opt.sidescrolloff = 10
vim.opt.diffopt:append("vertical")
-- enable auto completion menu after pressing tab
vim.opt.wildmenu = true
vim.opt.wildmode = { "full" }
vim.opt.wildcharm = string.byte(vim.api.nvim_replace_termcodes("<c-z>", true, true, true))
-- ignore these
vim.opt.wildignore = {
  "*.o", "*~", "*.a", "*.so", "*.pyc", "*.swp", "*.class",
  "*/target/*", "*/build/*", "*/generated-sources/*",
  "*/__pycache__/*", "*/node_modules/*",
  "*/.git/*", "*/.hg/*", "*/.svn/*", "*/.idea/*", "*/.vscode/*"
}
if vim.fn.has("mac") > 0 then
  vim.opt.wildignore:append("*/Library/*")
  vim.opt.wildignore:append("*/.DS_Store")
end
-- basic theming
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.laststatus = 2
-- program to use for the :grep command
if vim.fn.executable("rg") > 0 then
  vim.opt.grepprg = "rg --vimgrep --smart-case --no-heading --column"
  vim.opt.grepformat:prepend("%f:%l:%c:%m")
end
-- make sure to setup `mapleader` and `maplocalleader` before
vim.g.mapleader = " "
-- load essential modules
require("keymaps")
require("autocmds")
require("plugins")
-- highlight marked files in the same way search matches are
vim.api.nvim_set_hl(0, "netrwmarkfile", { link = "search" })
