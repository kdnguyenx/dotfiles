" disable compatibility with vi which can cause unexpected issues.
set nocompatible
" encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
" set the characters for the invisibles
set list listchars=tab:›\ ,eol:¬,trail:·
" set default regexp engine to nfa
set regexpengine=2
set title
syntax enable
" disable temporary files.
set nobackup
set noswapfile
" detect filetype
filetype indent on
filetype indent plugin on
filetype plugin on
filetype on
" ftdetect
au BufRead,BufNewFile *.log,*.log{.*} set ft=messages
au BufRead,BufNewFile *.psql setlocal ft=sql
" re-map leader key
nnoremap <space> <nop>
let g:mapleader = ' '
" list of plugins, make sure you use single quotes
call plug#begin()
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'
Plug 'machakann/vim-highlightedyank'
call plug#end()
" language specifi config
au FileType c,cpp,java,python setl sw=4 ts=4 sts=4 et
au FileType javascript,typescript setl sw=2 ts=2 sts=2 et
au FileType go setl sw=4 ts=4 sts=4 noet
au FileType json setl sw=4 ts=4 sts=4 et formatprg=jq
" set default indentation
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set shiftround
" auto read file change
set autoread
set autoindent
" scan to put in completion
set complete=.,w,b,u,t
set completeopt=menu,preview
" sequence of letters which describes how automatic formatting is to be done
set formatoptions=tcqj
" split behaviour
set splitbelow
set splitright
" allow backspacing over listed items
set backspace=indent,eol,start
set visualbell
set updatetime=100
" add numbers to each line on the left-hand side.
set number
set relativenumber
set ruler
set hidden
" this option controls the behavior when switching between buffers
set switchbuf=uselast
" show several useful info
set showcmd
set showmode
set showmatch
set mouse=a
set mousemodel=popup_setpos
" the cursor is kept in the same column
set nostartofline
set ttyfast
set history=10000
" basic theme
set background=dark
set laststatus=2
silent! colorscheme jellybeans
" searching
set incsearch
set hlsearch
set ignorecase
set smartcase
set matchpairs+=<:>
" open the quickfix window whenever a quickfix command is executed
autocmd QuickFixCmdPost [^l]* cwindow
" quick exit some filetypes
autocmd FileType help,qf,diff,fugitive nnoremap <silent> <buffer> q :quit<CR>
" yank marked text/paste to/from global register
nnoremap <leader>Y "+Y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
nnoremap <leader>cf :let @+=expand('%')<CR>
" re-size split windows using arrow keys
nnoremap <Up> :resize +5<CR>
nnoremap <Down> :resize -5<CR>
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>
" command mode navigation
cnoremap <C-a> <home>
cnoremap <C-e> <end>
" navigate through quickfix list
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
" navigate through buffers
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>
" enable auto completion menu after pressing tab.
set wildmenu
set wildoptions=pum,tagfile
set wildmode=full
set wildcharm=<C-z>
set wildignore=*.o,*~,*.a,*.so,*.pyc,*.swp,*.class
set wildignore+=*/target/*,*/build/*,*/generated-sources/*
set wildignore+=*/__pycache__/*,*/node_modules/*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.vscode/*
if has('mac')
  set wildignore+=*/Library/*,*/.DS_Store
endif
" find files
nnoremap <leader>e :e %:h<C-z><C-z>
nnoremap <leader>b :b <C-z>
nnoremap <leader>g :vimgrep //f **<S-Left><S-Left><Right>
vnoremap <leader>g "0y:vimgrep /<C-r>=escape(@0,'/\')<CR>/f **<S-Left><Left><Left><Left>
nnoremap <leader>/ :vimgrep /<C-r><C-w>/f **
nnoremap <leader>ma :marks<CR>
" program to use for the :grep command
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --no-heading\ --column
  set grepformat^=%f:%l:%c:%m
  nnoremap <leader>g :silent grep! '' \| redraw!<S-Left><S-Left><Left><Left>
  vnoremap <leader>g "0y:silent grep! --case-sensitive '<C-r>0' \| redraw!<S-Left><S-Left><Left><Left>
  nnoremap <leader>G :silent grep! --case-sensitive '<C-r><C-w>' \| redraw!<CR>
  nnoremap <leader>/ :silent grep! --hidden --no-ignore '' \| redraw!<S-Left><S-Left><Left><Left>
end
" search current marked text
vnoremap // "0y/\V<C-r>=escape(@0,'/\')<CR><CR>
" find and replace
nnoremap <leader>rr :%s/<C-r><C-w>//gI<Left><Left><Left>
vnoremap <leader>rr "0y:%s/<C-r>=escape(@0,'/\')<CR>//gI<Left><Left><Left>
" unix commands
nnoremap <leader>cp :!cp -r %<C-z> %:h<C-z>
nnoremap <leader>mv :!mv %<C-z> %:h<C-z>
nnoremap <leader>rm :!rm -rf %<C-z>
" set mark before gd/#/*
nnoremap <silent> gd mMgd
nnoremap <silent> # mM#
nnoremap <silent> * mM*
" clear highlights on search when pressing <esc> in normal mode and exit terminal
nnoremap <silent> <Esc> :nohlsearch<CR>
nnoremap - :Explore<CR>
autocmd FileType netrw nnoremap <buffer> <C-c> <Cmd>Rexplore<CR>
" -- plugins configuration --
" fzf options
let g:fzf_vim = {}
let g:fzf_layout = {'down': '41%'}
let g:fzf_vim.preview_window = ['right,41%,<70(up,41%)']
nnoremap <leader>f :Files<CR>
nnoremap <leader>F :GFiles<CR>
" highlight yank duration
let g:highlightedyank_highlight_duration = 100
" diff mode
nnoremap <leader>du :diffget //3<CR>
nnoremap <leader>dh :diffget //2<CR>
