return {
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", },
    },
  },
  { "tpope/vim-surround" },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod", lazy = true }
  },
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = { { path = "~/vimwiki/", syntax = "markdown", ext = ".md" } }
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_ext2syntax = vim.empty_dict()
    end
  },
}
