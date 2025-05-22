-- lua experimental module loader
vim.loader.enable()
-- load essential modules
require("me.options")
require("me.keymaps")
require("me.autocmds")
require("me.lsp")
-- install plugins
local plugins = {
    rose_pine = "https://github.com/rose-pine/neovim.git",
    fugitive = "https://github.com/tpope/vim-fugitive.git",
    signify = "https://github.com/mhinz/vim-signify.git",
    surround = "https://github.com/tpope/vim-surround.git",
    treesitter = "https://github.com/nvim-treesitter/nvim-treesitter.git",
    fzf = "https://github.com/junegunn/fzf.git",
    fzf_vim = "https://github.com/junegunn/fzf.vim.git",
}
local packs = vim.fn.stdpath("data") .. "/site/pack"
for name,repo in pairs(plugins) do
    local plugin_path = packs .. "/" .. name .. "/start/" .. name
    if not vim.uv.fs_stat(plugin_path) then
        vim.fn.system({ "git", "clone", "--depth=1", repo, plugin_path })
    end
    -- load
    local plugin_config = "me.plugins." .. name
    pcall(require, plugin_config)
end
-- fzf runtime path
vim.opt.rtp:append(vim.fn.system("which fzf"):gsub("\n", ""))
