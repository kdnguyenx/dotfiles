return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local servers = { "clangd", "jdtls", "lua_ls", "pyright", "ts_ls" }
        require("mason").setup()
        require("mason-lspconfig").setup({ ensure_installed = servers })
        for _, server in ipairs(servers) do
            local config = require("khoan.lsp").make_cfg()
            if server == "jdtls" then
                config["settings"] = require("khoan.lsp").jdtls_settings()
                config["root_dir"] = vim.fn.getcwd()
            end
            vim.lsp.config(server, config)
            vim.lsp.enable(server)
        end
        -- completion
        local cmp = require("cmp")
        cmp.setup({
            window = {
                completion = cmp.config.window.bordered({ border = "single" }),
                documentation = cmp.config.window.bordered({ border = "single" }),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-u>"] = cmp.mapping.scroll_docs(-5),
                ["<C-d>"] = cmp.mapping.scroll_docs(5),
                ["<C-e>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({ { name = "nvim_lsp" } }, { { name = "buffer" } })
        })
    end
}
