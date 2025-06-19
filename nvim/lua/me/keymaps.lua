-- remap leader
vim.g.mapleader = " "
-- clear highlights on search when pressing <esc> in normal mode and exit terminal
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")
vim.keymap.set("n", "-", "<Cmd>Explore<CR>")
-- use arrow keys for resize
vim.keymap.set("n", "<Up>", "<Cmd>resize +5<CR>")
vim.keymap.set("n", "<Down>", "<Cmd>resize -5<CR>")
vim.keymap.set("n", "<Left>", "<Cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<Right>", "<Cmd>vertical resize +5<CR>")
-- command mode navigation
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-e>", "<End>")
vim.keymap.set("c", "<M-Left>", "<S-Left>")
vim.keymap.set("c", "<M-Right>", "<S-Right>")
vim.keymap.set("c", "<M-BS>", "<C-w>")
-- wildmenu weird behaviours
vim.keymap.set("c", "<Up>", function()
    return vim.fn.pumvisible() == 1 and "<Left>" or "<Up>"
end, { expr = true })
vim.keymap.set("c", "<Down>", function()
    return vim.fn.pumvisible() == 1 and "<Right>" or "<Down>"
end, { expr = true })
vim.keymap.set("c", "<Left>", function()
    return vim.fn.pumvisible() == 1 and "<Up>" or "<Left>"
end, { expr = true })
vim.keymap.set("c", "<Right>", function()
    return vim.fn.pumvisible() == 1 and "<Down>" or "<Right>"
end, { expr = true })
-- navigate through quickfix list
vim.keymap.set("n", "<C-j>", ":cnext<CR>zz")
vim.keymap.set("n", "<C-k>", ":cprev<CR>zz")
-- navigate through buffer
vim.keymap.set("n", "<C-l>", ":bnext<CR>")
vim.keymap.set("n", "<C-h>", ":bprev<CR>")
-- search current marked text
vim.keymap.set("v", "//", [["0y/\V<C-r>=escape(@0,'/\')<CR><CR>]])
-- yank marked text/paste to/from global register
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])
vim.keymap.set("v", "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>cf", [[:let @+=expand('%')<CR>]])
-- search and replace
vim.keymap.set("n", "<leader>rr", [[:%s/<C-r><C-w>//gI<Left><Left><Left>]])
vim.keymap.set("v", "<leader>rr", [["0y:%s/<C-r>=escape(@0,'/\')<CR>//gI<Left><Left><Left>]])
-- unix commands
vim.keymap.set("n", "<leader>cp", [[:!cp -r %<C-z> %:h<C-z>]])
vim.keymap.set("n", "<leader>mv", [[:!mv %<C-z> %:h<C-z>]])
vim.keymap.set("n", "<leader>rm", [[:!rm -rf %<C-z>]])
-- find files
vim.keymap.set("n", "<leader>e", [[:e %:h<C-z><C-z>]])
vim.keymap.set("n", "<leader>b", [[:b <C-z>]])
vim.keymap.set("n", "<leader>ma", [[:marks<CR>]])
-- ripgrep
if vim.fn.executable("rg") > 0 then
    vim.keymap.set("n", "<leader>g", [[:silent grep! ''<Left>]])
    vim.keymap.set("v", "<leader>g", [["0y:silent grep! --case-sensitive '<C-r>0'<Left>]])
    vim.keymap.set("n", "<leader>G", [[:silent grep! --case-sensitive '<C-r><C-w>'<CR>]])
    vim.keymap.set("n", "<leader>/", [[:silent grep! --hidden --no-ignore ''<Left>]])
end
-- run ctags in the background
vim.keymap.set("n", "<leader>tg", function()
    if vim.fn.executable("ctags") < 1 then
        print("no ctags installation found")
        return
    end
    local job = vim.fn.jobstart({ "ctags", "--tag-relative=never", "-G", "-R", "." })
    print("generate tags..., id: " .. job)
end)
-- set global mark before gd/#/*
vim.keymap.set("n", "gd", "mMgd")
vim.keymap.set("n", "#", "mM#")
vim.keymap.set("n", "*", "mM*")
-- diff mode
vim.keymap.set("n", "<leader>du", function() vim.cmd.diffget("//3") end)
vim.keymap.set("n", "<leader>dh", function() vim.cmd.diffget("//2") end)
