-- highlight when yanking text
vim.api.nvim_create_autocmd('textyankpost', {
   group = vim.api.nvim_create_augroup('highlight_on_yank', { clear = true }),
   callback = function()
      vim.highlight.on_yank({ higroup = 'visual', timeout = 300 })
   end
})
-- quick exit some filetypes
vim.api.nvim_create_autocmd('filetype', {
   pattern = { 'help', 'qf', 'diff', 'checkhealth', 'fugitive', 'fugitiveblame', 'dbout' },
   group = vim.api.nvim_create_augroup('quick_exit_filetypes', { clear = true }),
   callback = function()
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<cr>', { noremap = true, silent = true })
   end
})
-- open the quickfix window whenever a quickfix command is executed
vim.api.nvim_create_autocmd('quickfixcmdpost', {
   pattern = '[^l]*',
   group = vim.api.nvim_create_augroup('quickfix_command_execution', { clear = true }),
   callback = function() vim.cmd('cwindow') end
})
-- create session directory if it does not exist
local function get_session_dir()
   local dir = vim.fn.stdpath('data') .. '/sessions'
   if not vim.fn.isdirectory(dir) then
      vim.fn.mkdir(dir, 'p')
   end
   return dir
end
-- make session automatically when save a buffer or exit vim
vim.api.nvim_create_autocmd({ 'bufwritepost', 'vimleavepre' }, {
   pattern = '*',
   group = vim.api.nvim_create_augroup('vim_sessionizer', { clear = true }),
   callback = function()
      if #vim.v.argv > 3 then
         return
      end
      if #vim.fn.argv() > 0 and vim.fn.argv(0) ~= vim.fn.getcwd() then
         return
      end

      local dir = get_session_dir()
      local name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      vim.cmd('silent! mksession! ' .. dir .. '/' .. name .. '.vim')
   end
})
-- load session automatically when start vim
vim.api.nvim_create_autocmd('vimenter', {
   pattern = '*',
   group = vim.api.nvim_create_augroup('vim_auto_session', { clear = true }),
   callback = function()
      if #vim.v.argv > 3 then
         return
      end
      if #vim.fn.argv() > 0 and vim.fn.argv(0) ~= vim.fn.getcwd() then
         return
      end

      local dir = get_session_dir()
      local name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      local file = dir .. '/' .. name .. '.vim'

      if vim.fn.filereadable(file) == 1 then
         local choice = vim.fn.confirm('', 'load your stuff? &yeah\n&nah\n&clear', 2)
         if choice == 1 then
            vim.cmd('silent! source ' .. file)
         elseif choice == 3 then
            vim.fn.delete(file)
         end
      end
   end
})
-- golden ratio
vim.api.nvim_create_autocmd('WinEnter', {
   pattern = '*',
   callback = function()
      if vim.wo.diff or vim.bo.filetype == 'TelescopePrompt' then
         return
      end

      local golden_ratio = 1.618
      local width = vim.o.columns
      local golden_width = math.floor(width / golden_ratio)
      vim.cmd("silent vertical resize " .. golden_width)
   end
})
-- diffmore resize
vim.api.nvim_create_autocmd('optionset', {
   pattern = 'diff',
   callback = function()
      local width = vim.o.columns
      if vim.fn.winnr('$') > 2 then
         local golden_width = math.floor(width / 3)
         vim.cmd('silent vertical resize ' .. golden_width)
         return
      end
      if vim.fn.winnr('$') > 1 then
         local golden_width = math.floor(width / 2)
         vim.cmd('silent vertical resize ' .. golden_width)
         return
      end
   end
})
