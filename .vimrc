" disable compatibility with vi which can cause unexpected issues.
set nocompatible
set background=dark
set regexpengine=2  " set default regexp engine to nfa

" re-map leader key
nnoremap <Space> <Nop>
let g:mapleader = ' '

set encoding=utf-8 fileencoding=utf-8  " encoding
set nobackup noswapfile  " disable temporary files.
set switchbuf=uselast  " this option controls the behavior when switching between buffers
set laststatus=2  " enable statusline

set list listchars=tab:›\ ,eol:¬,trail:·  " set the characters for the invisibles
set title visualbell hidden
set wrap nopaste
set showcmd showmode showmatch  " show useful info

" set default indentation
set expandtab smarttab shiftwidth=2 tabstop=2 softtabstop=2 shiftround
set autoread autoindent  " auto read file change and indentation
set incsearch hlsearch ignorecase smartcase matchpairs+=<:>
set wildmenu wildmode=full wildcharm=<C-z> wildmenu  " enable auto completion menu after pressing tab.

set splitbelow splitright  " preferred split behaviour
set backspace=indent,eol,start  " allow backspacing over listed items

set mouse=a mousemodel=popup_setpos
set nostartofline  " the cursor is kept in the same column
set ttyfast history=10000
set updatetime=100  " reduce update time for faster response

" re-size split windows using arrow keys
nnoremap <Up> :resize +5<CR>
nnoremap <Down> :resize -5<CR>
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>

" command mode navigation
cnoremap <C-a> <home>
cnoremap <C-e> <end>

" navigate through quickfix list or buffers
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>

" basic find files and grep
nnoremap <leader>e :e %:h<C-z><C-z>
nnoremap <leader>b :b <C-z>
nnoremap <leader>gg :vimgrep //f **<S-Left><S-Left><Right>
vnoremap <leader>gg "0y:vimgrep /<C-r>=escape(@0,'/\')<CR>/f **<S-Left><Left><Left><Left>
nnoremap <leader>gw :vimgrep /<C-r><C-w>/f **

" search current marked text
vnoremap // "0y/\V<C-r>=escape(@0,'/\')<CR><CR>

" find and replace
nnoremap <leader>rr :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <leader>rr "0y:%s/<C-r>=escape(@0,'/\')<CR>//gI<Left><Left><Left>

" yank marked text/paste to/from global register
nnoremap <leader>Y "+Y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

" -----
" neovim specific options
if has('nvim')
  set cursorline
  set inccommand=split  " shows effects of substitute and other commands
  set undofile  " enable undo history

  " quick exit some filetypes
  autocmd FileType help,qf,checkhealth,fugitive,fugitiveblame nnoremap <silent> <buffer> q :quit<CR>
  autocmd QuickFixCmdPost [^l]* cwindow  " open the quickfix window whenever a quickfix command is executed
  autocmd TextYankPost * silent! lua vim.hl.on_yank { higroup='IncSearch', timeout=100 }

  " unix commands
  nnoremap <leader>cp :!cp -r %<C-z> %:h<C-z>
  nnoremap <leader>mv :!mv %<C-z> %:h<C-z>
  nnoremap <leader>rm :!rm -rf %<C-z>

  " program to use for the :grep command
  if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case\ --no-heading\ --column
    set grepformat^=%f:%l:%c:%m
    nnoremap <leader>gg :silent grep! ''<Left>
    vnoremap <leader>gg "0y:silent grep! --case-sensitive '<C-r>0'<Left>
    nnoremap <leader>gw :silent grep! --case-sensitive '<C-r><C-w>'<CR>
    nnoremap <leader>ga :silent grep! --hidden --no-ignore ''<Left>
  endif

  " plugins, make sure you use single quotes
  call plug#begin()
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'rose-pine/neovim', { 'as': 'rose-pine' }
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'mhinz/vim-signify'
  call plug#end()

  " clear highlights on search when pressing <esc> in normal mode
  nnoremap <silent> <Esc> <Cmd>nohlsearch<CR>
  nnoremap - <Cmd>Explore<CR>
  autocmd FileType netrw nnoremap <buffer> <C-c> <Cmd>Rexplore<CR>

  " indent by filetype
  au FileType c,cpp,java,python setl sw=4 ts=4 sts=4 et
  au FileType go setl sw=4 ts=4 sts=4 noet
  au FileType json setl sw=4 ts=4 sts=4 formatprg=jq et
  au FileType javascript,typescript setl sw=2 ts=2 sts=2 et

  " ftdetect
  au BufRead,BufNewFile *.log,*.log{.*} setl ft=messages
  au BufRead,BufNewFile *.psql setl ft=sql

  " custom fzf
  let g:fzf_layout = { 'down': '41%' }
  let g:fzf_vim = { 'preview_window': [ 'right,41%,<70(up,41%)' ] }
  autocmd! FileType fzf set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  nnoremap <leader>ff <Cmd>Files<CR>
  nnoremap <leader>fg <Cmd>GFiles<CR>

  " enable experimental tui
  lua require'vim._extui'.enable { enable = true, msg = { target = 'cmd' } }

  set termguicolors  " enable 24-bit RGB color
  lua require'rose-pine'.setup { dark_variant = 'moon', styles = { italic = false } }
  silent! colorscheme rose-pine
  hi Normal ctermbg=NONE guibg=NONE
  hi NormalNC ctermbg=NONE guibg=NONE

" --
" neovim lua multiple lines config
lua << EOF
-- default for all servers
vim.lsp.config('*', {
  on_attach = function(client, bufnr)
    -- enable inlay hint
    vim.lsp.inlay_hint.enable(true)

    -- mappings.
    -- see `:help vim.lsp.*` for documentation on any of the below functions
    -- lsp navigation keymaps
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr })
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = 'single' }) end, { buffer = bufnr })
    vim.keymap.set('i', '<C-s>', function()
      vim.lsp.buf.signature_help({ border = 'single', title = 'help' })
    end, { buffer = bufnr })

    -- lsp actions
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set('v', 'ga', vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set('n', 'gR', vim.lsp.buf.rename, { buffer = bufnr })

    -- diagnostics keymaps
    vim.keymap.set('n', '<C-p>', function() vim.diagnostic.jump({ count = -1, float = false }) end)
    vim.keymap.set('n', '<C-n>', function() vim.diagnostic.jump({ count = 1, float = false }) end)

    -- diagnostics list
    vim.keymap.set('n', '<leader>xx', function()
      vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
    end)

    -- diagnostic signs
    vim.diagnostic.config({ virtual_text = true, underline = true, float = { border = 'single', } })

    -- completion
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })
  end,
  detached = true,
})

-- clangd
vim.lsp.config('clangd', {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'proto' },
  root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', '.git' }
})

-- pyright
vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  -- root_markers = {
  --   'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt',
  --   'Pipfile', 'pyrightconfig.json', '.git'
  -- },
  root_dir = vim.fn.getcwd(),
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  }
})

-- tsserver
vim.lsp.config('tsserver', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'typescript' },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  init_options = { hostInfo = 'neovim' },
})

-- can be disabled by `:lua vim.lsp.enable('tsserver', false)` for example
vim.lsp.enable({ 'clangd', 'pyright', 'tsserver' })
EOF
endif
