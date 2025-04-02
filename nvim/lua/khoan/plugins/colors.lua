return {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require("rose-pine").setup({
            dark_variant = "moon",
            dim_inactive_windows = true,
            styles = { italic = false, transparency = false, },
        })
        vim.cmd.colorscheme("rose-pine")
    end
}
