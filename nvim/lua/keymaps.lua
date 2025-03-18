-- clear highlights on search when pressing <esc> in normal mode and exit terminal
vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch)
vim.keymap.set("n", "-", vim.cmd.Explore)
-- use ctrl+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
-- use arrow keys for resize
vim.keymap.set("n", "<up>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<down>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<right>", "<cmd>vertical resize +2<cr>")
-- command mode navigation
vim.keymap.set("c", "<C-a>", "<home>")
vim.keymap.set("c", "<C-e>", "<end>")
-- navigate through quickfix list
vim.keymap.set("n", "]q", "<cmd>cnext<cr>zz")
vim.keymap.set("n", "[q", "<cmd>cprev<cr>zz")
-- navigate through loclist
vim.keymap.set("n", "]l", "<cmd>lnext<cr>zz")
vim.keymap.set("n", "[l", "<cmd>lprev<cr>zz")
-- navigate through buffer
vim.keymap.set("n", "]b", "<cmd>bnext<cr>zz")
vim.keymap.set("n", "[b", "<cmd>bprev<cr>zz")
-- search current marked text
vim.keymap.set("v", "//", [[y/\v<C-r>=escape(@",'/\')<cr><cr>]])
-- yank marked text/paste to/from global register
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("v", "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])
-- search and replace
vim.keymap.set("n", "<leader>rr", [[:%s/<C-r><C-w>//g<left><left>]])
vim.keymap.set("v", "<leader>rr", [["5y:%s/<C-r>5//g<left><left>]])
-- unix commands
vim.keymap.set("n", "<leader>cp", ":!cp -r %:.<C-z> %:h<C-z>")
vim.keymap.set("n", "<leader>mv", ":!mv %:.<C-z> %:h<C-z>")
vim.keymap.set("n", "<leader>rm", ":!rm -rf %:.<C-z>")
-- default fuzzy find
vim.keymap.set("n", "<leader>ff", ":find **/*")
vim.keymap.set("n", "<leader>fw", ":find **/*<C-r><C-w>")
vim.keymap.set("n", "<leader>e", ":e %:h<C-z>")
vim.keymap.set("n", "<leader>b", ":b <C-z>")
vim.keymap.set("n", "<leader>ju", vim.cmd.jumps)
vim.keymap.set("n", "<leader>mm", vim.cmd.marks)
-- default grep
if vim.fn.executable("rg") > 0 then
  vim.keymap.set("n", "<leader>gg", [[:silent grep! ''<left>]])
  vim.keymap.set("v", "<leader>gg", [["0y:silent grep! --case-sensitive '<C-r>0'<left>]])
  vim.keymap.set("n", "<leader>gw", [[:silent grep! --case-sensitive '<C-r><C-w>'<cr>]])
  vim.keymap.set("n", "<leader>/", [[:silent grep! --hidden --no-ignore ''<left>]])
end
-- diff mode
vim.keymap.set("n", "<leader>du", "<cmd>diffget //3<cr>")
vim.keymap.set("n", "<leader>dh", "<cmd>diffget //2<cr>")
-- vsplit on gf
vim.keymap.set("n", "gf", "<cmd>vertical wincmd f<cr>", { silent = true })
-- set mark before gd/#/*
vim.keymap.set("n", "gd", "mmgd", { silent = true })
vim.keymap.set("n", "#", "mm#", { silent = true })
vim.keymap.set("n", "*", "mm*", { silent = true })
-- run ctags in the background
vim.keymap.set("n", "<leader>tg", function()
  if vim.fn.executable("ctags") < 1 then
    print("no ctags installation found")
    return
  end
  local job = vim.fn.jobstart({ "ctags", "--tag-relative=never", "-G", "-R", "." })
  print("generate tags..., id: " .. job)
end)
