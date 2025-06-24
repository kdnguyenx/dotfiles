" disable compatibility with vi which can cause unexpected issues.
set nocompatible
set regexpengine=2  " set default regexp engine to nfa
set background=dark

" re-map leader key
nnoremap <Space> <Nop>
let g:mapleader = ' '

set encoding=utf-8 fileencoding=utf-8  " encoding
set nobackup noswapfile  " disable temporary files.
set switchbuf=uselast  " this option controls the behavior when switching between buffers
set laststatus=2  " enable statusline

set list lcs=tab:>\ ,trail:-,nbsp:+  " set the characters for the invisibles
set wrap nopaste title visualbell hidden
set showcmd showmode showmatch  " show useful info

" set default indentation
set expandtab smarttab shiftwidth=2 tabstop=2 softtabstop=2 shiftround
set autoread autoindent  " auto read file change and indentation
set incsearch hlsearch smartcase matchpairs+=<:>
set wildmenu wildmode=full wildcharm=<C-z>  " enable auto completion menu after pressing tab.

set splitbelow splitright  " preferred split behaviour
set backspace=indent,eol,start  " allow backspacing over listed items

set mouse=a mousemodel=popup_setpos
set nostartofline  " the cursor is kept in the same column
set ttyfast history=10000

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
