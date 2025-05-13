return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            modules = {},
            ensure_installed = { "c", "cpp", "rust", "go", "java", "lua", "vim", "vimdoc", "query", "python", "markdown" },
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            highlight = { enable = true, additional_vim_regex_highlighting = false, },
            indent = { enable = true }
        })
    end
}
