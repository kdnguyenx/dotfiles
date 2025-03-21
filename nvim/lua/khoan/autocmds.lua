-- highlight when yanking text
vim.api.nvim_create_autocmd("textyankpost", {
    group = vim.api.nvim_create_augroup("hlonyank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ higroup = "incsearch", timeout = 50 })
    end,
})
-- quick exit some filetypes
vim.api.nvim_create_autocmd("filetype", {
    pattern = { "help", "qf", "diff", "fugitive", "fugitiveblame", "dbout" },
    group = vim.api.nvim_create_augroup("quickexitft", { clear = true }),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.colorcolumn = ""
        vim.keymap.set("n", "q", vim.cmd.quit, { buffer = true });
    end,
})
-- netrw
vim.api.nvim_create_autocmd("filetype", {
    pattern = "netrw",
    group = vim.api.nvim_create_augroup("khoannetrw", { clear = true }),
    callback = function()
        vim.opt_local.colorcolumn = ""
        vim.keymap.set("n", "<c-c>", vim.cmd.Rexplore, { buffer = true });
    end,
})
-- open the quickfix window whenever a quickfix command is executed
vim.api.nvim_create_autocmd("quickfixcmdpost", {
    pattern = "[^l]*",
    group = vim.api.nvim_create_augroup("qfoncmdexec", { clear = true }),
    callback = function() vim.cmd.cwindow() end,
})
-- create session directory if it does not exist
local function get_session_dir()
    local dir = vim.fn.stdpath("data") .. "/sessions"
    if not vim.fn.isdirectory(dir) then
        vim.fn.mkdir(dir, "p")
    end
    return dir
end
-- make session automatically when save a buffer or exit vim
vim.api.nvim_create_autocmd({ "bufwritepost", "vimleavepre" }, {
    pattern = "*",
    group = vim.api.nvim_create_augroup("khoansessionizer", { clear = true }),
    callback = function()
        if #vim.v.argv > 3 then
            return
        end
        if vim.fn.argv(0) == "." or vim.fn.argv(0) == vim.fn.getcwd() then
            local dir = get_session_dir()
            local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            vim.cmd.mksession({
                args = { dir .. "/" .. name .. ".vim" },
                bang = true,
                mods = { silent = true }
            })
        end
    end,
})
-- load session automatically when start vim
vim.api.nvim_create_autocmd("vimenter", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("khoanautosession", { clear = true }),
    callback = function()
        if #vim.v.argv > 3 then
            return
        end
        if vim.fn.argv(0) == "." or vim.fn.argv(0) == vim.fn.getcwd() then
            local dir = get_session_dir()
            local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            local file = dir .. "/" .. name .. ".vim"
            if vim.fn.filereadable(file) == 1 then
                local choice = vim.fn.confirm("", "load your stuff? &yeah\n&nah\n&clear", 2)
                if choice == 1 then
                    vim.cmd.source({
                        args = { file },
                        mods = { silent = true }
                    })
                elseif choice == 3 then
                    vim.fn.delete(file)
                end
            end
        end
    end,
})
