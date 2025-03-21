return {
    "junegunn/fzf.vim",
    dependencies = {
        "junegunn/fzf",
        build = ":call fzf#install()",
    },
    config = function ()
        vim.g.fzf_layout = { down = "41%" }
        vim.api.nvim_create_autocmd("filetype", {
            pattern = "fzf",
            group = vim.api.nvim_create_augroup("khoanfzf", { clear = true }),
            callback = function()
                vim.opt_local.laststatus = 0
                vim.opt_local.showmode = false
                vim.opt_local.ruler = false

                vim.api.nvim_create_autocmd('bufleave', {
                    buffer = 0,
                    callback = function()
                        vim.opt_local.laststatus = 2
                        vim.opt_local.showmode = true
                        vim.opt_local.ruler = true
                    end,
                })
            end,
        })
        vim.keymap.set("n", "<leader>f", vim.cmd.Files)
        vim.keymap.set("n", "<leader>b", vim.cmd.Buffers)
        vim.keymap.set("n", "<leader>ju", vim.cmd.Jumps)
        vim.keymap.set("n", "<leader>mm", vim.cmd.Marks)
    end
}
