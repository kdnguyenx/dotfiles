return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            window = {
                completion = cmp.config.window.bordered({ border = "single" }),
                documentation = cmp.config.window.bordered({ border = "single" }),
            },
            mapping = cmp.mapping.preset.insert({
                ["<c-u>"] = cmp.mapping.scroll_docs(-5),
                ["<c-d>"] = cmp.mapping.scroll_docs(5),
                ["<esc>"] = cmp.mapping.abort(),
                ["<tab>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({ { name = "nvim_lsp" } }, { { name = "buffer" } })
        })
    end
}
