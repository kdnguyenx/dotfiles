-- highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_on_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
  end,
})
-- quick exit some filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "qf", "diff", "fugitive", "fugitiveblame", "dbout" },
  group = vim.api.nvim_create_augroup("quick_exit_filetypes", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.colorcolumn = ""
    vim.keymap.set("n", "q", "<cmd>bd!<cr>", { buffer = true });
  end,
})
-- netrw
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  group = vim.api.nvim_create_augroup("custom_netrw", { clear = true }),
  callback = function()
    vim.opt_local.colorcolumn = ""
    vim.keymap.set("n", "<c-c>", "<cmd>Rexplore<cr>", { buffer = true });
  end,
})
-- open the quickfix window whenever a quickfix command is executed
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "[^l]*",
  group = vim.api.nvim_create_augroup("quickfix_command_execution", { clear = true }),
  callback = function() vim.cmd("cwindow") end,
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
vim.api.nvim_create_autocmd({ "BufWritePost", "VimLeavePre" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("vim_sessionizer", { clear = true }),
  callback = function()
    if #vim.v.argv > 3 then
      return
    end
    if vim.fn.argv(0) == "." or vim.fn.argv(0) == vim.fn.getcwd() then
      local dir = get_session_dir()
      local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      vim.cmd("silent! mksession! " .. dir .. "/" .. name .. ".vim")
    end
  end,
})
-- load session automatically when start vim
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("vim_auto_session", { clear = true }),
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
          vim.cmd("silent! source " .. file)
        elseif choice == 3 then
          vim.fn.delete(file)
        end
      end
    end
  end,
})
-- golden ratio
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("golden_ratio", { clear = true }),
  callback = function()
    if vim.wo.diff or vim.bo.filetype == "telescopeprompt" then
      return
    end
    local golden_ratio = 1.618
    local width = vim.o.columns
    local golden_width = math.floor(width / golden_ratio)
    vim.cmd("silent vertical resize " .. golden_width)
  end,
})
-- diffmode resize
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  group = vim.api.nvim_create_augroup("diff_split_equally", { clear = true }),
  callback = function()
    local width = vim.o.columns
    if vim.fn.winnr("$") > 2 then
      local golden_width = math.floor(width / 3)
      vim.cmd("silent vertical resize " .. golden_width)
      return
    end
    if vim.fn.winnr("$") > 1 then
      local golden_width = math.floor(width / 2)
      vim.cmd("silent vertical resize " .. golden_width)
      return
    end
  end,
})
