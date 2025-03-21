vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
-- lsp config
local config = require("khoan.lsp").make_cfg()
config["name"] = "pyright"
config["cmd"] = { "pyright-langserver", "--stdio" }
config["root_dir"] = vim.fn.getcwd()
config["capabilities"] = require("cmp_nvim_lsp").default_capabilities()
config["settings"] = {
    python = {
        analysis = {
            diagnosticMode = "openFilesOnly",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
        },
    },
}
vim.lsp.start(config)
