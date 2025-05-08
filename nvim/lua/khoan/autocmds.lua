-- highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("hlonyank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 50 })
    end,
})
-- quick exit some filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "help", "qf", "diff", "checkhealth", "fugitive", "fugitiveblame" },
    group = vim.api.nvim_create_augroup("quickexitft", { clear = true }),
    callback = function()
        vim.opt_local.colorcolumn = ""
        vim.opt_local.cursorline = true
        vim.keymap.set("n", "q", vim.cmd.quit, { buffer = true });
    end,
})
-- netrw
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    group = vim.api.nvim_create_augroup("nnetrw", { clear = true }),
    callback = function()
        vim.opt_local.colorcolumn = ""
        vim.keymap.set("n", "<C-c>", vim.cmd.Rexplore, { buffer = true });
    end,
})
-- open the quickfix window whenever a quickfix command is executed
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "[^l]*",
    group = vim.api.nvim_create_augroup("qfonexec", { clear = true }),
    callback = function() vim.cmd.cwindow() end,
})
