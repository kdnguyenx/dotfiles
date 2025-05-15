return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>dt", "<Cmd>Gvdiffsplit!<CR>")
    end
}
