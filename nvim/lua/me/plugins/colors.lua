return {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require("rose-pine").setup({
            dark_variant = "moon",
            dim_inactive_windows = false,
            styles = { italic = false, transparency = false, },
        })
        vim.cmd.colorscheme("rose-pine")
        -- remove background only
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE' })
    end
}
