return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({
            defaults = {
                layout_strategy = "bottom_pane",
                layout_config = { height = 0.41, preview_width = 0.41 },
                path_display = { "truncate" }
            },
        })
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>f", builtin.find_files)
        vim.keymap.set("n", "<leader>F", function() builtin.find_files({ search_file = vim.fn.expand("<cword>") }) end)
        vim.keymap.set("n", "<leader>l", builtin.live_grep)
        vim.keymap.set("n", "<leader>ma", builtin.marks)
        vim.keymap.set("n", "<leader>o", builtin.resume)
    end
}
