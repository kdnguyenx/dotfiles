return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = { layout_strategy = "vertical", layout_config = { width = 0.75, height = 0.8 }, },
    })
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files)
    vim.keymap.set("n", "<leader>fg", builtin.git_files)
    vim.keymap.set("n", "<leader>gg", builtin.live_grep)
    vim.keymap.set("n", "<leader>gw", function() builtin.grep_string({ search = vim.fn.expand("<cword>") }) end)
    vim.keymap.set("n", "<leader>bb", builtin.buffers)
    vim.keymap.set("n", "<leader>oo", builtin.resume)
  end
}
