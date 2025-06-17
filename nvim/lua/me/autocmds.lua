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
    group = vim.api.nvim_create_augroup("qexitft", { clear = true }),
    callback = function()
        vim.opt_local.colorcolumn = ""
        vim.opt_local.cursorline = true
        vim.keymap.set("n", "q", vim.cmd.quit, { buffer = true });
    end,
})
-- netrw
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    group = vim.api.nvim_create_augroup("netrwcfg", { clear = true }),
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
-- wildmenu completion find
local function complete_fd(pattern)
    local cmd = { "fd", "-H", "-E", ".git", "-td", "-tf" }
    if vim.fn.isdirectory(pattern) > 0 then
        table.insert(cmd, "--full-path")
        table.insert(cmd, pattern)
    else
        table.insert(cmd, "-g")
        table.insert(cmd, pattern)
        table.insert(cmd, "--strip-cwd-prefix=always")
    end
    return vim.fn.systemlist(cmd)
end
-- custom find command
vim.api.nvim_create_user_command('Fd', function(opts)
    local item = opts.args
    if vim.fn.filereadable(item) > 0 or vim.fn.isdirectory(item) > 0 then
        vim.cmd('edit ' .. vim.fn.fnameescape(item))
        return
    end
    local matches = complete_fd(item)
    if #matches > 0 then
        vim.cmd('edit ' .. vim.fn.fnameescape(matches[1]))
    else
        vim.notify("no files found", vim.log.levels.WARN)
    end
end, { nargs = 1, complete = function(arg_lead, cmd_line, cursor_pos)
        return complete_fd(arg_lead)
    end })
-- remap fuzzy find keys
vim.keymap.set("n", "<leader>f", [[:Fd *]])
vim.keymap.set("v", "<leader>f", [["0y:Fd *<C-r>0*]])
vim.keymap.set("n", "<leader>F", [[:Fd *<C-r><C-w>*]])
