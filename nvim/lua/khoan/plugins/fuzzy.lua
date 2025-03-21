return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release" },
    },
    config = function()
        require("telescope").setup({
            defaults = { layout_strategy = "bottom_pane", layout_config = { height = 0.41, preview_width = 0.41 }, path_display = { "truncate" } },
            extensions = { fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case", } }
        })
        require("telescope").load_extension("fzf")
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files)
        vim.keymap.set("n", "<leader>fw", function() builtin.find_files({ search_file = vim.fn.expand("<cword>") }) end)
        vim.keymap.set("n", "<leader>fg", builtin.git_files)
        vim.keymap.set("n", "<leader>gg", builtin.live_grep)
        vim.keymap.set("n", "<leader>gw", function() builtin.grep_string({ search = vim.fn.expand("<cword>") }) end)
        vim.keymap.set("n", "<leader>b", builtin.buffers)
        vim.keymap.set("n", "<leader>ju", builtin.jumplist)
        vim.keymap.set("n", "<leader>mm", builtin.marks)
        vim.keymap.set("n", "<leader>o", builtin.resume)
    end
}
