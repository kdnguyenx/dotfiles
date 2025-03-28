-- remap leader
vim.g.mapleader = " "
-- clear highlights on search when pressing <esc> in normal mode and exit terminal
vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch)
vim.keymap.set("n", "-", vim.cmd.Explore)
-- move selection
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
-- use arrow keys for resize
vim.keymap.set("n", "<up>", "<cmd>resize +5<cr>")
vim.keymap.set("n", "<down>", "<cmd>resize -5<cr>")
vim.keymap.set("n", "<left>", "<cmd>vertical resize -5<cr>")
vim.keymap.set("n", "<right>", "<cmd>vertical resize +5<cr>")
-- command mode navigation
vim.keymap.set("c", "<c-a>", "<home>")
vim.keymap.set("c", "<c-e>", "<end>")
-- navigate through quickfix list
vim.keymap.set("n", "<c-j>", ":cnext<cr>zz")
vim.keymap.set("n", "<c-k>", ":cprev<cr>zz")
-- navigate through buffer
vim.keymap.set("n", "<c-l>", vim.cmd.bnext)
vim.keymap.set("n", "<c-h>", vim.cmd.bprevious)
-- search current marked text
vim.keymap.set("v", "//", [[y/\v<c-r>=escape(@",'/\')<cr><cr>]])
-- yank marked text/paste to/from global register
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])
vim.keymap.set("v", "<leader>p", [["+p]])
-- search and replace
vim.keymap.set("n", "<leader>r", [[:%s/<c-r><c-w>//gI<left><left><left>]])
vim.keymap.set("v", "<leader>r", [["0y:%s/<c-r>0//gI<left><left><left>]])
-- unix commands
vim.keymap.set("n", "<leader>cp", [[:!cp -r %<c-z> %:h<c-z>]])
vim.keymap.set("n", "<leader>mv", [[:!mv %<c-z> %:h<c-z>]])
-- default fuzzy find
vim.keymap.set("n", "<leader>f", [[:find **/*]])
vim.keymap.set("n", "<leader>F", [[:find **/*<c-r><c-w><cr>]])
vim.keymap.set("n", "<leader>e", [[:e %:h<c-z>]])
vim.keymap.set("n", "<leader>b", [[:b <c-z>]])
vim.keymap.set("n", "<leader>ma", vim.cmd.marks)
-- ripgrep
if vim.fn.executable("rg") > 0 then
    vim.keymap.set("n", "<leader>g", [[:silent grep! ''<left>]])
    vim.keymap.set("v", "<leader>g", [["0y:silent grep! --case-sensitive '<c-r>0'<left>]])
    vim.keymap.set("n", "<leader>G", [[:silent grep! --case-sensitive '<c-r><c-w>'<cr>]])
    vim.keymap.set("n", "<leader>/", [[:silent grep! --hidden --no-ignore ''<left>]])
end
-- diff mode
vim.keymap.set("n", "<leader>du", function() vim.cmd.diffget("//3") end)
vim.keymap.set("n", "<leader>dh", function() vim.cmd.diffget("//2") end)
-- set global mark before gd/#/*
vim.keymap.set("n", "gd", "mMgd")
vim.keymap.set("n", "#", "mM#")
vim.keymap.set("n", "*", "mM*")
-- run ctags in the background
vim.keymap.set("n", "<leader>tg", function()
    if vim.fn.executable("ctags") < 1 then
        print("no ctags installation found")
        return
    end
    local job = vim.fn.jobstart({ "ctags", "--tag-relative=never", "-G", "-R", "." })
    print("generate tags..., id: " .. job)
end)
