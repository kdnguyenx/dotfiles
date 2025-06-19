vim.g.fzf_layout = { down = "41%" }
vim.g.fzf_vim = { preview_window = { "right,41%,<70(up,41%)" } }
vim.keymap.set("n", "<leader>f", vim.cmd.Files)
vim.keymap.set("n", "<leader>F", vim.cmd.GFiles)
-- fzf runtime path
vim.opt.rtp:append(vim.fn.system("which fzf"):gsub("\n", ""))
