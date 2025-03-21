vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
-- lsp config
local config = require("khoan.lsp").make_cfg()
config["name"] = "gopls"
config["cmd"] = { "gopls" }
config["root_dir"] = vim.fs.root(0, { "go.mod", "go.work" }) or vim.fn.getcwd()
config["capabilities"] = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.start(config)
