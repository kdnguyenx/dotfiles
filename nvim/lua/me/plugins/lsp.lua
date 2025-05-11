return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
    config = function()
        local servers = { "zls", "gopls", "clangd", "jdtls", "lua_ls", "pyright", "ts_ls" }
        require("mason").setup()
        require("mason-lspconfig").setup({ ensure_installed = servers })
        for _, server in ipairs(servers) do
            local config = require("me.lsp").make_cfg()
            if server == "jdtls" then
                config["root_dir"] = vim.fn.getcwd()
                config["cmd"] = require("me.lsp").jdtls_cmd()
                config["settings"] = require("me.lsp").jdtls_settings()
            end
            vim.lsp.config(server, config)
            vim.lsp.enable(server)
        end
    end
}
