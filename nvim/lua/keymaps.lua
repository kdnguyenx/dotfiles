-- clear highlights on search when pressing <esc> in normal mode and exit terminal
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')
-- use ctrl+<hjkl> to switch between windows
vim.keymap.set('n', '<c-h>', '<c-w><c-h>')
vim.keymap.set('n', '<c-l>', '<c-w><c-l>')
vim.keymap.set('n', '<c-j>', '<c-w><c-j>')
vim.keymap.set('n', '<c-k>', '<c-w><c-k>')
-- use arrow keys for resize
vim.keymap.set('n', '<up>', '<cmd>resize +2<cr>')
vim.keymap.set('n', '<down>', '<cmd>resize -2<cr>')
vim.keymap.set('n', '<left>', '<cmd>vertical resize -2<cr>')
vim.keymap.set('n', '<right>', '<cmd>vertical resize +2<cr>')
-- command mode navigation
vim.keymap.set('c', '<c-a>', '<home>')
vim.keymap.set('c', '<c-e>', '<end>')
vim.keymap.set('c', '<c-b>', '<up>')
vim.keymap.set('c', '<c-f>', '<down>')
-- navigate through quickfix list
vim.keymap.set('n', ']q', '<cmd>cnext<cr>zz')
vim.keymap.set('n', ']q', '<cmd>cprev<cr>zz')
-- navigate through loclist
vim.keymap.set('n', ']l', '<cmd>lnext<cr>zz')
vim.keymap.set('n', ']l', '<cmd>lprev<cr>zz')
-- navigate through buffer
vim.keymap.set('n', ']b', '<cmd>bnext<cr>zz')
vim.keymap.set('n', ']b', '<cmd>bprev<cr>zz')
-- search current marked text
vim.keymap.set('v', '//', [[y/\v<c-r>=escape(@",'/\')<cr><cr>]])
-- yank marked text/paste to/from global register
vim.keymap.set('n', '<leader>Y', '"+Y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')
-- search and replace
vim.keymap.set('n', '<leader>rr', ':%s/<c-r><c-w>//g<left><left>')
vim.keymap.set('v', '<leader>rr', '"5y:%s/<c-r>5//g<left><left>')
-- default fuzzy find
vim.keymap.set('n', '<leader>f', ':find **/*')
vim.keymap.set('v', '<leader>f', '"0y:find **/*<c-r>0<c-z>')
vim.keymap.set('n', '<leader>F', ':find **/*<c-r><c-w><c-z>')
vim.keymap.set('n', '<leader>e', ':e %:h<c-z>')
vim.keymap.set('n', '<leader>b', ':b <c-z>')
vim.keymap.set('n', '<leader>ju', '<cmd>jumps<cr>')
vim.keymap.set('n', '<leader>mm', '<cmd>marks<cr>')
-- default grep
if vim.fn.executable('rg') > 0 then
   vim.keymap.set('n', '<leader>g', [[:silent grep! ''<left>]])
   vim.keymap.set('v', '<leader>g', [["0y:silent grep! --case-sensitive '<c-r>0'<left>]])
   vim.keymap.set('n', '<leader>G', [[:silent grep! --case-sensitive '<c-r><c-w>'<cr>]])
   vim.keymap.set('n', '<leader>/', [[:silent grep! --hidden --no-ignore ''<left>]])
end
-- diff mode
vim.keymap.set('n', '<leader>du', '<cmd>diffget //3<cr>')
vim.keymap.set('n', '<leader>dh', '<cmd>diffget //2<cr>')
-- vsplit on gf
vim.keymap.set('n', 'gf', '<cmd>vertical wincmd f<cr>', { silent = true })
-- set mark before gd/#/*
vim.keymap.set('n', 'gd', 'mmgd', { silent = true })
vim.keymap.set('n', '#', 'mm#', { silent = true })
vim.keymap.set('n', '*', 'mm*', { silent = true })
-- run ctags in the background
vim.keymap.set('n', '<leader>tg', function()
   if vim.fn.executable('ctags') < 1 then
      print('no ctags installation found')
      return
   end
   local job = vim.fn.jobstart({ 'ctags', '--tag-relative=never', '-G', '-R', '.' })
   print('generate tags..., id: ' .. job)
end)
