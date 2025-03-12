return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local servers = { "clangd", "gopls", "lua_ls", "pyright", "jdtls", "ts_ls" }
      require("mason").setup()
      require("mason-lspconfig").setup({ ensure_installed = servers })
      local lspconfig = require("lspconfig")
      local config = require("lsp").make_cfg()
      for _, server in ipairs(servers) do
        if server ~= "jdtls" then
          lspconfig[server].setup(config)
        end -- use nvim-jdtls for java
      end
    end
  },
  { "mfussenegger/nvim-jdtls" },
}
