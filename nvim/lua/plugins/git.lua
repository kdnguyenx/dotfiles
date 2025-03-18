return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>dt", "<cmd>Gvdiffsplit!<cr>")
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fugitive",
        group = vim.api.nvim_create_augroup("custom_fugitive", { clear = true }),
        callback = function()
          vim.keymap.set("n", "<leader>p", "<cmd>Git pull --rebase<cr>", { buffer = true });
        end,
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "┃" },
          untracked = { text = "┆" },
        },
        signs_staged = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "┃" },
          untracked = { text = "┆" },
        },
      }
    end
  },
}
