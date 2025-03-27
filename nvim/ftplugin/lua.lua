vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
-- lsp config
local config = require("khoan.lsp").make_cfg()
config["name"] = "luals"
config["cmd"] = { "lua-language-server" }
config["root_dir"] = vim.fs.root(0, { ".luarc.json", ".luacheckrc", ".stylua.toml" }) or vim.fn.getcwd()
config["settings"] = {
    Lua = {
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = { enable = false },
    },
}
vim.lsp.start(config)
