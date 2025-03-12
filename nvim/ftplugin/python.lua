vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
-- lsp config
local config = require("lsp").make_cfg()
config["name"] = "pyright"
config["cmd"] = { "pyright-langserver", "--stdio" }
config["root_dir"] = vim.fn.getcwd()
config["settings"] = {
  python = {
    analysis = {
      autoSearchPaths = true,
      useLibraryCodeForTypes = true,
      diagnosticMode = "openFilesOnly",
    },
  },
}
vim.lsp.start(config)
