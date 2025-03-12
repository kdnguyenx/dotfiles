return {
  { "mfussenegger/nvim-jdtls" },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod", lazy = true }
  },
  {
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end
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
