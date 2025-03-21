return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>dt", "<cmd>Gvdiffsplit!<cr>")
        vim.api.nvim_create_autocmd("filetype", {
            pattern = "fugitive",
            group = vim.api.nvim_create_augroup("khoarmfugitive", { clear = true }),
            callback = function()
                vim.cmd.resize(20)
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git("pull --rebase")
                end, { buffer = true });
            end,
        })
    end
}
