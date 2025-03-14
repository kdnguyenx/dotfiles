return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      dim_inactive_windows = false,
      styles = { italic = false, transparency = true, },
    })
    vim.cmd.colorscheme "rose-pine"
  end
}
