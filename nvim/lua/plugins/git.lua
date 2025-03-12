return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.api.nvim_create_autocmd("filetype", {
        pattern = "fugitive",
        group = vim.api.nvim_create_augroup("custom_fugitive", { clear = true }),
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.colorcolumn = ""
        end
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          add          = { text = "┃" },
          change       = { text = "┃" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "┃" },
          untracked    = { text = "┆" },
        },
        signs_staged = {
          add          = { text = "┃" },
          change       = { text = "┃" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "┃" },
          untracked    = { text = "┆" },
        },
      }
    end
  },
}
