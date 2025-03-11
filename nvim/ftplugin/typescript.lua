vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

local config = require('lsp').make_cfg()
config['name'] = 'tsserver'
config['cmd'] = { 'typescript-language-server', '--stdio' }
config['root_dir'] = vim.fs.root(0, { 'package.json', '.git' }) or vim.fn.getcwd()
config['init_options'] = { hostInfo = 'neovim' }
vim.lsp.start(config)
